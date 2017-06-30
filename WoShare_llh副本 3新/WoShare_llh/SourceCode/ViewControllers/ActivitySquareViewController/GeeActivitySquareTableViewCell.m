//
//  GeeActivitySquareTableViewCell.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/22.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeActivitySquareTableViewCell.h"
#import "NSString+CaculateSize.h"
#import "UIImageView+WebCache.h"

@interface GeeActivitySquareTableViewCell ()

@property(nonatomic, strong) UIImageView *backImageView;
@property(nonatomic, strong) UILabel *stateLabel;

@end

@implementation GeeActivitySquareTableViewCell


+ (GeeActivitySquareTableViewCell *)cellForTableView:(UITableView *)tableView
{
    static NSString *reuseIdentifier = @"GeeActivitySquareTableViewCell";
    GeeActivitySquareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[GeeActivitySquareTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *backImageView = [[UIImageView alloc]init];
        self.backImageView = backImageView;
        [self.contentView addSubview:backImageView];
        backImageView.contentMode = UIViewContentModeScaleToFill;
        self.contentView.backgroundColor = [UIColor clearColor];
        
        UILabel *stateLabel = [[UILabel alloc]init];
        self.stateLabel = stateLabel;
        [backImageView addSubview:stateLabel];
        stateLabel.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.7];
        stateLabel.textColor = [UIColor whiteColor];
        stateLabel.font = [UIFont systemFontOfSize:15];
        stateLabel.text = @"结束";
        stateLabel.textAlignment = NSTextAlignmentCenter;
        [stateLabel.layer setMasksToBounds:YES];
        [stateLabel.layer setCornerRadius:2];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setEventInfo:(EventResponse *)eventInfo
{
    _eventInfo = eventInfo;
    
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:eventInfo.poster] placeholderImage:[UIImage imageNamed:@"hs_homepage_loading_defaultpic"]];
    switch (eventInfo.eventstatus) {
        case 1:
        {
            self.stateLabel.text = @"未开始";
        }
            break;
        case 3:
        {
            self.stateLabel.text = @"进行中";
        }
            break;
        case 4:
        {
            self.stateLabel.text = @"已结束";
        }
            break;
        default:
            break;
    }
}



- (void)layoutSubviews
{
    self.backImageView.frame = CGRectMake(5, 0, self.contentView.frame.size.width-2*5, self.contentView.frame.size.height);
    
    CGSize stateSize = [self.stateLabel.text caculateSizeByFont:self.stateLabel.font];
    self.stateLabel.frame = CGRectMake(self.backImageView.frame.size.width-stateSize.width-20, self.backImageView.frame.size.height-15-stateSize.height, stateSize.width+10, stateSize.height+5);
}


@end
