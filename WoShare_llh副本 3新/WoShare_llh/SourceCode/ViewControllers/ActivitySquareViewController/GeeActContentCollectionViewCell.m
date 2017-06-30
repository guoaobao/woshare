//
//  GeeActContentCollectionViewCell.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/24.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeActContentCollectionViewCell.h"
#import "ResourceInfo.h"
#import "UIImageView+WebCache.h"

@interface GeeActContentCollectionViewCell ()

@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UIImageView *backImageView;

@end

@implementation GeeActContentCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *backImageView = [[UIImageView alloc]init];
        self.backImageView = backImageView;
        [self.contentView addSubview:backImageView];
        backImageView.contentMode = UIViewContentModeScaleToFill;
        backImageView.frame = self.contentView.bounds;
        
        UILabel *nameLabel = [[UILabel alloc]init];
        self.nameLabel = nameLabel;
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nav_barbackground"]];
        nameLabel.text = @" 作品名称";
        nameLabel.frame = CGRectMake(0, frame.size.height-20, frame.size.width, 20);
        [self.contentView addSubview:nameLabel];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.font = [UIFont systemFontOfSize:15];
    }
    return self;
}


- (void)setInfo:(InfoListResponse *)info
{
    _info = info;

    ResourceInfo *re = [info.resourceArray objectAtIndex:0];
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:[re getBiggestImageURLString]] placeholderImage:[UIImage imageNamed:@"hs_homepage_loading_defaultpic"]];
    self.nameLabel.text = info.title;
}

- (void)layoutSubviews
{
    
}

@end
