//
//  GeeShareView.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/22.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeShareView.h"

@interface GeeShareView ()

@property(nonatomic, strong) UIView *bottomBackView;

@end

@implementation GeeShareView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
        
        
        UIView *bottomBackView = [[UIView alloc]init];
        self.bottomBackView = bottomBackView;
        bottomBackView.backgroundColor = [UIColor whiteColor];
        bottomBackView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 180);
        [self addSubview:bottomBackView];
        
        CGFloat width = bottomBackView.frame.size.width/4;
        for (int i = 0; i < 4; i++) {
            UIButton *button = [[UIButton alloc]init];
            button.frame = CGRectMake(i*width, 0, width, 130);
            button.imageView.contentMode = UIViewContentModeScaleAspectFit;
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"hs_sharepage_%d",i]] forState:UIControlStateNormal];
            button.tag = i;
            [bottomBackView addSubview:button];
            [button addTarget:self action:@selector(shareButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        
//        UIImageView *sinaImage = [[UIImageView alloc]init];
//        sinaImage.image = [UIImage imageNamed:@"icon_sinaShare"];
//        sinaImage.frame = CGRectMake(0, 20, bottomBackView.frame.size.width/2, 50);
//        sinaImage.contentMode = UIViewContentModeScaleAspectFit;
//        [bottomBackView addSubview:sinaImage];
//        UILabel *sinaLabel = [[UILabel alloc]init];
//        sinaLabel.text = @"新浪微博";
//        sinaLabel.textAlignment = NSTextAlignmentCenter;
//        sinaLabel.frame = CGRectMake(0, 90, bottomBackView.frame.size.width/2, 20);
//        sinaLabel.font = [UIFont systemFontOfSize:16];
//        [bottomBackView addSubview:sinaLabel];
//        UIButton *sina = [[UIButton alloc]init];
//        sina.frame = CGRectMake(0, 0, bottomBackView.frame.size.width/2, 130);
//        [bottomBackView addSubview:sina];
//        [sina addTarget:self action:@selector(sinaButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//        
//        UIImageView *wechatImage = [[UIImageView alloc]init];
//        wechatImage.image = [UIImage imageNamed:@"icon_wechatShare"];
//        wechatImage.frame = CGRectMake(bottomBackView.frame.size.width/2, 20, bottomBackView.frame.size.width/2, 50);
//        wechatImage.contentMode = UIViewContentModeScaleAspectFit;
//        [bottomBackView addSubview:wechatImage];
//        UILabel *wechatLabel = [[UILabel alloc]init];
//        wechatLabel.text = @"微信朋友圈";
//        wechatLabel.textAlignment = NSTextAlignmentCenter;
//        wechatLabel.frame = CGRectMake(bottomBackView.frame.size.width/2, 90, bottomBackView.frame.size.width/2, 20);
//        wechatLabel.font = [UIFont systemFontOfSize:16];
//        [bottomBackView addSubview:wechatLabel];
//        UIButton *wechat = [[UIButton alloc]init];
//        wechat.frame = CGRectMake(bottomBackView.frame.size.width/2, 0, bottomBackView.frame.size.width/2, 130);
//        [bottomBackView addSubview:wechat];
//        [wechat addTarget:self action:@selector(wechatShareButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *cancelBack = [[UIView alloc]init];
        cancelBack.backgroundColor = [UIColor colorFromHexRGB:@"c0c0c0"];
        [bottomBackView addSubview:cancelBack];
        cancelBack.frame = CGRectMake(0, 130, ScreenWidth, 50);
        
        
        UIButton *cancelButton = [[UIButton alloc]init];
        [cancelBack addSubview:cancelButton];
        cancelButton.frame = CGRectMake(10, 5, cancelBack.frame.size.width-2*10, 40);
        cancelButton.backgroundColor = [UIColor whiteColor];
        [cancelButton.layer setMasksToBounds:YES];
        [cancelButton.layer setCornerRadius:2];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor colorFromHexRGB:@"c0c0c0"] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(tapGestureTapped) forControlEvents:UIControlEventTouchUpInside];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureTapped)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tapGestureTapped
{
    [self removeFromSuperview];
}

- (void)layoutSubviews
{
    [UIView animateWithDuration:0.5 animations:^{
        self.bottomBackView.frame = CGRectMake(0, ScreenHeight-180, ScreenWidth, 180);
    }];
}

//- (void)sinaButtonClicked
//{
//    
//    if (self.shareToSina) {
//        self.shareToSina();
//    }
//    [self removeFromSuperview];
//}
//
//- (void)wechatShareButtonClicked
//{
//    
//    if (self.shareToWechat) {
//        self.shareToWechat();
//    }
//    [self removeFromSuperview];
//}

- (void)shareButtonClicked:(UIButton *)button
{
    if (button.tag == 0) {
        if (self.shareToSina) {
            self.shareToSina();
        }
    } else if (button.tag == 1) {
        if (self.shareToQQFriend) {
            self.shareToQQFriend();
        }
    } else if (button.tag == 2) {
        if (self.shareToWechat) {
            self.shareToWechat();
        }
    } else {
        if (self.shareToWechatFriend) {
            self.shareToWechatFriend();
        }
    }
    [self removeFromSuperview];
}

@end
