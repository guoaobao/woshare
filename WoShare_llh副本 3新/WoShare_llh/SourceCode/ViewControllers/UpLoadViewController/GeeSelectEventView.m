//
//  GeeSelectEventView.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/7/18.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeSelectEventView.h"
#import "GeeSelectEventCollectionCell.h"

#import "EGORefreshTableHeaderView.h"
#import "RequestManager.h"

@interface GeeSelectEventView ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
EGORefreshTableHeaderDelegate,
UIScrollViewDelegate,
RequestManagerDelegate
>

@property(nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic, strong) EGORefreshTableHeaderView *refreshView;
@property(nonatomic, assign) BOOL isReloading;

@property(nonatomic, strong) NSDictionary *requestDict;
@property(nonatomic, assign) RequestType requestType;

@property(nonatomic, strong) NSArray *contentArray;

@property(nonatomic, assign) BOOL firstFlag;

@end

@implementation GeeSelectEventView


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.firstFlag = YES;
        
        self.frame = CGRectMake(0, ScreenHeight-40-200-64, ScreenWidth, 200);
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:flowLayout];
        self.collectionView = collectionView;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.alwaysBounceVertical = YES;
        [collectionView registerClass:[GeeSelectEventCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([GeeSelectEventCollectionCell class])];
        self.backgroundColor = [UIColor whiteColor];
        collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:collectionView];
        
        if (self.refreshView == nil) {
            EGORefreshTableHeaderView *view =[[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - collectionView.bounds.size.height, collectionView.frame.size.width, collectionView.bounds.size.height)];
            view.delegate = self;
            [collectionView addSubview:view];
            self.refreshView = view;
        }
    }
    return self;
}


- (void)firstRefreshData:(NSDictionary *)dict andInterFace:(RequestType)interface
{
    self.collectionView.contentOffset = CGPointMake(0, 0);
    __weak GeeSelectEventView *weakself = self;
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
        
        NSDictionary *dic = @{@"eventstatus":[NSString stringWithFormat:@"%d",kEventStatusOnline]
                              };
        [self firstRefreshData:dic andInterFace:kRequestTypeGetEventList];
        
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
    
    if (requestType == kRequestTypeGetEventList) {
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

#pragma mark -- UICollectionViewDatasourceDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.contentArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GeeSelectEventCollectionCell *cell = [GeeSelectEventCollectionCell cellForCollection:collectionView forIndex:indexPath];
    cell.eventinfo = [self.contentArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.eventSelectedAtIndex) {
        self.eventSelectedAtIndex([self.contentArray objectAtIndex:indexPath.row]);
    }
}

#pragma mark -- UICollectionViewFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth-4*11)/3, 30);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


@end
