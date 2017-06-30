//
//  GeeBaseShareSquareViewController.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/27.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeBaseShareSquareViewController.h"
#import "GeeShowGifViewController.h"
#import "GeeQuickReplyView.h"
#import "GeeMoviePlayerViewController.h"
#import "KxMovieViewController.h"
#import "GeePictureScanViewController.h"
#import "WXApi.h"
#import "GeeUserResourceViewController.h"

#import "GeeShareManager.h"
#import "GeeUserHeaderView.h"


@interface GeeBaseShareSquareViewController ()
<
EGORefreshTableHeaderDelegate,
UIScrollViewDelegate,
UITableViewDelegate,
UITableViewDataSource,
RequestManagerDelegate
>


@property(nonatomic, assign) BOOL loadMore;
@property(nonatomic, assign) NSInteger totlalNum;

@property(nonatomic, strong) GeeShareManager *sharemanager;

@property(nonatomic, strong) UITableView *mainTableView;
@property(nonatomic, strong) EGORefreshTableHeaderView *refreshView;

@property(nonatomic, assign) BOOL isReloading;

@property(nonatomic, strong) NSArray *resourceArray;

@property(nonatomic, strong) GeeBaseShareSquareTableHeaderView *headerView;

@property(nonatomic, assign) NSInteger selectedIndex;

@property(nonatomic, assign) NSInteger dataResourceIndex;
@property(nonatomic, strong) NSArray *dataCacheOneArray;
@property(nonatomic, strong) NSArray *dataCacheTwoArray;
@property(nonatomic, strong) NSArray *dataCacheThreeArray;

@end

@implementation GeeBaseShareSquareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupViewOfController];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeTop;

    self.dataResourceIndex = 0;
    self.dataCacheOneArray = nil;
    self.dataCacheTwoArray = nil;
    self.dataCacheThreeArray = nil;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (self.isReloading) {
        self.isReloading = NO;
        [self.refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self.mainTableView];
    }
    
    if (self.loadMore) {
        self.loadMore = NO;
    }
}

- (GeeShareManager *)sharemanager
{
    if (_sharemanager == nil) {
        _sharemanager = [[GeeShareManager alloc]init];
    }
    return _sharemanager;
}

- (void)setupViewOfController
{
    UIButton *more = [[UIButton alloc]init];
    more.frame = CGRectMake(0, 0, 30, 30);
    [more setImage:[UIImage imageNamed:@"icon-gengduo"] forState:UIControlStateNormal];
    UIBarButtonItem *litem = [[UIBarButtonItem alloc]initWithCustomView:more];
    [more addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = litem;
    
    UIButton *act = [[UIButton alloc]init];
    NSString *str = @"活动广场";
    UIFont *font = [UIFont systemFontOfSize:13];
    CGSize size = [str caculateSizeByFont:font];
    act.frame = CGRectMake(0, 0, size.width, 30);
    act.titleLabel.font = font;
    [act setTitle:@"活动广场" forState:UIControlStateNormal];
    UIBarButtonItem *ritem = [[UIBarButtonItem alloc]initWithCustomView:act];
    self.navigationItem.rightBarButtonItem = ritem;
    [act addTarget:self action:@selector(activitySquareButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.mainTableView = tableView;
    [self.view addSubview:tableView];
    tableView.frame = CGRectMake(0, 40, ScreenWidth, ScreenHeight-64-40);//gab-49;
    tableView.backgroundColor = [UIColor colorFromHexRGB:@"f0f0f0"];
    GeeBaseShareSquareTableHeaderView *header = [[GeeBaseShareSquareTableHeaderView alloc]init];
    self.headerView = header;
    __weak GeeBaseShareSquareViewController *weakself = self;
    header.headerViewChangged = ^(NSInteger index) {
        
        if (weakself.isReloading) {
            return;
        }
        
        weakself.dataResourceIndex = index;
        
        if (weakself.dataResourceIndex == 0) {
            
            if (weakself.dataCacheOneArray) {
                weakself.resourceArray = weakself.dataCacheOneArray;
                
                [weakself.mainTableView reloadData];
                [weakself.mainTableView setContentOffset:CGPointMake(0, 0) animated:YES];
                
                [weakself resouceChangedWithoutRequest:index];
            } else {
                [weakself.mainTableView setContentOffset:CGPointMake(0, 0) animated:NO];
                [weakself resouceChanged:index];
            }
            
        } else if (weakself.dataResourceIndex == 1) {
            
            if (weakself.dataCacheTwoArray) {
                weakself.resourceArray = weakself.dataCacheTwoArray;
                
                [weakself.mainTableView reloadData];
                [weakself.mainTableView setContentOffset:CGPointMake(0, 0) animated:YES];
                [weakself resouceChangedWithoutRequest:index];
            } else {
                [weakself.mainTableView setContentOffset:CGPointMake(0, 0) animated:NO];
                [weakself resouceChanged:index];
            }
            
        } else if (weakself.dataResourceIndex == 2) {
            
            if (weakself.dataCacheThreeArray) {
                weakself.resourceArray = weakself.dataCacheThreeArray;
                
                [weakself.mainTableView reloadData];
                [weakself.mainTableView setContentOffset:CGPointMake(0, 0) animated:YES];
                [weakself resouceChangedWithoutRequest:index];
            } else {
                [weakself.mainTableView setContentOffset:CGPointMake(0, 0) animated:NO];
                [weakself resouceChanged:index];
            }
            
        }
        
    };
    header.frame = CGRectMake(0, 0, ScreenWidth, 40);
    [self.view addSubview:header];
    self.headerView = header;
//    tableView.tableHeaderView = header;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (self.refreshView == nil) {
        EGORefreshTableHeaderView *view =[[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - tableView.bounds.size.height, self.view.frame.size.width, tableView.bounds.size.height)];
        view.delegate = self;
        [tableView addSubview:view];
        self.refreshView = view;
    }
    tableView.delegate = self;
    tableView.dataSource = self;
    
    //gab
    /*
    UIView *backView = [[UIView alloc]init];
    backView.frame = CGRectMake(0, ScreenHeight-64-49, ScreenWidth, 49);
    backView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nav_barbackground"]];
    [self.view addSubview:backView];
    
    UIButton *add = [[UIButton alloc]init];
    [add setImage:[UIImage imageNamed:@"icon-add"] forState:UIControlStateNormal];
    add.frame = CGRectMake(ScreenWidth/2-25, -10, 50, 50);
    [add addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:add];
    */
}

- (void)setupUserHeaderView:(InfoListResponse *)resource
{
    GeeUserHeaderView *header = [[GeeUserHeaderView alloc]init];
    header.resourceInfo = resource;
    self.mainTableView.tableHeaderView = header;
}

- (void)addButtonClicked
{
    GeeUpLoadViewController *vc = [[GeeUpLoadViewController alloc]init];
    
    if (![RequestManager sharedManager].isLogined) {
        [[AppDelegate sharedAppDelegate]showLoginFrom:self successToViewController:vc];
        return ;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)moreButtonClicked
{
    [[AppDelegate sharedAppDelegate].sideViewController pushOldViewControllerOnDirection:PPRevealSideDirectionLeft animated:YES];
}

- (void)activitySquareButtonClicked
{
    GeeActivitySquareViewController *vc = [[GeeActivitySquareViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)refreshData:(NSDictionary *)dict andInterface:(RequestType)interface
{
    
    [self.mainTableView setContentOffset:CGPointMake(0, 0) animated:NO];
    __weak GeeBaseShareSquareViewController *weakself = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakself.mainTableView.contentOffset = CGPointMake(0, -99);
        [weakself.refreshView egoRefreshScrollViewDidScroll:weakself.mainTableView];
    } completion:^(BOOL finished) {
//        weakself.mainTableView.contentOffset = CGPointMake(0, -99);
        [weakself.refreshView egoRefreshScrollViewDidEndDragging:weakself.mainTableView];
    }];
    
    self.requestDict = dict;
    self.requestType = interface;
}

- (void)refreshDataWithoutRequest:(NSDictionary *)dict andInterface:(RequestType)interface
{
    [self.mainTableView setContentOffset:CGPointMake(0, 0) animated:NO];
    self.requestDict = dict;
    self.requestType = interface;
}


- (void)firstRefreshData:(NSDictionary *)dict andInterFace:(RequestType)interface
{
    self.mainTableView.contentOffset = CGPointMake(0, 0);
    __weak GeeBaseShareSquareViewController *weakself = self;
    [UIView animateWithDuration:0.2 animations:^{
        weakself.mainTableView.contentOffset = CGPointMake(0, -99);
        [weakself.refreshView egoRefreshScrollViewDidScroll:weakself.mainTableView];
    } completion:^(BOOL finished) {
//        weakself.mainTableView.contentOffset = CGPointMake(0, -99);
        [weakself.refreshView egoRefreshScrollViewDidEndDragging:weakself.mainTableView];
    }];
    
    self.requestDict = dict;
    self.requestType = interface;
    
    self.isReloading = YES;
    [[RequestManager sharedManager]addDelegate:self];
    [[RequestManager sharedManager]startRequestWithType:interface withData:dict];
}

- (void)resouceChanged:(NSInteger)index
{
    if (index == 0) {
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"cateid"] = @"127";
        dict[@"rows"] = @"20";
        dict[@"getcomment"] = @"1";
        dict[@"getns"] = @"1";
        dict[@"getuserinfo"] = @"1";
        dict[@"page"] = @"1";
        dict[@"ft"] = @"1";
        dict[@"order"] = @"hot";
        [self refreshData:dict andInterface:kRequestTypeQSearchinfo];
        
    } else if (index == 1) {
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"cateid"] = @"127";
        dict[@"rows"] = @"20";
        dict[@"getcomment"] = @"1";
        dict[@"getns"] = @"1";
        dict[@"getuserinfo"] = @"1";
        dict[@"page"] = @"1";
        dict[@"ft"] = @"3";
        dict[@"order"] = @"hot";
        [self refreshData:dict andInterface:kRequestTypeQSearchinfo];
    } else if (index == 2) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"cateid"] = @"127";
        dict[@"rows"] = @"20";
        dict[@"getcomment"] = @"1";
        dict[@"getns"] = @"1";
        dict[@"getuserinfo"] = @"1";
        dict[@"page"] = @"1";
        [self refreshData:dict andInterface:kRequestTypeQSearchinfo];
    }
}

- (void)resouceChangedWithoutRequest:(NSInteger)index
{
    if (index == 0) {
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"cateid"] = @"127";
        dict[@"rows"] = @"20";
        dict[@"getcomment"] = @"1";
        dict[@"getns"] = @"1";
        dict[@"getuserinfo"] = @"1";
        dict[@"page"] = @"1";
        dict[@"ft"] = @"1";
        dict[@"order"] = @"hot";
        self.requestDict = dict;
        self.requestType = kRequestTypeQSearchinfo;
        
    } else if (index == 1) {
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"cateid"] = @"127";
        dict[@"rows"] = @"20";
        dict[@"getcomment"] = @"1";
        dict[@"getns"] = @"1";
        dict[@"getuserinfo"] = @"1";
        dict[@"page"] = @"1";
        dict[@"ft"] = @"3";
        dict[@"order"] = @"hot";
        self.requestDict = dict;
        self.requestType = kRequestTypeQSearchinfo;
    } else if (index == 2) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"cateid"] = @"127";
        dict[@"rows"] = @"20";
        dict[@"getcomment"] = @"1";
        dict[@"getns"] = @"1";
        dict[@"getuserinfo"] = @"1";
        dict[@"page"] = @"1";
        self.requestDict = dict;
        self.requestType = kRequestTypeQSearchinfo;
    }
}

- (void)setupTableViewHeader
{
    
}

- (void)hideTableViewHeader
{
//    self.mainTableView.tableHeaderView = nil;
    [self.headerView removeFromSuperview];
    self.mainTableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-64);//gab-49;
}


- (void)LikeRequest:(InfoListResponse*)info
{
    NSDictionary *dic = @{@"infoid": info==nil?@"":info._id};
    [[RequestManager sharedManager]addDelegate:self];
    [[RequestManager sharedManager]startRequestWithType:kRequestTypeLikeInfo withData:dic];
}


-(void)collectRequest:(InfoListResponse*)info
{
    NSDictionary *dic = @{@"favid": info==nil?@"":info._id,
                          @"idtype":@"info"};
    [[RequestManager sharedManager]addDelegate:self];
    [[RequestManager sharedManager]startRequestWithType:kRequestTypeAddFavorite withData:dic];
}


- (void)commentRequest:(NSString *)text  index:(NSInteger)clickIndex
{
    InfoListResponse *info = [self.resourceArray objectAtIndex:clickIndex];
    NSDictionary *dic = @{@"id": info._id?:@"",
                          @"content":text,
                          @"idtype":@"info"
                          };
    [[RequestManager sharedManager]addDelegate:self];
    [[RequestManager sharedManager]startRequestWithType:kRequestTypeAddComment withData:dic];

}

-(void)resourceButton:(InfoListResponse *)info
{
    if ([info.resourceArray count]==1) {
        ResourceInfo  *res = (ResourceInfo*)[info.resourceArray objectAtIndex:0];
        if (res.type == kResourceVideo) {
            if ([res.playUrl length]>0) {
                //播放
//                GeeMoviePlayerViewController *player = [[GeeMoviePlayerViewController alloc]init];
//                player.playUrl = res.playUrl;
//                [self.navigationController pushViewController:player animated:YES];
                NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
                NSString *path=res.playUrl;
                // increase buffering for .wmv, it solves problem with delaying audio frames
                if ([path.pathExtension isEqualToString:@"wmv"])
                    parameters[KxMovieParameterMinBufferedDuration] = @(5.0);
                // disable deinterlacing for iPhone, because it's complex operation can cause stuttering
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                    parameters[KxMovieParameterDisableDeinterlacing] = @(YES);
                KxMovieViewController *vc = [KxMovieViewController movieViewControllerWithContentPath:path
                                                                                           parameters:parameters];
                [self.navigationController pushViewController:vc animated:YES];

                
            }
        }
        else if ([res.ext isEqualToString:@"gif"])
        {
            [self showGif:res.playUrl];
        }
        else
        {
            //照片预览
            
            GeePictureScanViewController *vc = [[GeePictureScanViewController alloc]init];
            vc.infoList = info;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else
    {
        //照片预览
        GeePictureScanViewController *vc = [[GeePictureScanViewController alloc]init];
        vc.infoList = info;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)showGif:(NSString *)url
{
    GeeShowGifViewController *vc = [[GeeShowGifViewController alloc]init];
    vc.gifUrl = url;
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark -- tableView代理

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.resourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GeeBaseShareSquareTableViewCell *cell = [GeeBaseShareSquareTableViewCell cellForTableView:tableView];
    cell.info = [self.resourceArray objectAtIndex:indexPath.section];
    __weak GeeBaseShareSquareViewController *weakself = self;
    cell.playButtonClicked = ^() {
        if (![RequestManager sharedManager].isLogined)
        {
            [[AppDelegate sharedAppDelegate] showLoginFrom:weakself successToViewController:nil];
            return;
        }
        InfoListResponse *info = [weakself.resourceArray objectAtIndex:indexPath.section];
        
        [weakself resourceButton:info];
        
    };
    
    cell.userHeadButtonClicked = ^() {
        
        if (![RequestManager sharedManager].isLogined) {
            [[AppDelegate sharedAppDelegate]showLoginFrom:weakself successToViewController:nil];
            return ;
        }
        
        GeeUserResourceViewController *res = [[GeeUserResourceViewController alloc]init];
        res.resourceInfo = [weakself.resourceArray objectAtIndex:indexPath.section];
        [weakself.navigationController pushViewController:res animated:YES];
        
    };
    
    cell.clickFrequencyButtonClicked = ^() {
        
    };
    
    cell.likeButtonClicked = ^() {
        
        if (![RequestManager sharedManager].isLogined) {
            [[AppDelegate sharedAppDelegate]showLoginFrom:weakself successToViewController:nil];
            return ;
        }
        
        InfoListResponse *info = [weakself.resourceArray objectAtIndex:indexPath.section];
        [weakself LikeRequest:info];
        
        weakself.selectedIndex = indexPath.section;
    };
    
    cell.collectButtonClicked = ^() {
        
        if (![RequestManager sharedManager].isLogined) {
            [[AppDelegate sharedAppDelegate]showLoginFrom:weakself successToViewController:nil];
            return ;
        }
        
        InfoListResponse *info = [weakself.resourceArray objectAtIndex:indexPath.section];
        [weakself collectRequest:info];
        
        weakself.selectedIndex = indexPath.section;
    };
    
    cell.commentuttonClicked = ^() {
        
        if (![RequestManager sharedManager].isLogined) {
            [[AppDelegate sharedAppDelegate]showLoginFrom:weakself successToViewController:nil];
            return ;
        }
        
        GeeQuickReplyView *view = [[GeeQuickReplyView alloc]init];
        
        view.sendButtonClicked = ^(NSString *text) {
            [weakself commentRequest:text index:indexPath.section];
        };
        [[UIApplication sharedApplication].keyWindow addSubview:view];
        
        weakself.selectedIndex = indexPath.section;
    };
    
    InfoListResponse *cellinfo = cell.info;
    cell.shareButtonClicked = ^() {
        GeeShareView *share = [[GeeShareView alloc]init];
        
        share.shareToSina = ^(void) {
            
            weakself.sharemanager.info = cellinfo;
            [weakself.sharemanager shareToSina];
            
        };
        
        share.shareToWechat = ^(void) {
            
            weakself.sharemanager.info = cellinfo;
            [weakself.sharemanager sendLinkContent];
        };
        
        share.shareToWechatFriend = ^(void) {
            weakself.sharemanager.info = cellinfo;
            [weakself.sharemanager sendLinkContentToWechatFriend];
        };
        
        share.shareToQQFriend = ^(void) {
            weakself.sharemanager.info = cellinfo;
            [weakself.sharemanager sendLinkToQQFriend];
        };
        
        [[UIApplication sharedApplication].keyWindow addSubview:share];
        
        weakself.selectedIndex = indexPath.section;
    };
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    InfoListResponse *info = [self.resourceArray objectAtIndex:indexPath.section];
    
    if (info.infoType == kInfoTypeTheme) {
        
        CGRect rect2 = [info.content caculateRectByFont:[UIFont systemFontOfSize:FontSize] ByConstrainedSize:CGSizeMake(ScreenWidth-2*10, MAXFLOAT)];
        return (5+35+5+25+5+rect2.size.height+5+1+5+25+5);
    }
    else if (info.resourceArray.count > 0) {
        return (5+35+5+25+5+(ScreenWidth-2*5)/2+5+1+5+25+5);
    } else {
        return (5+35+5+25+5+5+1+5+25+5);
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    GeeDetailInfoViewController *vc = [[GeeDetailInfoViewController alloc]init];
    
    vc.resourceInfo = [self.resourceArray objectAtIndex:indexPath.section];
    if (![RequestManager sharedManager].isLogined) {
        
        [[AppDelegate sharedAppDelegate]showLoginFrom:self successToViewController:vc];

        return ;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8;
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
    
    if (requestType == kRequestTypeQSearchinfo) {
        int recNum = (int)[[(NSDictionary*)data objectForKey:@"total"]integerValue];
        self.totlalNum = recNum;
        
        if (recNum > 0) {
            
            if (self.loadMore) {
                NSMutableArray *array = [NSMutableArray arrayWithArray:self.resourceArray];
                [array addObjectsFromArray:response];
                self.resourceArray = array;
            } else {
                self.resourceArray = response;
            }
            
            if (self.dataResourceIndex == 0) {
                self.dataCacheOneArray = self.resourceArray;
            } else if (self.dataResourceIndex == 1) {
                self.dataCacheTwoArray = self.resourceArray;
            } else if (self.dataResourceIndex == 2) {
                self.dataCacheThreeArray = self.resourceArray;
            }
            
            [self.mainTableView reloadData];
            
            if ([self.headerView getSelectedIndex] == self.dataResourceIndex) {
                
            } else {
                [self.headerView setSelectedIndex:self.dataResourceIndex];
            }
            
            
        }
    } else if (requestType == kRequestTypeGetFavoriteList) {
        int recNum = (int)[[(NSDictionary*)data objectForKey:@"total"]integerValue];
        self.totlalNum = recNum;
        
        if (recNum > 0) {
            if (self.loadMore) {
                NSMutableArray *array = [NSMutableArray arrayWithArray:self.resourceArray];
                [array addObjectsFromArray:response];
                self.resourceArray = array;
            } else {
                self.resourceArray = response;
            }
            
            if (self.dataResourceIndex == 0) {
                self.dataCacheOneArray = self.resourceArray;
            } else if (self.dataResourceIndex == 1) {
                self.dataCacheTwoArray = self.resourceArray;
            } else if (self.dataResourceIndex == 2) {
                self.dataCacheThreeArray = self.resourceArray;
            }
            
            if ([self.headerView getSelectedIndex] == self.dataResourceIndex) {
                
            } else {
                [self.headerView setSelectedIndex:self.dataResourceIndex];
            }
            
            [self.mainTableView reloadData];
            
        }
    } else if (kRequestTypeLikeInfo == requestType) {
        [self toast:@"点赞成功"];
        
        if (self.selectedIndex < self.resourceArray.count) {
            InfoListResponse *response = [self.resourceArray objectAtIndex:self.selectedIndex];
            response.pts++;
            
            
            [self.mainTableView reloadData];
        }
        
    } else if (kRequestTypeAddFavorite == requestType) {
        [self toast:@"收藏成功"];
        
        if (self.selectedIndex < self.resourceArray.count) {
            InfoListResponse *response = [self.resourceArray objectAtIndex:self.selectedIndex];
            response.fts++;
            
            [self.mainTableView reloadData];
        }
        
        
    } else if (kRequestTypeAddComment == requestType) {
        [self toast:@"评论成功"];
        
        if (self.selectedIndex < self.resourceArray.count) {
            InfoListResponse *response = [self.resourceArray objectAtIndex:self.selectedIndex];
            response.dts++;
            
            [self.mainTableView reloadData];
        }
    }
    
//    [self toast:@"成功"];
    self.isReloading = NO;
    [self.refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self.mainTableView];
    
    
    if (self.loadMore) {
        self.loadMore = NO;
    }
    
    [self hideIndicator];
}

- (void)webServiceRequest:(RequestType)requestType error:(NSError *)error userData:(id)userData
{
    if (requestType == kRequestTypeQSearchinfo) {
        
        
    } else if (requestType == kRequestTypeLikeInfo) {
        
        
    }
    [self toast:@"出错了~"];
    self.isReloading = NO;
    [self.refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self.mainTableView];
    
    if (self.loadMore) {
        self.loadMore = NO;
    }
    
    [self hideIndicator];
}

- (void)webServiceRequest:(RequestType)requestType errorString:(NSString *)errorString userData:(id)userData
{
    if (requestType == kRequestTypeQSearchinfo) {
        
        
    } else if (requestType == kRequestTypeLikeInfo) {
        
    }
    
    [self toast:errorString];
    self.isReloading = NO;
    [self.refreshView egoRefreshScrollViewDataSourceDidFinishedLoading:self.mainTableView];
    
    if (self.loadMore) {
        self.loadMore = NO;
    }
    
    [self hideIndicator];
}


#pragma mark -- scrollView代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.refreshView egoRefreshScrollViewDidScroll:scrollView];
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [self.refreshView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.loadMore) {
        return;
    }
    if (scrollView.contentOffset.y >=  scrollView.contentSize.height - scrollView.frame.size.height)
    {
        if (self.totlalNum>[self.resourceArray count])
        {
            self.loadMore = YES;
            [self getReourceList];
        }
    }
}


- (void)getReourceList
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithDictionary:self.requestDict];
    dict[@"page"] = [NSString stringWithFormat:@"%lu",self.resourceArray.count / kDefaultRows + 1];

    [[RequestManager sharedManager]addDelegate:self];
    [[RequestManager sharedManager]startRequestWithType:self.requestType withData:dict];
    
    [self showIndicator];
}

- (void)dealloc
{
    NSLog(@"释放");
}

@end
