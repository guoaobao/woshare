//
//  GeeBaseShareSquareTableViewCell.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/27.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeBaseShareSquareTableViewCell.h"

#import "NSString+CaculateSize.h"
#import "ResourceInfo.h"
#import "UIImageView+WebCache.h"
#import "RequestManager.h"



@interface GeeBaseShareSquareTableViewCell ()


@property(nonatomic, strong) UIImageView *userIconButton;
@property(nonatomic, strong) UILabel *userNameLabel;
@property(nonatomic, strong) UILabel *vedioTimeLabel;
@property(nonatomic, strong) UILabel *vedioNameLabel;

@property(nonatomic, strong) UIView *scanBackView;
@property(nonatomic, strong) UILabel *scanNumLabel;
@property(nonatomic, strong) UILabel *scanLabel;

@property(nonatomic, strong) UIImageView *preScanView;
@property(nonatomic, strong) UILabel *textContentLabel;
@property(nonatomic, strong) UIImageView *playButton;

@property(nonatomic, strong) UIView *lineView;
@property(nonatomic, strong) NSArray *shortLinesArray;

@property(nonatomic, strong) UILabel *likeNumLabel;
@property(nonatomic, strong) UIButton *likeButton;

@property(nonatomic, strong) UILabel *collectNumLabel;
@property(nonatomic, strong) UIButton *collectButton;

@property(nonatomic, strong) UILabel *commentNumLabel;
@property(nonatomic, strong) UIButton *commentButton;

//@property(nonatomic, strong) UILabel *shareNumLabel;
@property(nonatomic, strong) UIButton *shareButton;

@end

@implementation GeeBaseShareSquareTableViewCell

+ (GeeBaseShareSquareTableViewCell *)cellForTableView:(UITableView *)tableView
{
    static NSString *identifier = @"GeeHomeTableViewCell";
    GeeBaseShareSquareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[GeeBaseShareSquareTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //用户头像
        UIImageView *userHead = [[UIImageView alloc]init];
        self.userIconButton = userHead;
        userHead.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:userHead];
        [userHead.layer setMasksToBounds:YES];
        userHead.userInteractionEnabled = YES;
        UITapGestureRecognizer *userheadTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userheadTapped)];
        [userHead addGestureRecognizer:userheadTap];
        //用户名
        UILabel *userName = [[UILabel alloc]init];
        self.userNameLabel = userName;
        [self.contentView addSubview:userName];
        userName.text = @"用户名";
        userName.font = [UIFont systemFontOfSize:FontSize];
        userName.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nav_barbackground"]];
        //日期
        UILabel *vedioTime = [[UILabel alloc]init];
        self.vedioTimeLabel = vedioTime;
        [self.contentView addSubview:vedioTime];
        vedioTime.font = [UIFont systemFontOfSize:10];
        vedioTime.text = @"视频时间";
        vedioTime.textColor = [UIColor colorFromHexRGB:@"969696"];
        //视频名称
        UILabel *vedioName = [[UILabel alloc]init];
        self.vedioNameLabel = vedioName;
        [self.contentView addSubview:vedioName];
        vedioName.font = [UIFont systemFontOfSize:FontSize];
        vedioName.text = @"视频名字";
        vedioName.textColor = [UIColor colorFromHexRGB:@"969696"];
        vedioName.numberOfLines = 0;
        //点击率背景
        UIView *scanbackview = [[UIView alloc]init];
        [self.contentView addSubview:scanbackview];
        self.scanBackView = scanbackview;
        [scanbackview.layer setMasksToBounds:YES];
        [scanbackview.layer setCornerRadius:3];
        [scanbackview.layer setBorderColor:[UIColor colorFromHexRGB:@"969696"].CGColor];
        [scanbackview.layer setBorderWidth:0.5];
        //点击率数字
        UILabel *scannum = [[UILabel alloc]init];
        self.scanNumLabel = scannum;
        [scanbackview addSubview:scannum];
        scannum.textColor = [UIColor colorFromHexRGB:@"969696"];
        scannum.font = [UIFont systemFontOfSize:9];
        scannum.textAlignment = NSTextAlignmentCenter;
        scannum.text = @"0";
        //点击率文字
        UILabel *scantext = [[UILabel alloc]init];
        self.scanLabel = scantext;
        [scanbackview addSubview:scantext];
        scantext.text = @"浏览";
        scantext.font = [UIFont systemFontOfSize:9];
        scantext.textColor = [UIColor colorFromHexRGB:@"969696"];
        scantext.textAlignment = NSTextAlignmentCenter;
        //预览图片
        UIImageView *preScan = [[UIImageView alloc]init];
        self.preScanView = preScan;
        preScan.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:preScan];
        preScan.userInteractionEnabled = YES;
        UITapGestureRecognizer *scanTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(scanTapped)];
        [preScan addGestureRecognizer:scanTap];
        //播放按钮
        UIImageView *play = [[UIImageView alloc]init];
        self.playButton = play;
        play.contentMode = UIViewContentModeScaleAspectFit;
        play.image = [UIImage imageNamed:@"icon-playbutton"];
        [preScan addSubview:play];
        //预览文本
        UILabel *textContent = [[UILabel alloc]init];
        self.textContentLabel = textContent;
        [self.contentView addSubview:textContent];
        textContent.numberOfLines = 0;
        textContent.textColor = [UIColor colorFromHexRGB:@"969696"];
        textContent.font = [UIFont systemFontOfSize:FontSize];
        //分割线
        UIView *separateline = [[UIView alloc]init];
        self.lineView = separateline;
        [self.contentView addSubview:separateline];
        separateline.backgroundColor = [UIColor colorFromHexRGB:@"d7d7d7"];
        //分割线
        NSMutableArray *separateArray = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            UIView *line = [[UIView alloc]init];
            line.backgroundColor = [UIColor colorFromHexRGB:@"d7d7d7"];
            line.tag = i;
            [self.contentView addSubview:line];
            [separateArray addObject:line];
        }
        self.shortLinesArray = separateArray;
        //喜欢按钮
        UIButton *like = [[UIButton alloc]init];
        self.likeButton = like;
        like.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [like setImage:[UIImage imageNamed:@"icon-未点赞"] forState:UIControlStateNormal];
        [like setImage:[UIImage imageNamed:@"icon-点赞"] forState:UIControlStateSelected];
        [self.contentView addSubview:like];
        [like addTarget:self action:@selector(interactionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        //喜欢次数
        UILabel *likenum = [[UILabel alloc]init];
        self.likeNumLabel = likenum;
        likenum.text = @"0";
        [self.contentView addSubview:likenum];
        likenum.textColor = [UIColor colorFromHexRGB:@"969696"];
        likenum.font = [UIFont systemFontOfSize:15];
        //收藏按钮
        UIButton *collect = [[UIButton alloc]init];
        collect.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [collect setImage:[UIImage imageNamed:@"icon-未收藏"] forState:UIControlStateNormal];
        [collect setImage:[UIImage imageNamed:@"icon-收藏"] forState:UIControlStateSelected];
        self.collectButton = collect;
        [self.contentView addSubview:collect];
        [collect addTarget:self action:@selector(interactionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        //收藏次数
        UILabel *collectnum = [[UILabel alloc]init];
        self.collectNumLabel = collectnum;
        collectnum.text = @"0";
        [self.contentView addSubview:collectnum];
        collectnum.textColor = [UIColor colorFromHexRGB:@"969696"];
        collectnum.font = [UIFont systemFontOfSize:15];
        //评论按钮
        UIButton *comment = [[UIButton alloc]init];
        comment.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [comment setImage:[UIImage imageNamed:@"icon-点评"] forState:UIControlStateNormal];
        self.commentButton = comment;
        [self.contentView addSubview:comment];
        [comment addTarget:self action:@selector(interactionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        //评论次数
        UILabel *commentnum = [[UILabel alloc]init];
        self.commentNumLabel = commentnum;
        commentnum.text = @"0";
        [self.contentView addSubview:commentnum];
        commentnum.textColor = [UIColor colorFromHexRGB:@"969696"];
        commentnum.font = [UIFont systemFontOfSize:15];
        //分享按钮
        UIButton *share = [[UIButton alloc]init];
        share.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [share setImage:[UIImage imageNamed:@"icon-分享"] forState:UIControlStateNormal];
        self.shareButton = share;
        [self.contentView addSubview:share];
        [share addTarget:self action:@selector(interactionButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        分享次数
//        UILabel *sharenum = [[UILabel alloc]init];
//        self.shareNumLabel = sharenum;
//        sharenum.text = @"0";
//        [self.contentView addSubview:sharenum];
//        sharenum.textColor = [UIColor colorFromHexRGB:@"969696"];
//        sharenum.font = [UIFont systemFontOfSize:15];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setInfo:(InfoListResponse *)info
{
    _info = info;
    
    NSString *url = info.userinfo.avatar?:@"";
    if (![url containsString:@"http://"]) {
        url = [[RequestManager sharedManager].picbaseurl stringByAppendingString:url];
    }
    
    [self.userIconButton sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"icon-userhead.jpg"]];
    self.userNameLabel.text = info.userinfo.username;
    self.vedioTimeLabel.text = [NSString stringWithDate:[NSDate dateWithTimeIntervalSince1970:info.sst] formater:@"yyyy-MM-dd"];
    
    if (info.infoType == kInfoTypeTheme) {
        self.preScanView.hidden = YES;
        self.textContentLabel.text = info.content;
        self.textContentLabel.hidden = NO;
    }
    else if (info.resourceArray.count > 0) {
        self.preScanView.hidden = NO;
        ResourceInfo *re = [info.resourceArray objectAtIndex:0];
        
        NSString *pic = [self.info getBiggestImageURLString];
        if (pic.length > 0) {
            
        } else {
            pic = [re getBiggestImageURLString];
        }
        
        [self.preScanView sd_setImageWithURL:[NSURL URLWithString:pic] placeholderImage:[UIImage imageNamed:@"hs_homepage_loading_defaultpic"]];
        self.textContentLabel.hidden = YES;
    } else {
        self.preScanView.hidden = YES;
        self.textContentLabel.hidden = YES;
    }
    
    self.vedioNameLabel.text = info.title;
    
    self.likeNumLabel.text = [NSString stringWithFormat:@"%ld",info.pts];
    self.collectNumLabel.text = [NSString stringWithFormat:@"%ld",info.fts];
    self.commentNumLabel.text = [NSString stringWithFormat:@"%ld",info.dts];
    
    NSString *times = @"0";
    if (info.cts < 10000) {
        times = [NSString stringWithFormat:@"%ld",info.cts];
    } else {
        times = [NSString stringWithFormat:@"%ld.%ld万",info.cts/10000,info.cts/10000%1000];
    }
    self.scanNumLabel.text = times;
}


- (void)scanTapped
{
    if (self.playButtonClicked) {
        self.playButtonClicked();
    }
}

- (void)userheadTapped
{
    if (self.userHeadButtonClicked) {
        self.userHeadButtonClicked();
    }
}

- (void)interactionButtonClicked:(UIButton *)button
{
    if (button == self.likeButton) {
        self.likeButtonClicked();
    } else if (button == self.collectButton) {
        self.collectButtonClicked();
    } else if (button == self.commentButton) {
        self.commentuttonClicked();
    } else {
        self.shareButtonClicked();
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        button.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            button.transform = CGAffineTransformMakeScale(0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                button.transform = CGAffineTransformMakeScale(1.0, 1.0);
            } completion:^(BOOL finished) {
            }];
        }];
    }];
}

- (void)layoutSubviews
{
    //用户头像
    self.userIconButton.frame = CGRectMake(5, 5, 35, 35);
    [self.userIconButton.layer setCornerRadius:35/2];
    //用户名
    self.userNameLabel.frame = CGRectMake(CGRectGetMaxX(self.userIconButton.frame)+5, self.userIconButton.frame.origin.y, self.contentView.frame.size.width-5-35-5-50-5-5, self.userIconButton.frame.size.height/2);
    //时间
    self.vedioTimeLabel.frame = CGRectMake(self.userNameLabel.frame.origin.x, CGRectGetMaxY(self.userNameLabel.frame), 150, self.userIconButton.frame.size.height/2);
    //点击率背景
    self.scanBackView.frame = CGRectMake(self.contentView.frame.size.width-5-50, CGRectGetMidY(self.userIconButton.frame)-25/2, 50, 25);
    //点击次数
    self.scanNumLabel.frame = CGRectMake(0, 0, self.scanBackView.frame.size.width, self.scanBackView.frame.size.height/2);
    //点击文本
    self.scanLabel.frame = CGRectMake(0, self.scanBackView.frame.size.height/2, self.scanBackView.frame.size.width, self.scanBackView.frame.size.height/2);
    //视频标题名称
    self.vedioNameLabel.frame = CGRectMake(5, CGRectGetMaxY(self.userIconButton.frame)+5, self.contentView.frame.size.width-2*5, 25);
    //预览图片
    self.preScanView.frame = CGRectMake(5, CGRectGetMaxY(self.vedioNameLabel.frame)+5, self.contentView.frame.size.width-2*5, (self.contentView.frame.size.width-2*5)/2);
    //播放按钮
    self.playButton.frame = CGRectMake(0, 0, 40, 40);
    self.playButton.center = CGPointMake(self.preScanView.frame.size.width/2, self.preScanView.frame.size.height/2);
    self.playButton.hidden = YES;
    if ([self.info.resourceArray count]==1) {
        ResourceInfo  *res = (ResourceInfo*)[self.info.resourceArray objectAtIndex:0];
        if ([res.ext isEqualToString:@"gif"] || res.type == kResourceVideo) {
            self.playButton.hidden = NO;
        }
    }
    //正文文本
    if (self.info.infoType == kInfoTypeTheme) {
        CGRect textrect = [self.textContentLabel.text caculateRectByFont:self.textContentLabel.font ByConstrainedSize:CGSizeMake(self.contentView.frame.size.width-5*2, MAXFLOAT)];
        self.textContentLabel.frame = CGRectMake(5, CGRectGetMaxY(self.vedioNameLabel.frame)+5, textrect.size.width, textrect.size.height);
    }
    //下划线
    self.lineView.frame = CGRectMake(0, CGRectGetMaxY(self.preScanView.frame)+5, self.contentView.frame.size.width, 0.5);
    if (self.info.infoType == kInfoTypeTheme) {
        self.lineView.frame = CGRectMake(0, CGRectGetMaxY(self.textContentLabel.frame)+5, self.contentView.frame.size.width, 0.5);
    }
    //短线
    CGFloat width = self.contentView.frame.size.width/(self.shortLinesArray.count+1);
    for (int i = 0; i < self.shortLinesArray.count; i++) {
        UIView *line = [self.shortLinesArray objectAtIndex:i];
        line.frame = CGRectMake(width*(i+1), CGRectGetMaxY(self.lineView.frame)+10, 0.5, 15);
    }
    //点赞按钮
    self.likeButton.frame = CGRectMake(width/2-2-25, CGRectGetMaxY(self.lineView.frame)+5, 25, 25);
    //点赞数量
    self.likeNumLabel.frame = CGRectMake(width/2+2, CGRectGetMaxY(self.lineView.frame)+5, width/2-5*2, 25);
    //收藏按钮
    self.collectButton.frame = CGRectMake(width/2*3-2-25, CGRectGetMaxY(self.lineView.frame)+5, 25, 25);
    //收藏数量
    self.collectNumLabel.frame = CGRectMake(width/2*3+2, CGRectGetMaxY(self.lineView.frame)+5, width/2-5*2, 25);
    //评论按钮
    self.commentButton.frame = CGRectMake(width/2*5-2-25, CGRectGetMaxY(self.lineView.frame)+5, 25, 25);
    //评论数量
    self.commentNumLabel.frame = CGRectMake(width/2*5+2, CGRectGetMaxY(self.lineView.frame)+5, width/2-5*2, 25);
    //分享按钮
    self.shareButton.frame = CGRectMake(width/2*7-25/2, CGRectGetMaxY(self.lineView.frame)+5, 25, 25);
    //分享数量
//    self.shareNumLabel.frame = CGRectMake(width/2*7+2, CGRectGetMaxY(self.lineView.frame)+5, width/2-5*2, 25);
    
}

@end
