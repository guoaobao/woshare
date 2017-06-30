//
//  GeeGoodLukeListView.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/24.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeGoodLukeListView.h"
#import "GeeGoodLuckTableViewCell.h"

#import "EGORefreshTableHeaderView.h"
#import "RequestManager.h"
#import "EventWinnerResponse.h"

@interface GeeGoodLukeListView ()
<UITableViewDelegate,
UITableViewDataSource,
EGORefreshTableHeaderDelegate,
RequestManagerDelegate,
UIScrollViewDelegate
>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) EGORefreshTableHeaderView *refreshView;
@property(nonatomic, assign) BOOL isReloading;

@property(nonatomic, strong) NSDictionary *requestDict;
@property(nonatomic, assign) RequestType requestType;

@property(nonatomic, strong) NSArray *contentArray;

@property(nonatomic, assign) BOOL firstFlag;

@end

@implementation GeeGoodLukeListView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.firstFlag = YES;
        
        UITableView *tableView = [[UITableView alloc]init];
        self.tableView = tableView;
        tableView.delegate = self;
        tableView.dataSource = self;
        [self addSubview:tableView];
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
        [self addSubview:tableView];
        
        if (self.refreshView == nil) {
            EGORefreshTableHeaderView *view =[[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - tableView.bounds.size.height, tableView.frame.size.width, tableView.bounds.size.height)];
            view.delegate = self;
            [tableView addSubview:view];
            self.refreshView = view;
        }
    }
    return self;
}

- (void)firstRefreshData:(NSDictionary *)dict andInterFace:(RequestType)interface
{
    self.tableView.contentOffset = CGPointMake(0, 0);
    __weak GeeGoodLukeListView *weakself = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakself.tableView.contentOffset = CGPointMake(0, -99);
        [weakself.refreshView egoRefreshScrollViewDidScroll:weakself.tableView];
    } completion:^(BOOL finished) {
        [weakself.refreshView egoRefreshScrollViewDidEndDragging:weakself.tableView];
    }];
    
    self.requestDict = dict;
    self.requestType = interface;
    
    self.isReloading = YES;
    [[RequestManager sharedManager]addDelegate:self];
    [[RequestManager sharedManager]startRequestWithType:interface withData:dict];
}

- (void)layoutSubviews
{
    if (self.firstFlag) {
        self.firstFlag = NO;
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"eventid"] = self.eventInfo.eventid?:@"";
        [self firstRefreshData:dict andInterFace:kRequestTypeGetEventWinnerList];
        
    }
    
    self.tableView.frame = self.bounds;
}

#pragma mark -- 下拉刷新代理方法
-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    if (self.isReloading) {
        return;
    }
    
    self.isReloading = YES;
    NSLog(@"开始");
    
    [[RequestManager sharedManager]addDelegate:self];
    [[RequestManager sharedManager]startRequestWithType:self.requestType withData:self.requestDict];
    
}

-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return self.isReloading; // should return if data source model is reloading
    
}

-(NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return[NSDate date]; // should return date data source was last changed
    
}

#pragma mark -- RequestManager代理
-(void)webServiceRequest:(RequestType)requestType response:(id)response userData:(id)userData originalData:(id)data
{
    if (data == nil) {
        
        
        self.isReloading = NO;
        [self.refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
        
        return;
    }
    
    if (requestType == kRequestTypeGetEventWinnerList) {
        self.contentArray = (NSMutableArray*)[NSArray arrayWithArray:response];
        [self.tableView reloadData];
    }
    
    self.isReloading = NO;
    [self.refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    
    
}

- (void)webServiceRequest:(RequestType)requestType error:(NSError *)error userData:(id)userData
{
    self.isReloading = NO;
    [self.refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    
    
}

- (void)webServiceRequest:(RequestType)requestType errorString:(NSString *)errorString userData:(id)userData
{
    NSLog(@"%@",errorString);
    self.isReloading = NO;
    [self.refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    
    
}


#pragma mark -- scrollView代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.refreshView egoRefreshScrollViewDidScroll:scrollView];
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [self.refreshView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GeeGoodLuckTableViewCell *cell = [GeeGoodLuckTableViewCell cellForTableView:tableView];
    cell.eventWinner = [self.contentArray objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
