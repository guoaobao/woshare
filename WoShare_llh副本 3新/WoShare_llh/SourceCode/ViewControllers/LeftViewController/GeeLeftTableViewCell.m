//
//  GeeLeftTableViewCell.m
//  woshare
//
//  Created by 陆利刚 on 16/6/20.
//  Copyright © 2016年 胡波. All rights reserved.
//

#import "GeeLeftTableViewCell.h"
#import "NSString+CaculateSize.h"

@interface GeeLeftTableViewCell ()

@property(nonatomic, strong) UIImageView *leftImageView;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UIImageView *rightImageView;
@property(nonatomic, strong) UIView *lineView;

@end

@implementation GeeLeftTableViewCell

+ (GeeLeftTableViewCell *)cellForTableView:(UITableView *)tableView
{
    static NSString *identifier = @"GeeLeftTableViewCell";
    GeeLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[GeeLeftTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *name = [[UILabel alloc]init];
        self.nameLabel = name;
        [self.contentView addSubview:name];
        name.textColor = [UIColor whiteColor];
        name.font = [UIFont systemFontOfSize:14];
        
        UIView *line = [[UIView alloc]init];
        self.lineView = line;
        [self.contentView addSubview:line];
        line.backgroundColor = [UIColor lightGrayColor];
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setLeftCellIcon:(NSString *)leftCellIcon
{
    _leftCellIcon = leftCellIcon;
    
    if (self.leftImageView == nil) {
        self.leftImageView = [[UIImageView alloc]init];
        self.leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.leftImageView.image = [UIImage imageNamed:leftCellIcon];
        [self.contentView addSubview:self.leftImageView];
    }
}

- (void)setRightCellIcon:(NSString *)rightCellIcon
{
    _rightCellIcon = rightCellIcon;
    
    if (self.rightImageView == nil) {
        self.rightImageView = [[UIImageView alloc]init];
        self.rightImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.rightImageView.image = [UIImage imageNamed:rightCellIcon];
        [self.contentView addSubview:self.rightImageView];
    }
}

- (void)setCellName:(NSString *)cellName
{
    _cellName = cellName;
    self.nameLabel.text = cellName;
}


- (void)layoutSubviews
{
    CGSize labelSize = [self.nameLabel.text caculateSizeByFont:self.nameLabel.font];
    
    if (self.rightImageView) {
        self.rightImageView.frame = CGRectMake(self.contentView.frame.size.width/2-15-labelSize.height, self.contentView.frame.size.height-15-labelSize.height, labelSize.height, labelSize.height);
        
        self.nameLabel.frame = CGRectMake(self.contentView.frame.size.width/4-labelSize.width/2, self.contentView.frame.size.height-15-labelSize.height, labelSize.width, labelSize.height);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.rightImageView.hidden = YES;
    } else {
        
        self.leftImageView.frame = CGRectMake(15, self.contentView.frame.size.height/2-labelSize.height/2, labelSize.height, labelSize.height);
        
        self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.leftImageView.frame)+10, self.contentView.frame.size.height/2-labelSize.height/2, labelSize.width, labelSize.height);
    }
    
    self.lineView.frame = CGRectMake(0, self.contentView.frame.size.height-1, self.contentView.frame.size.width, 1);
}

@end
