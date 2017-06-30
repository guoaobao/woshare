//
//  GeeActDetailView.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/24.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeActDetailView.h"
#import "NSString+CaculateSize.h"

@interface GeeActDetailView ()

@property(nonatomic, strong) UILabel *actNameLabel;
@property(nonatomic, strong) UILabel *nameLabel;

@property(nonatomic, strong) UILabel *actDetailLabel;
@property(nonatomic, strong) UILabel *detailLabel;

@property(nonatomic, strong) UIScrollView *mainScrollView;

@end


@implementation GeeActDetailView


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        self.mainScrollView = scrollView;
        [self addSubview:scrollView];
        
        UILabel *actNameLabel = [[UILabel alloc]init];
        self.actNameLabel = actNameLabel;
        actNameLabel.text = @"活动名称：";
        actNameLabel.textColor = [UIColor blackColor];
        actNameLabel.font = [UIFont systemFontOfSize:16];
        [scrollView addSubview:actNameLabel];
        
        UILabel *nameLabel = [[UILabel alloc]init];
        self.nameLabel = nameLabel;
        nameLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nav_barbackground"]];
        nameLabel.font = [UIFont systemFontOfSize:16];
        [scrollView addSubview:nameLabel];
        
        UILabel *actDetailLabel = [[UILabel alloc]init];
        self.actDetailLabel = actDetailLabel;
        actDetailLabel.text = @"活动详情：";
        actDetailLabel.font = [UIFont systemFontOfSize:16];
        actDetailLabel.textColor = [UIColor blackColor];
        [scrollView addSubview:actDetailLabel];
        
        UILabel *detailLabel = [[UILabel alloc]init];
        self.detailLabel = detailLabel;
        detailLabel.font = [UIFont systemFontOfSize:14];
        detailLabel.textColor = [UIColor colorFromHexRGB:@"969696"];
        detailLabel.numberOfLines = 0;
        [scrollView addSubview:detailLabel];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setActName:(NSString *)name andDetail:(NSString *)detail
{
    
    self.mainScrollView.frame = self.bounds;
    
    self.nameLabel.text = name;
    self.detailLabel.text = detail;
    
}

- (void)layoutSubviews
{
    CGSize actNamesize = [self.actNameLabel.text caculateSizeByFont:self.actNameLabel.font];
    CGSize actDetailsize = [self.actDetailLabel.text caculateSizeByFont:self.actDetailLabel.font];
    
    CGSize namesize = [self.nameLabel.text caculateSizeByFont:self.nameLabel.font];
    CGRect detailrect = [self.detailLabel.text caculateRectByFont:self.detailLabel.font ByConstrainedSize:CGSizeMake(ScreenWidth-30, MAXFLOAT)];
    
    self.actNameLabel.frame = CGRectMake(10, 15, actNamesize.width, actNamesize.height);
    self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.actNameLabel.frame)+10, self.actNameLabel.frame.origin.y, namesize.width, namesize.height);
    self.actDetailLabel.frame = CGRectMake(10, CGRectGetMaxY(self.actNameLabel.frame)+15, actDetailsize.width, actDetailsize.height);
    self.detailLabel.frame = CGRectMake(10, CGRectGetMaxY(self.actDetailLabel.frame)+15, detailrect.size.width, detailrect.size.height);
    
    self.mainScrollView.frame = self.bounds;
    self.mainScrollView.contentSize = CGSizeMake(0, 15*3+actNamesize.height+actDetailsize.height+detailrect.size.height+15);
    
}

@end
