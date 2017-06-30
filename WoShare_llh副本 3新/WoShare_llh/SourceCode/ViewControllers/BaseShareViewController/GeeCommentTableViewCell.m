//
//  GeeCommentTableViewCell.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/7/4.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeCommentTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "RequestManager.h"
#import "NSString+CaculateSize.h"

@interface GeeCommentTableViewCell ()

@property(nonatomic, strong) UIImageView *headIcon;
@property(nonatomic, strong) UILabel *commentLabel;
@property(nonatomic, strong) UILabel *usernameLabel;
@property(nonatomic, strong) UIButton *toolButton;
@property(nonatomic, strong) UILabel *timeLabel;

@end

@implementation GeeCommentTableViewCell

+ (GeeCommentTableViewCell *)cellForTableView:(UITableView *)tableView
{
    static NSString *reuseid = @"GeeCommentTableViewCell";
    GeeCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseid];
    if (cell == nil) {
        cell = [[GeeCommentTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseid];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *icon = [[UIImageView alloc]init];
        self.headIcon = icon;
        [self.contentView addSubview:icon];
        icon.contentMode = UIViewContentModeScaleAspectFit;
        
        UILabel *comment = [[UILabel alloc]init];
        self.commentLabel = comment;
        [self.contentView addSubview:comment];
        comment.font = [UIFont systemFontOfSize:14];
        comment.textColor = [UIColor colorFromHexRGB:@"7f7f7f"];
        comment.numberOfLines = 0;
        
        UILabel *username = [[UILabel alloc]init];
        self.usernameLabel = username;
        [self.contentView addSubview:username];
        username.font = [UIFont systemFontOfSize:14];
        username.textColor = [UIColor colorFromHexRGB:@"7f7f7f"];
        
        UILabel *time = [[UILabel alloc]init];
        self.timeLabel = time;
        [self.contentView addSubview:time];
        time.font = [UIFont systemFontOfSize:14];
        time.textColor = [UIColor colorFromHexRGB:@"7f7f7f"];
        
        UIButton *tool = [[UIButton alloc]init];
        self.toolButton = tool;
        [self.contentView addSubview:tool];
        [tool setBackgroundImage:[UIImage imageNamed:@"comment_response_btn"] forState:UIControlStateNormal];
        [tool setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        tool.titleLabel.font = [UIFont systemFontOfSize:14];
        [tool addTarget:self action:@selector(tooButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setInfo:(CommentResponse *)info
{
    _info = info;
    
    [self.headIcon sd_setImageWithURL:[NSURL URLWithString:info.userInfo.avatar] placeholderImage:[UIImage imageNamed:@"head_boy.jpg"]];
    self.usernameLabel.text = info.userInfo.username;
    self.commentLabel.text = info.comment;
    self.timeLabel.text = [NSString stringWithDate:[NSDate dateWithTimeIntervalSince1970:info.sst] formater:@"yyyy.MM.dd"];
    
    if ([[RequestManager sharedManager].userInfo.uid isEqualToString:info.auid])
    {
        [self.toolButton setTitle:@"删除" forState:UIControlStateNormal];
        self.toolButton.tag = 1;
    } else {
        [self.toolButton setTitle:@"回复" forState:UIControlStateNormal];
        self.toolButton.tag = 0;
    }
}

- (void)layoutSubviews
{
    self.headIcon.frame = CGRectMake(5, self.contentView.frame.size.height/2-40/2, 40, 40);
    [self.headIcon.layer setMasksToBounds:YES];
    [self.headIcon.layer setCornerRadius:20];
    self.commentLabel.frame = CGRectMake(CGRectGetMaxX(self.headIcon.frame)+5, 5, self.contentView.frame.size.width-CGRectGetMaxX(self.headIcon.frame)-5-50, 20);
    CGRect rect = [self.commentLabel.text caculateRectByFont:self.commentLabel.font ByConstrainedSize:CGSizeMake(self.contentView.frame.size.width-CGRectGetMaxX(self.headIcon.frame)-5-50, MAXFLOAT)];
    self.commentLabel.frame = CGRectMake(CGRectGetMaxX(self.headIcon.frame)+5, 5, self.contentView.frame.size.width-CGRectGetMaxX(self.headIcon.frame)-5-50, rect.size.height);
    self.usernameLabel.frame = CGRectMake(self.commentLabel.frame.origin.x, CGRectGetMaxY(self.commentLabel.frame)+5, (self.contentView.frame.size.width-self.commentLabel.frame.origin.x-5-5)*0.7, 20);
    self.timeLabel.frame = CGRectMake(CGRectGetMaxX(self.usernameLabel.frame)+5, self.usernameLabel.frame.origin.y, (self.contentView.frame.size.width-self.commentLabel.frame.origin.x-5-5)*0.3, 20);
    self.toolButton.frame = CGRectMake(self.contentView.frame.size.width-55, 5, 50, 20);
    
}

- (void)tooButtonClicked:(UIButton *)button
{
    if (self.toolButtonClicked) {
        self.toolButtonClicked((int)button.tag);
    }
}

@end
