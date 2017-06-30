//
//  GeeGoodLuckTableViewCell.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/24.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeGoodLuckTableViewCell.h"

@interface GeeGoodLuckTableViewCell ()

@property(nonatomic, strong) UILabel *phoneNum;
@property(nonatomic, strong) UILabel *level;

@property(nonatomic, strong) UIView *line;

@end

@implementation GeeGoodLuckTableViewCell

+ (GeeGoodLuckTableViewCell *)cellForTableView:(UITableView *)tableView
{
    static NSString *reuseId = @"GeeGoodLuckTableViewCell";
    GeeGoodLuckTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[GeeGoodLuckTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *phoneLabel = [[UILabel alloc]init];
        self.phoneNum = phoneLabel;
        phoneLabel.text = @"188********";
        phoneLabel.textColor = [UIColor redColor];
        phoneLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:phoneLabel];
        
        UILabel *levelLabel = [[UILabel alloc]init];
        self.level = levelLabel;
        levelLabel.textColor = [UIColor colorFromHexRGB:@"646464"];
        levelLabel.text = @"一等奖";
        levelLabel.font = [UIFont systemFontOfSize:16];
        levelLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:levelLabel];
        
        UIView *line = [[UIView alloc]init];
        [self.contentView addSubview:line];
        line.backgroundColor = [UIColor colorFromHexRGB:@"c8c8c8"];
        self.line = line;
    }
    return self;
}

- (void)setEventWinner:(EventWinnerResponse *)eventWinner
{
    _eventWinner = eventWinner;
    
    self.phoneNum.text = [NSString deletePhoneNumber:eventWinner.username];

    self.level.text = eventWinner.prize;
}

- (void)layoutSubviews
{
    self.phoneNum.frame = CGRectMake(10, 0, (self.contentView.frame.size.width-20)*0.7, self.contentView.frame.size.height);
    self.level.frame = CGRectMake(CGRectGetMaxX(self.phoneNum.frame), 0, (self.contentView.frame.size.width-20)*0.3, self.contentView.frame.size.height);
    self.line.frame = CGRectMake(0, self.contentView.frame.size.height-0.5, self.contentView.frame.size.width, 0.5);
}

@end
