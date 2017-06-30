//
//  GeeSelectEventCollectionCell.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/7/18.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeSelectEventCollectionCell.h"

@interface GeeSelectEventCollectionCell ()

@property(nonatomic, strong) UILabel *normalLabel;
@property(nonatomic, strong) UILabel *selectedLabel;

@end

@implementation GeeSelectEventCollectionCell

+ (GeeSelectEventCollectionCell *)cellForCollection:(UICollectionView *)collection forIndex:(NSIndexPath *)indexPath
{
    NSString *reuseid = NSStringFromClass([self class]);
    GeeSelectEventCollectionCell *cell = [collection dequeueReusableCellWithReuseIdentifier:reuseid forIndexPath:indexPath];
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.selected = NO;
        
        UILabel *normal = [[UILabel alloc]init];
        normal.frame = self.bounds;
        self.normalLabel = normal;
        normal.textColor = [UIColor colorFromHexRGB:@"646464"];
        normal.text = @"活动";
        normal.textAlignment = NSTextAlignmentCenter;
        normal.backgroundColor = [UIColor colorFromHexRGB:@"f0f0f0"];
        [self setBackgroundView:normal];
        normal.font = [UIFont systemFontOfSize:14];
        [normal.layer setMasksToBounds:YES];
        [normal.layer setCornerRadius:2];
        
        UILabel *selected = [[UILabel alloc]init];
        selected.frame = self.bounds;
        self.selectedLabel = selected;
        selected.textColor = [UIColor whiteColor];
        selected.text = @"活动";
        selected.textAlignment = NSTextAlignmentCenter;
        selected.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nav_barbackground"]];
        [self setSelectedBackgroundView:selected];
        [selected.layer setMasksToBounds:YES];
        selected.font = [UIFont systemFontOfSize:14];
        [selected.layer setCornerRadius:2];
    }
    return self;
}

- (void)setEventinfo:(EventResponse *)eventinfo
{
    _eventinfo = eventinfo;
    
    self.normalLabel.text = eventinfo.title;
    self.selectedLabel.text = eventinfo.title;
}

@end
