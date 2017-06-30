//
//  GeeMyPrizeTableViewCell.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/27.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeMyPrizeTableViewCell.h"
#import "NSString+CaculateSize.h"

@interface GeeMyPrizeTableViewCell ()

@property(nonatomic, strong) UIView *backView;

@property(nonatomic, strong) UILabel *staticPrizeLabel;
@property(nonatomic, strong) UILabel *priezeLabel;
@property(nonatomic, strong) UIView *underLineView;
@property(nonatomic, strong) UILabel *actName;
@property(nonatomic, strong) UILabel *staticPirzeName;
@property(nonatomic, strong) UILabel *prizeName;
@property(nonatomic, strong) UIButton *getState;

@end

@implementation GeeMyPrizeTableViewCell

+ (GeeMyPrizeTableViewCell *)cellForTableView:(UITableView *)tableView
{
    static NSString *reuseId = @"GeeMyPrizeTableViewCell";
    GeeMyPrizeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[GeeMyPrizeTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *back = [[UIView alloc]init];
        self.backView = back;
        [self.contentView addSubview:back];
        back.backgroundColor = [UIColor whiteColor];
        [back.layer setMasksToBounds:YES];
        [back.layer setCornerRadius:2];
        
        UILabel *spzLabel = [[UILabel alloc]init];
        spzLabel.text = @"中将日期";
        spzLabel.textColor = [UIColor colorFromHexRGB:@"565656"];
        spzLabel.font = [UIFont systemFontOfSize:14];
        [back addSubview:spzLabel];
        self.staticPrizeLabel = spzLabel;
        
        UILabel *pzLabel = [[UILabel alloc]init];
        self.priezeLabel = pzLabel;
        pzLabel.font = [UIFont systemFontOfSize:14];
        [back addSubview:pzLabel];
        pzLabel.textColor = [UIColor colorFromHexRGB:@"565656"];
        pzLabel.text = @"2016.06.14-2016.08.15";
        
        UIView *line = [[UIView alloc]init];
        self.underLineView = line;
        [back addSubview:line];
        line.backgroundColor = [UIColor colorFromHexRGB:@"d6d6d6"];
        
        UILabel *actname = [[UILabel alloc]init];
        self.actName = actname;
        [back addSubview:actname];
        actname.text = @"六月充值有礼";
        actname.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nav_barbackground"]];
        actname.font = [UIFont systemFontOfSize:18];
        
        UILabel *spzName = [[UILabel alloc]init];
        self.staticPirzeName = spzName;
        [back addSubview:spzName];
        spzName.textColor = [UIColor colorFromHexRGB:@"565656"];
        spzName.text = @"获得奖品：";
        spzName.font = [UIFont systemFontOfSize:16];
        
        UILabel *pzName = [[UILabel alloc]init];
        [back addSubview:pzName];
        self.prizeName = pzName;
        pzName.text = @"小米移动电源";
        pzName.font = [UIFont systemFontOfSize:16];
        pzName.textColor = [UIColor redColor];
    
        UIButton *state = [[UIButton alloc]init];
        self.getState = state;
        [back addSubview:state];
        [state setTitle:@"未领取" forState:UIControlStateNormal];
        [state setTitleColor:[UIColor colorFromHexRGB:@"3bbafc"] forState:UIControlStateNormal];
        [state.layer setMasksToBounds:YES];
        [state.layer setBorderWidth:1];
        [state.layer setBorderColor:[UIColor colorFromHexRGB:@"3bbafc"].CGColor];
        state.titleLabel.font = [UIFont systemFontOfSize:14];
        
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


- (void)layoutSubviews
{
    self.backView.frame = CGRectMake(5, 0, self.contentView.frame.size.width-2*5, self.contentView.frame.size.height);
    
    CGSize size = [self.staticPrizeLabel.text caculateSizeByFont:self.staticPrizeLabel.font];
    self.staticPrizeLabel.frame = CGRectMake(10, 10, size.width, size.height);
    
    size = [self.priezeLabel.text caculateSizeByFont:self.priezeLabel.font];
    self.priezeLabel.frame = CGRectMake(self.backView.frame.size.width-10-size.width, 10, size.width, size.height);
    
    self.underLineView.frame = CGRectMake(0, CGRectGetMaxY(self.priezeLabel.frame)+10, self.backView.frame.size.width, 1);
    
    size = [self.actName.text caculateSizeByFont:self.actName.font];
    self.actName.frame = CGRectMake(10, CGRectGetMaxY(self.underLineView.frame)+10, size.width, size.height);
    
    size = [self.staticPirzeName.text caculateSizeByFont:self.staticPirzeName.font];
    self.staticPirzeName.frame = CGRectMake(10, CGRectGetMaxY(self.actName.frame)+10, size.width, size.height);

    size = [self.prizeName.text caculateSizeByFont:self.prizeName.font];
    self.prizeName.frame = CGRectMake(CGRectGetMaxX(self.staticPirzeName.frame)+10, self.staticPirzeName.frame.origin.y, size.width, size.height);
    
    self.getState.frame = CGRectMake(self.backView.frame.size.width-10-80, CGRectGetMaxY(self.prizeName.frame)+10, 80, 25);
    [self.getState.layer setCornerRadius:12.5];
}

@end
