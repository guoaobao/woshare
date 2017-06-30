//
//  GeeActContentListView.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/24.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeActContentListView.h"
#import "GeeActContentCollectionViewCell.h"

#import "EGORefreshTableHeaderView.h"
#import "RequestManager.h"



@interface GeeActContentListView ()
<EGORefreshTableHeaderDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
UIScrollViewDelegate,
RequestManagerDelegate>

@property(nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic, strong) EGORefreshTableHeaderView *refreshView;
@property(nonatomic, assign) BOOL isReloading;

@property(nonatomic, strong) NSDictionary *requestDict;
@property(nonatomic, assign) RequestType requestType;

@property(nonatomic, strong) NSArray *contentArray;

@property(nonatomic, assign) BOOL firstFlag;

@end

@implementation GeeActContentListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.firstFlag = YES;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)
                                                      collectionViewLayout:layout];
        collect.alwaysBounceVertical = YES;
        [self addSubview:collect];
        collect.backgroundColor = [UIColor whiteColor];
        self.collectionView = collect;
        collect.delegate = self;
        collect.dataSource = self;
        [collect registerClass:[GeeActContentCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([GeeActContentCollectionViewCell class])];
        
        if (self.refreshView == nil) {
            EGORefreshTableHeaderView *view =[[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - collect.bounds.size.height, collect.frame.size.width, collect.bounds.size.height)];
            view.delegate = self;
            [collect addSubview:view];
            self.refreshView = view;
        }
    }
    return self;
}

- (void)firstRefreshData:(NSDictionary *)dict andInterFace:(RequestType)interface
{
    self.collectionView.contentOffset = CGPointMake(0, 0);
    __weak GeeActContentListView *weakself = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakself.collectionView.contentOffset = CGPointMake(0, -99);
        [weakself.refreshView egoRefreshScrollViewDidScroll:weakself.collectionView];
    } completion:^(BOOL finished) {
        [weakself.refreshView egoRefreshScrollViewDidEndDragging:weakself.collectionView];
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
        dict[@"cateid"] = @"127";
        dict[@"rows"] = @"20";
        dict[@"getcomment"] = @"1";
        dict[@"getns"] = @"1";
        dict[@"getuserinfo"] = @"1";
        dict[@"page"] = @"1";
        dict[@"eventid"] = self.eventInfo.eventid?:@"";
        [self firstRefreshData:dict andInterFace:kRequestTypeQSearchinfo];
        
    }
    
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
        [self.refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self.collectionView];
        
        return;
    }
    
    if (requestType == kRequestTypeQSearchinfo) {
        self.contentArray = (NSMutableArray*)[NSArray arrayWithArray:response];
        [self.collectionView reloadData];
    }
    
    self.isReloading = NO;
    [self.refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self.collectionView];
    
    
}

- (void)webServiceRequest:(RequestType)requestType error:(NSError *)error userData:(id)userData
{
    self.isReloading = NO;
    [self.refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self.collectionView];
    
    
}

- (void)webServiceRequest:(RequestType)requestType errorString:(NSString *)errorString userData:(id)userData
{
    
    self.isReloading = NO;
    [self.refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self.collectionView];
    
    
}


#pragma mark -- scrollView代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.refreshView egoRefreshScrollViewDidScroll:scrollView];
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [self.refreshView egoRefreshScrollViewDidEndDragging:scrollView];
}


#pragma mark -- UICollectionView代理
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.resourceItemClicked) {
        self.resourceItemClicked([self.contentArray objectAtIndex:indexPath.row]);
    }
}

#pragma mark -- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.contentArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GeeActContentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GeeActContentCollectionViewCell class]) forIndexPath:indexPath];
    cell.info = [self.contentArray objectAtIndex:indexPath.row];
    return cell;
}
#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.frame.size.width/2-15/2, (self.frame.size.width/2-15/2)*0.8);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


@end
