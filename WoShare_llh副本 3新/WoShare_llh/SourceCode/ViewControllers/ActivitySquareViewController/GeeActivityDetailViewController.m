//
//  GeeActivityDetailViewController.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/23.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeActivityDetailViewController.h"
#import "NSString+CaculateSize.h"
#import "UIImage+UIColor.h"
#import "GeeActDetailSegmentView.h"
#import "GeeActDetailView.h"
#import "GeeActContentListView.h"
#import "GeeGoodLukeListView.h"
#import "UIImageView+WebCache.h"
#import "InfoListResponse.h"
#import "ResourceInfo.h"
#import "GeeShowGifViewController.h"
#import "GeePictureScanViewController.h"
#import "GeeMoviePlayerViewController.h"
#import "KxMovieViewController.h"
#import "GeeUpLoadViewController.h"
#import "RequestManager.h"
#import "AppDelegate.h"

@interface GeeActivityDetailViewController ()

@property(nonatomic, strong) GeeActDetailView *actDetailView;
@property(nonatomic, strong) GeeActDetailSegmentView *segView;
//@property(nonatomic, strong) UIScrollView *mainScrollView;
@property(nonatomic, strong) GeeActContentListView *collectionView;
@property(nonatomic, strong) GeeGoodLukeListView *goodLuckView;

@property(nonatomic, strong) UILabel *statuesLabel;

@end

@implementation GeeActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.eventInfo.title;
    self.view.backgroundColor = [UIColor colorFromHexRGB:@"f0f0f0"];
    
    [self setNavBackButton];
    [self setupViewOfController];
    [self setRightNavButton];
}

- (void)setRightNavButton
{
    UIButton *takeIn = [[UIButton alloc]init];
    [takeIn setTitle:@"参加活动" forState:UIControlStateNormal];
    takeIn.titleLabel.font = [UIFont systemFontOfSize:14];
    takeIn.frame = CGRectMake(0, 0, 60, 30);
    [takeIn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [takeIn addTarget:self action:@selector(takeInEvent) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:takeIn];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)setupViewOfController
{
//    UIScrollView *mainScrollView = [[UIScrollView alloc]init];
//    mainScrollView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-64);
//    [self.view addSubview:mainScrollView];
//    self.mainScrollView = mainScrollView;
    
    UIView *headerBackView = [[UIView alloc]init];
    headerBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headerBackView];
    
    UILabel *actNameLabel = [[UILabel alloc]init];
    actNameLabel.text = self.eventInfo.title;
    actNameLabel.font = [UIFont systemFontOfSize:16];
    actNameLabel.textColor = [UIColor colorFromHexRGB:@"7f7f7f"];
    [headerBackView addSubview:actNameLabel];
    CGSize actname = [actNameLabel.text caculateSizeByFont:actNameLabel.font];
    actNameLabel.frame = CGRectMake(5, 5, actname.width, actname.height);
    
    UILabel *stateLabel = [[UILabel alloc]init];
    stateLabel.text = @"已结束";
    switch (self.eventInfo.eventstatus) {
        case 1:
        {
            stateLabel.text = @"未开始";
        }
            break;
        case 3:
        {
            stateLabel.text = @"进行中";
        }
            break;
        case 4:
        {
            stateLabel.text = @"已结束";
        }
            break;
        default:
            break;
    }
    stateLabel.textColor = [UIColor redColor];
    stateLabel.font = [UIFont systemFontOfSize:12];
    [headerBackView addSubview:stateLabel];
    CGSize statesize = [stateLabel.text caculateSizeByFont:stateLabel.font];
    stateLabel.frame = CGRectMake(ScreenWidth-5*2-5-statesize.width, CGRectGetMaxY(actNameLabel.frame)-statesize.height, statesize.width, statesize.height);
    
    UIImageView *actImgView = [[UIImageView alloc]init];
    actImgView.contentMode = UIViewContentModeScaleToFill;
    [actImgView sd_setImageWithURL:[NSURL URLWithString:self.eventInfo.poster] placeholderImage:[UIImage imageNamed:@"hs_homepage_loading_defaultpic"]];
    [headerBackView addSubview:actImgView];
    actImgView.frame = CGRectMake(0, CGRectGetMaxY(actNameLabel.frame)+5, ScreenWidth-2*5, 140);
    
    
    UILabel *timeLabel = [[UILabel alloc]init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSString *starttime = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[self.eventInfo.starttime longLongValue]]];
    NSString *endtime = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[self.eventInfo.endtime longLongValue]]];
    timeLabel.text = [NSString stringWithFormat:@"%@-%@",starttime,endtime];
    timeLabel.textColor = [UIColor colorFromHexRGB:@"7f7f7f"];
    [headerBackView addSubview:timeLabel];
    timeLabel.font = [UIFont systemFontOfSize:12];
    CGSize timesize = [timeLabel.text caculateSizeByFont:timeLabel.font];
    timeLabel.frame = CGRectMake(ScreenWidth-2*5-5-timesize.width, CGRectGetMaxY(actImgView.frame)+5, timesize.width, timesize.height);
    timeLabel.font = [UIFont systemFontOfSize:12];
    
    headerBackView.frame = CGRectMake(5, 5, ScreenWidth-2*5, CGRectGetMaxY(timeLabel.frame)+5);
    
    GeeActDetailSegmentView *seg = [[GeeActDetailSegmentView alloc]init];
    self.segView = seg;
    seg.frame = CGRectMake(5, CGRectGetMaxY(headerBackView.frame)+10, ScreenWidth-2*5, 40);
    seg.titleArray = @[@"活动详情",@"参赛作品",@"中奖名单公布"];
    [self.view addSubview:seg];
    __weak GeeActivityDetailViewController *weakself = self;
    seg.buttonClickedAtIndex = ^(NSInteger index) {
        if (index == 0) {
            
            [weakself.view addSubview:weakself.actDetailView];
            [_collectionView removeFromSuperview];
            [_goodLuckView removeFromSuperview];
            
        } else if (index == 1) {
            
            [weakself.view addSubview:weakself.collectionView];
            [_actDetailView removeFromSuperview];
            [_goodLuckView removeFromSuperview];
            
        } else {
            
            [weakself.view addSubview:weakself.goodLuckView];
            [_collectionView removeFromSuperview];
            [_actDetailView removeFromSuperview];
            
        }
        
    };
}

- (GeeActDetailView *)actDetailView
{
    if (_actDetailView == nil) {
        
        _actDetailView = [[GeeActDetailView alloc]init];
        [_actDetailView setActName:self.eventInfo.title andDetail:self.eventInfo.detail];
        [self.view addSubview:_actDetailView];
        _actDetailView.frame = CGRectMake(5, CGRectGetMaxY(self.segView.frame), ScreenWidth-2*5, ScreenHeight-CGRectGetMaxY(self.segView.frame)-5-64);
    }
    return _actDetailView;
}

- (GeeActContentListView *)collectionView
{
    if (_collectionView == nil) {
        _collectionView = [[GeeActContentListView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.segView.frame), ScreenWidth-2*5, ScreenHeight-64-CGRectGetMaxY(self.segView.frame)-5)];
        [self.view addSubview:_collectionView];
        _collectionView.eventInfo = self.eventInfo;
        
        __weak GeeActivityDetailViewController *weakself = self;
        _collectionView.resourceItemClicked = ^(InfoListResponse *info) {
            [weakself resourceButton:info];
        };
    }
    return _collectionView;
}

- (GeeGoodLukeListView *)goodLuckView
{
    if (_goodLuckView == nil) {
        _goodLuckView = [[GeeGoodLukeListView alloc]init];
        _goodLuckView.frame = CGRectMake(5, CGRectGetMaxY(self.segView.frame), ScreenWidth-2*5, ScreenHeight-64-CGRectGetMaxY(self.segView.frame)-5);
        [self.view addSubview:_goodLuckView];
        _goodLuckView.eventInfo = self.eventInfo;
    }
    return _goodLuckView;
}


- (void)takeInEvent
{
    if (self.eventInfo.eventstatus == kEventStatusWaiting) {
        [self toast:@"活动还未开始哦，看一下其他活动吧~"];
        return;
    }
    
    if (self.eventInfo.eventstatus == kEventStatusFinish) {
        [self toast:@"活动已经结束啦，看一下其他活动吧~"];
        return;
    }
    
    GeeUpLoadViewController *uploader = [[GeeUpLoadViewController alloc]init];
    uploader.eventid = self.eventInfo.eventid;
    uploader.isHideSelectEventBtn = YES;
    uploader.popToViewController = self;
    
    if (![RequestManager sharedManager].isLogined) {
        [[AppDelegate sharedAppDelegate]showLoginFrom:self successToViewController:uploader];
        return ;
    }
    
    
    [self.navigationController pushViewController:uploader animated:YES];
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

@end
