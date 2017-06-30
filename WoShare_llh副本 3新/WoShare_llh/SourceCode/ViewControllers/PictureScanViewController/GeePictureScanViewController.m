//
//  GeePictureScanViewController.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/7/1.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeePictureScanViewController.h"
#import "UIImageView+WebCache.h"
#import "NSString+CaculateSize.h"
#import "ResourceInfo.h"
#import "GeeMoviePlayerViewController.h"
#import "KxMovieViewController.h"
#import "GeeShowGifViewController.h"
#import "UIImage+UIColor.h"
#import "RequestManager.h"

@interface GeePictureScanViewController () <UIScrollViewDelegate>

@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UILabel *briefLabel;
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UILabel *indexLabel;

@end

@implementation GeePictureScanViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self setupViewOfController];
}


- (void)setupViewOfController
{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    [self.view addSubview:scrollView];
    scrollView.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight-64-128);
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    self.scrollView = scrollView;
    
    UILabel *name = [[UILabel alloc]init];
    name.frame = CGRectMake(10, CGRectGetMaxY(scrollView.frame)+10, ScreenWidth-10*3-80, 30);
    name.text = @"名字";
    name.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:name];
    self.nameLabel = name;
    name.textColor = [UIColor whiteColor];
    
    UILabel *brief = [[UILabel alloc]init];
    self.briefLabel = brief;
    [self.view addSubview:brief];
    brief.numberOfLines = 0;
    brief.font = [UIFont systemFontOfSize:14];
    brief.text = @"简介";
    CGRect rect = [brief.text caculateRectByFont:brief.font ByConstrainedSize:CGSizeMake(ScreenWidth-2*10, MAXFLOAT)];
    brief.frame = CGRectMake(10, CGRectGetMaxY(self.nameLabel.frame)+10, rect.size.width, rect.size.height);
    brief.textColor = [UIColor whiteColor];
    
    UILabel *indexLabel = [[UILabel alloc]init];
    self.indexLabel = indexLabel;
    [self.view addSubview:indexLabel];
    indexLabel.text = @"1/1";
    indexLabel.textColor = [UIColor whiteColor];
    indexLabel.textAlignment = NSTextAlignmentRight;
    indexLabel.frame = CGRectMake(CGRectGetMaxX(name.frame)+10, name.frame.origin.y, 80, 30);
    
    UIButton *back = [[UIButton alloc]init];
    [back setImage:[UIImage imageNamed:@"hs_last_backpic"] forState:UIControlStateNormal];
    back.frame = CGRectMake(10, 25, 46, 34);
    [self.view addSubview:back];
    [back addTarget:self action:@selector(backButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    for (int i = 0; i < self.infoList.resourceArray.count; i++) {
        
        ResourceInfo *info = [self.infoList.resourceArray objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc]init];
        [self.scrollView addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(i*self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]init];
        indicator.frame = CGRectMake(0, 0, 30, 30);
        indicator.center = CGPointMake(imageView.frame.size.width/2, imageView.frame.size.height/2);
        [imageView addSubview:indicator];
        [indicator startAnimating];
        
        UIImageView *play = [[UIImageView alloc]init];
        play.frame = CGRectMake(0, 0, 40, 40);
        play.center = CGPointMake(imageView.frame.size.width/2, imageView.frame.size.height/2);
        [imageView addSubview:play];
        play.image = [UIImage imageNamed:@"icon-playbutton"];
        
        NSString *url = info.playUrl;
        imageView.tag = i;
        
        if (info.type == kResourceVideo || info.type == kResourceVoice || [info.ext isEqualToString:@"gif"]) {
            
            play.hidden = NO;
            if (info.type == kResourceVoice) {
                play.hidden = YES;
            }
            
            
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureTapped:)];
            [imageView addGestureRecognizer:tap];
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:[info getBiggestImageURLString]] placeholderImage:[UIImage createImageWithColor:[UIColor blackColor]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                [indicator removeFromSuperview];
            }];
            
        } else {
            play.hidden = YES;
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                [indicator removeFromSuperview];
            }];
        }

    }
    self.scrollView.contentSize = CGSizeMake(self.infoList.resourceArray.count*self.scrollView.frame.size.width, 0);
    
    if (self.infoList.resourceArray.count > 0) {
        ResourceInfo *info = [self.infoList.resourceArray objectAtIndex:0];
        
        self.briefLabel.text = info.brief;
        CGRect rect = [self.briefLabel.text caculateRectByFont:self.briefLabel.font ByConstrainedSize:CGSizeMake(ScreenWidth-2*10, MAXFLOAT)];
        self.briefLabel.frame = CGRectMake(10, CGRectGetMaxY(self.nameLabel.frame)+10, rect.size.width, (rect.size.height > ScreenHeight-CGRectGetMaxY(self.nameLabel.frame)-10-10)?(ScreenHeight-CGRectGetMaxY(self.nameLabel.frame)-10-10):rect.size.height);
        self.nameLabel.text = info.title;
        CGFloat i = self.scrollView.contentOffset.x /self.scrollView.frame.size.width+0.5;
        int index = (int)i;
        NSString *text = [NSString stringWithFormat:@"%d/%ld",index+1,self.infoList.resourceArray.count];
        self.indexLabel.text = text;
        
    }
    
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationController.navigationBarHidden=YES;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
     
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)backButtonClicked
{
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static int lastindex = 0;
    CGFloat i = scrollView.contentOffset.x /scrollView.frame.size.width+0.5;
    int index = (int)i;
    
    if (lastindex != index) {
        NSLog(@"%d",index);
        lastindex = index;
        
        NSString *text = [NSString stringWithFormat:@"%d/%ld",index+1,self.infoList.resourceArray.count];
        self.indexLabel.text = text;
    }
    
}

- (void)tapGestureTapped:(UITapGestureRecognizer *)tap
{
    if (tap.view.tag < self.infoList.resourceArray.count) {
        ResourceInfo *info = [self.infoList.resourceArray objectAtIndex:tap.view.tag];
        
        if (info.type == kResourceVideo) {
            if ([info.playUrl length]>0) {
                //播放
//                GeeMoviePlayerViewController *player = [[GeeMoviePlayerViewController alloc]init];
//                player.playUrl = info.playUrl;
//                [self.navigationController pushViewController:player animated:YES];
                NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
                NSString *path=info.playUrl;
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
        else if ([info.ext isEqualToString:@"gif"])
        {
            [self showGif:info.playUrl];
        }

    }

}



- (void)showGif:(NSString *)url
{
    GeeShowGifViewController *vc = [[GeeShowGifViewController alloc]init];
    vc.gifUrl = url;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
