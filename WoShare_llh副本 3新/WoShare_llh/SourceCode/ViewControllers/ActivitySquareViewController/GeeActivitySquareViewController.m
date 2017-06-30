//
//  GeeActivitySquareViewController.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/22.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeActivitySquareViewController.h"
#import "GeeActivitySquareTableViewCell.h"

#import "GeeActivityDetailViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "RequestManager.h"

@interface GeeActivitySquareViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
EGORefreshTableHeaderDelegate,
RequestManagerDelegate
>

@property(nonatomic, strong) EGORefreshTableHeaderView *refreshView;
@property(nonatomic, assign) BOOL isReloading;

@property(nonatomic, strong) UITableView *mainTableView;

@property(nonatomic, strong) NSDictionary *requestDict;
@property(nonatomic, assign) RequestType requestType;



@property(nonatomic, strong) NSMutableArray *eventArray;//gab

@end

@implementation GeeActivitySquareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"活动广场";
    
    [self setNavBackButton];
    [self setupViewOfController];
    
    NSDictionary *dic = @{@"eventstatus":[NSString stringWithFormat:@"%d",kEventStatusAll]
                          };
    [self firstRefreshData:dic andInterFace:kRequestTypeGetEventList];
}

- (void)setupViewOfController
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-64);
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor colorFromHexRGB:@"f0f0f0"];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView = tableView;
    
    if (self.refreshView == nil) {
        EGORefreshTableHeaderView *view =[[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - tableView.bounds.size.height, self.view.frame.size.width, tableView.bounds.size.height)];
        view.delegate = self;
        [tableView addSubview:view];
        self.refreshView = view;
    }
}


- (void)firstRefreshData:(NSDictionary *)dict andInterFace:(RequestType)interface
{
    self.mainTableView.contentOffset = CGPointMake(0, 0);
    __weak GeeActivitySquareViewController *weakself = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakself.mainTableView.contentOffset = CGPointMake(0, -99);
        [weakself.refreshView egoRefreshScrollViewDidScroll:weakself.mainTableView];
    } completion:^(BOOL finished) {
        [weakself.refreshView egoRefreshScrollViewDidEndDragging:weakself.mainTableView];
    }];
    
    self.requestDict = dict;
    self.requestType = interface;
    
    self.isReloading = YES;
    [[RequestManager sharedManager]addDelegate:self];
    [[RequestManager sharedManager]startRequestWithType:interface withData:dict];
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
        
        [self toast:@"获取数据失败"];
        
        self.isReloading = NO;
        [self.refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self.mainTableView];
        
        return;
    }
    
    if (requestType == kRequestTypeGetEventList) {
        //        self.eventArray = (NSMutableArray*)[NSArray arrayWithArray:response];
        self.eventArray=[NSMutableArray arrayWithArray:response];
        NSMutableArray *gabMutableArr=[NSMutableArray arrayWithArray:self.eventArray];
        for (EventResponse *response in gabMutableArr)//gab
        {       if (response.eventstatus==4)
        {
            [self.eventArray removeObject:response];
        }
        }

        
        [self.mainTableView reloadData];
    }
    
    self.isReloading = NO;
    [self.refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self.mainTableView];
    
    
    [self hideIndicator];
}

- (void)webServiceRequest:(RequestType)requestType error:(NSError *)error userData:(id)userData
{
    [self toast:@"出错了~"];
    self.isReloading = NO;
    [self.refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self.mainTableView];
    
    
    [self hideIndicator];
}

- (void)webServiceRequest:(RequestType)requestType errorString:(NSString *)errorString userData:(id)userData
{
    
    [self toast:errorString];
    self.isReloading = NO;
    [self.refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self.mainTableView];
    
    
    [self hideIndicator];
}


#pragma mark -- scrollView代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.refreshView egoRefreshScrollViewDidScroll:scrollView];
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [self.refreshView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark -- UITableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.eventArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GeeActivitySquareTableViewCell *cell = [GeeActivitySquareTableViewCell cellForTableView:tableView];
    EventResponse *event = [self.eventArray objectAtIndex:indexPath.section];
    cell.eventInfo = event;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (ScreenWidth-2*5)/1.92;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GeeActivityDetailViewController *vc = [[GeeActivityDetailViewController alloc]init];
    EventResponse *event = [self.eventArray objectAtIndex:indexPath.section];
    vc.eventInfo = event;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
