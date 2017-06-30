//
//  GeeMeTableViewCell.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/23.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeMeTableViewCell.h"

@interface GeeMeTableViewCell ()

@property(nonatomic, strong) UIImageView *iconView;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UIView *lineView;
@property(nonatomic, strong) UIImageView *arrowImage;
//@property(nonatomic, strong) UIImageView *backImageView;

@end

@implementation GeeMeTableViewCell


+ (GeeMeTableViewCell *)cellForTableView:(UITableView *)tableView
{
    static NSString *reuseidentifier = @"GeeMeTableViewCell";
    GeeMeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseidentifier];
    if (cell == nil) {
        cell = [[GeeMeTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseidentifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
//        UIImageView *back = [[UIImageView alloc]init];
//        [self.contentView addSubview:back];
//        self.backImageView = back;
//        back.contentMode = UIViewContentModeScaleToFill;
//        back.image = [UIImage imageNamed:@"under_line"];
//        back.userInteractionEnabled = YES;
        
        UIImageView *icon = [[UIImageView alloc]init];
        self.iconView = icon;
        [self.contentView addSubview:icon];
        icon.contentMode = UIViewContentModeScaleAspectFit;
        
        UILabel *name = [[UILabel alloc]init];
        self.nameLabel = name;
        [self.contentView addSubview:name];
        name.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nav_barbackground"]];
        name.font = [UIFont systemFontOfSize:15];
        
        UIView *line = [[UIView alloc]init];
        self.lineView = line;
        [self.contentView addSubview:line];
        line.backgroundColor = [UIColor colorFromHexRGB:@"b9b9b9"];
        
        UIImageView *arrow = [[UIImageView alloc]init];
        arrow.image = [UIImage imageNamed:@"icon_rightarrow"];
        arrow.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:arrow];
        self.arrowImage = arrow;
        
    }
    return self;
}

- (void)layoutSubviews
{
    if (self.imageName != nil) {
        self.iconView.image = [UIImage imageNamed:self.imageName];
    }
    
    if (self.functionName != nil) {
        self.nameLabel.text = self.functionName;
    }
    
    self.iconView.frame = CGRectMake(10, self.contentView.frame.size.height/2-24/2, 24, 24);
    self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.iconView.frame)+10, 0, self.contentView.frame.size.width-CGRectGetMaxX(self.iconView.frame)-10, self.contentView.frame.size.height);
    self.lineView.frame = CGRectMake(0, self.contentView.frame.size.height-0.5, self.contentView.frame.size.width, 0.5);
    self.arrowImage.frame = CGRectMake(self.contentView.frame.size.width-8-20, self.contentView.frame.size.height/2-16/2, 8, 16);
//    self.backImageView.frame = self.contentView.bounds;
}

@end
