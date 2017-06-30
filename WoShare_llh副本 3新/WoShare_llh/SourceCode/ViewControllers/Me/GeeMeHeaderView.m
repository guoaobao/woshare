//
//  GeeMeHeaderView.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/23.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeMeHeaderView.h"
#import "UIImageView+WebCache.h"
#import "RequestManager.h"

@interface GeeMeHeaderView ()

@property(nonatomic, strong) UIImageView *headIconView;
@property(nonatomic, strong) UILabel *nameLabel;


@end

@implementation GeeMeHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, 150);
        
        
        UIImageView *backimageView = [[UIImageView alloc]init];
        [self addSubview:backimageView];
        backimageView.contentMode = UIViewContentModeScaleToFill;
        backimageView.image = [UIImage imageNamed:@"me-bg"];
        backimageView.userInteractionEnabled = YES;
        backimageView.frame = self.bounds;
        
        UIImageView *head = [[UIImageView alloc]init];
        head.frame = CGRectMake(ScreenWidth/2-80/2, 20, 80, 80);
        [self addSubview:head];
        [head.layer setMasksToBounds:YES];
        [head.layer setCornerRadius:80/2];
        self.headIconView = head;
        UserInfoResponse *userinfo = [RequestManager sharedManager].userInfo;
        [head sd_setImageWithURL:[NSURL URLWithString:userinfo.avatar] placeholderImage:[UIImage imageNamed:@"head_boy.jpg"]];
        head.contentMode = UIViewContentModeScaleAspectFit;
        [head.layer setBorderWidth:2];
        [head.layer setBorderColor:[UIColor whiteColor].CGColor];
        
        UILabel *name = [[UILabel alloc]init];
        [self addSubview:name];
        self.nameLabel = name;
        name.text = [RequestManager sharedManager].userInfo.username;
        name.textAlignment = NSTextAlignmentCenter;
        name.frame = CGRectMake(0, CGRectGetMaxY(head.frame)+10, ScreenWidth, 30);
        name.textColor = [UIColor blackColor];
        
        
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"me-bg"]];
    }
    return self;
}



@end
