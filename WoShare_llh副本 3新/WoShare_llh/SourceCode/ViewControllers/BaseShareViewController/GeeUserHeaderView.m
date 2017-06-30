//
//  GeeUserHeaderView.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/7/11.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeUserHeaderView.h"

#import "UIImageView+WebCache.h"

@interface GeeUserHeaderView ()

@property(nonatomic, strong) UIImageView *headIconView;
@property(nonatomic, strong) UILabel *nameLabel;

@end

@implementation GeeUserHeaderView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, 150);
        
        
        UIImageView *backimageView = [[UIImageView alloc]init];
        [self addSubview:backimageView];
        backimageView.contentMode = UIViewContentModeScaleToFill;
        backimageView.image = [UIImage imageNamed:@"userZonebg"];
        backimageView.userInteractionEnabled = YES;
        backimageView.frame = self.bounds;
        
        UIImageView *head = [[UIImageView alloc]init];
        head.frame = CGRectMake(ScreenWidth/2-80/2, 20, 80, 80);
        [self addSubview:head];
        [head.layer setMasksToBounds:YES];
        [head.layer setCornerRadius:80/2];
        self.headIconView = head;
        UserInfoResponse *userinfo = self.resourceInfo.userinfo;
        [head sd_setImageWithURL:[NSURL URLWithString:userinfo.avatar] placeholderImage:[UIImage imageNamed:@"head_boy.jpg"]];
        head.contentMode = UIViewContentModeScaleAspectFit;
        [head.layer setBorderWidth:2];
        [head.layer setBorderColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"nav_barbackground"]].CGColor];
        
        UILabel *name = [[UILabel alloc]init];
        [self addSubview:name];
        self.nameLabel = name;
        name.text = self.resourceInfo.userinfo.username;
        name.textAlignment = NSTextAlignmentCenter;
        name.frame = CGRectMake(0, CGRectGetMaxY(head.frame)+10, ScreenWidth, 20);
        name.textColor = [UIColor blackColor];
        
        
    }
    return self;
}

- (void)setResourceInfo:(InfoListResponse *)resourceInfo
{
    _resourceInfo = resourceInfo;
    
    [self.headIconView sd_setImageWithURL:[NSURL URLWithString:resourceInfo.userinfo.avatar] placeholderImage:[UIImage imageNamed:@"head_boy.jpg"]];
    self.nameLabel.text = self.resourceInfo.userinfo.username;
}


@end
