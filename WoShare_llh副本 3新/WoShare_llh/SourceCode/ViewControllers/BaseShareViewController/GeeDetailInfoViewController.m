//
//  GeeDetailInfoViewController.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/22.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeDetailInfoViewController.h"
#import "UIImageView+WebCache.h"
#import "ResourceInfo.h"
#import "NSString+CaculateSize.h"
#import "RequestManager.h"
#import "GeeShowGifViewController.h"
#import "GeeMoviePlayerViewController.h"
#import "KxMovieViewController.h"
#import "GeePictureScanViewController.h"
#import "AppDelegate.h"
#import "GeeShareView.h"
#import "CommentResponse.h"
#import "GeeCommentTableViewCell.h"
#import "GeeShareManager.h"

#define SystemFontSize      15

@interface GeeDetailInfoViewController () <UIScrollViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,RequestManagerDelegate>


@property(nonatomic, strong) UIScrollView *mainScrollView;
@property(nonatomic, strong) UIView *backView;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UIImageView *preScanImageView;

@property(nonatomic, strong) UIButton *clickFrequencyButton;
@property(nonatomic, strong) UIButton *likeButton;
@property(nonatomic, strong) UIButton *collectButton;
@property(nonatomic, strong) UIButton *commentButton;
@property(nonatomic, strong) UIButton *shareButton;

@property(nonatomic, strong) UILabel *detailInfoLabel;
@property(nonatomic, strong) UILabel *timeLabel;

@property(nonatomic, strong) UIView *commentBackView;
@property(nonatomic, strong) UITextField *commentField;
@property(nonatomic, strong) UIButton *commentCommitButton;

@property(nonatomic, strong) NSMutableArray *commentArray;
@property(nonatomic, strong) UITableView *commentTableView;

@property(nonatomic, strong) UIImageView *playButton;

@property(nonatomic, strong) GeeShareManager *sharemanager;
@property(nonatomic, strong) CommentResponse *chooseComment;

@end

@implementation GeeDetailInfoViewController



- (GeeShareManager *)sharemanager
{
    if (_sharemanager == nil) {
        _sharemanager = [[GeeShareManager alloc]init];
    }
    return _sharemanager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"详情";
    [self setNavBackButton];
    
    self.view.backgroundColor = [UIColor colorFromHexRGB:@"f0f0f0"];
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupViewOfController];
    }
    return self;
}

- (void)setupViewOfController
{
    UIScrollView *mainScroll = [[UIScrollView alloc]init];
    self.mainScrollView = mainScroll;
    mainScroll.delegate = self;
    [self.view addSubview:mainScroll];
    
    UIView *backView = [[UIView alloc]init];
    self.backView = backView;
    [mainScroll addSubview:backView];
    backView.backgroundColor = [UIColor whiteColor];
    [backView.layer setMasksToBounds:YES];
    [backView.layer setCornerRadius:2];
    
    UILabel *nameLabel = [[UILabel alloc]init];
    self.nameLabel = nameLabel;
    nameLabel.font = [UIFont systemFontOfSize:18];
    self.nameLabel.numberOfLines = 0;
    [backView addSubview:nameLabel];
    nameLabel.textColor = [UIColor colorFromHexRGB:@"646464"];
    
    UIImageView *preScan = [[UIImageView alloc]init];
    preScan.contentMode = UIViewContentModeScaleToFill;
    self.preScanImageView = preScan;
    [backView addSubview:preScan];
    preScan.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(prescanTapped)];
    [preScan addGestureRecognizer:tap];
    
    UIImageView *play = [[UIImageView alloc]init];
    self.playButton = play;
    play.contentMode = UIViewContentModeScaleAspectFit;
    play.image = [UIImage imageNamed:@"icon-playbutton"];
    [preScan addSubview:play];
    
    UIButton *clickFrequency = [[UIButton alloc]init];
    self.clickFrequencyButton = clickFrequency;
    [backView addSubview:clickFrequency];
    [clickFrequency setImage:[UIImage imageNamed:@"icon-点击率"] forState:UIControlStateNormal];
    [clickFrequency addTarget:self action:@selector(clickFreButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *like = [[UIButton alloc]init];
    self.likeButton = like;
    [backView addSubview:like];
    [like setImage:[UIImage imageNamed:@"icon-未点赞"] forState:UIControlStateNormal];
    [like addTarget:self action:@selector(likeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *collect = [[UIButton alloc]init];
    self.collectButton = collect;
    [backView addSubview:collect];
    [collect setImage:[UIImage imageNamed:@"icon-未收藏"] forState:UIControlStateNormal];
    [collect addTarget:self action:@selector(collectButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *comment = [[UIButton alloc]init];
    self.commentButton = comment;
    [backView addSubview:comment];
    [comment setImage:[UIImage imageNamed:@"icon-点评"] forState:UIControlStateNormal];
    [comment addTarget:self action:@selector(commentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *share = [[UIButton alloc]init];
    self.shareButton = share;
    [backView addSubview:share];
    [share setImage:[UIImage imageNamed:@"icon-分享"] forState:UIControlStateNormal];
    [share addTarget:self action:@selector(shareButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *detailLabel = [[UILabel alloc]init];
    self.detailInfoLabel = detailLabel;
    detailLabel.numberOfLines = 0;
    detailLabel.font = [UIFont systemFontOfSize:SystemFontSize];
    [backView addSubview:detailLabel];
    detailLabel.textColor = [UIColor colorFromHexRGB:@"646464"];
    
    UILabel *timeLabel = [[UILabel alloc]init];
    self.timeLabel = timeLabel;
    timeLabel.font = [UIFont systemFontOfSize:13];
    [backView addSubview:timeLabel];
    timeLabel.textColor = [UIColor colorFromHexRGB:@"c7c7c7"];
    
    UITableView *tableView = [[UITableView alloc]init];
    [mainScroll addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.commentTableView = tableView;
    tableView.backgroundColor = [UIColor clearColor];
    [tableView.layer setMasksToBounds:YES];
    [tableView.layer setCornerRadius:2];
    
    
    UIView *commentBack = [[UIView alloc]init];
    self.commentBackView = commentBack;
    [self.view addSubview:commentBack];
    commentBack.frame = CGRectMake(0, ScreenHeight-64-49, ScreenWidth, 49);
    commentBack.backgroundColor = [UIColor colorFromHexRGB:@"c8c8c8"];
    
    UITextField *commentField = [[UITextField alloc]init];
    self.commentField = commentField;
    [commentBack addSubview:commentField];
    commentField.backgroundColor = [UIColor whiteColor];
    commentField.frame = CGRectMake(10, 9, ScreenWidth-30-60, 31);
    commentField.font = [UIFont systemFontOfSize:15];
    [commentField.layer setMasksToBounds:YES];
    [commentField.layer setCornerRadius:2];
    commentField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 1)];
    commentField.leftViewMode = UITextFieldViewModeAlways;
    commentField.clearButtonMode = UITextFieldViewModeWhileEditing;
    commentField.returnKeyType = UIReturnKeySend;
    commentField.delegate = self;
    
    UIButton *commitButton = [[UIButton alloc]init];
    [commentBack addSubview:commitButton];
    self.commentCommitButton = commitButton;
    commitButton.frame = CGRectMake(CGRectGetMaxX(commentField.frame)+10, 9, 60, 31);
    [commitButton setTitle:@"评论" forState:UIControlStateNormal];
    [commitButton setBackgroundImage:[UIImage imageNamed:@"nav_barbackground"] forState:UIControlStateNormal];
    [commitButton setBackgroundImage:[UIImage imageNamed:@"nav_barbackground"] forState:UIControlStateHighlighted];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitButton.layer setMasksToBounds:YES];
    [commitButton.layer setCornerRadius:2];
    commitButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [commitButton addTarget:self action:@selector(commitComment) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)setResourceInfo:(InfoListResponse *)resourceInfo
{
    _resourceInfo = resourceInfo;
    
    self.nameLabel.text = resourceInfo.title;
    
    if (resourceInfo.infoType == kInfoTypeTheme) {
        
        
        [self.preScanImageView sd_setImageWithURL:[NSURL URLWithString:[resourceInfo getBiggestImageURLString]] placeholderImage:[UIImage imageNamed:@"hs_homepage_loading_defaultpic"]];
    }
    else if (resourceInfo.resourceArray.count > 0) {
        
        NSString *pic = [resourceInfo getBiggestImageURLString];
        if (pic.length > 0) {
            
        } else {
            
            ResourceInfo *re = [resourceInfo.resourceArray objectAtIndex:0];
            pic = [re getBiggestImageURLString];
        }
        
        
        [self.preScanImageView sd_setImageWithURL:[NSURL URLWithString:pic] placeholderImage:[UIImage imageNamed:@"hs_homepage_loading_defaultpic"]];
    } else {
        [self.preScanImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"hs_homepage_loading_defaultpic"]];
    }
    
    self.detailInfoLabel.text = resourceInfo.content;
    self.timeLabel.text = [NSString stringWithDate:[NSDate dateWithTimeIntervalSince1970:resourceInfo.sst] formater:@"yyyy.MM.dd"];
    
    CGRect nameRect = [self.nameLabel.text caculateRectByFont:self.nameLabel.font ByConstrainedSize:CGSizeMake(ScreenWidth-2*5-2*5, MAXFLOAT)];
    self.nameLabel.frame = CGRectMake(5, 5, nameRect.size.width, nameRect.size.height);
    self.preScanImageView.frame = CGRectMake(0, CGRectGetMaxY(self.nameLabel.frame)+5, ScreenWidth-2*5, (ScreenWidth-2*5)/2);
    self.clickFrequencyButton.frame = CGRectMake(5, CGRectGetMaxY(self.preScanImageView.frame)+5, 24, 24);
    self.clickFrequencyButton.hidden = YES;
    if (!self.clickFrequencyButton.isHidden) {
        self.likeButton.frame = CGRectMake(CGRectGetMaxX(self.clickFrequencyButton.frame)+10, self.clickFrequencyButton.frame.origin.y, 24, 24);
    } else {
        self.likeButton.frame = CGRectMake(5, self.clickFrequencyButton.frame.origin.y, 24, 24);
    }
    
    self.playButton.frame = CGRectMake(0, 0, 40, 40);
    self.playButton.center = CGPointMake(self.preScanImageView.frame.size.width/2, self.preScanImageView.frame.size.height/2);
    
    self.playButton.hidden = YES;
    if ([self.resourceInfo.resourceArray count]==1) {
        ResourceInfo  *res = (ResourceInfo*)[self.resourceInfo.resourceArray objectAtIndex:0];
        if ([res.ext isEqualToString:@"gif"] || res.type == kResourceVideo)
        {
            self.playButton.hidden = NO;
        }
    }
    
    self.collectButton.frame = CGRectMake(CGRectGetMaxX(self.likeButton.frame)+10, self.clickFrequencyButton.frame.origin.y, 24, 24);
    self.commentButton.frame = CGRectMake(CGRectGetMaxX(self.collectButton.frame)+10, self.clickFrequencyButton.frame.origin.y, 24, 24);
    self.shareButton.frame = CGRectMake(CGRectGetMaxX(self.commentButton.frame)+10, self.clickFrequencyButton.frame.origin.y, 24, 24);
    
    CGRect detailRect = [self.detailInfoLabel.text caculateRectByFont:self.detailInfoLabel.font ByConstrainedSize:CGSizeMake(ScreenWidth-2*5-2*5, MAXFLOAT)];
    self.detailInfoLabel.frame = CGRectMake(5, CGRectGetMaxY(self.shareButton.frame)+5, detailRect.size.width, detailRect.size.height);
    
    CGSize timesize = [self.timeLabel.text caculateSizeByFont:self.timeLabel.font];
    self.timeLabel.frame = CGRectMake(ScreenWidth-5-10-timesize.width, CGRectGetMaxY(self.detailInfoLabel.frame)+20, timesize.width, timesize.height);
    
    self.backView.frame = CGRectMake(5, 10, ScreenWidth-2*5, CGRectGetMaxY(self.timeLabel.frame)+5);
//    self.commentTableView.frame = CGRectMake(5, CGRectGetMaxY(self.backView.frame)+5, ScreenWidth-2*5, 195);
    self.mainScrollView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-49);
    self.mainScrollView.contentSize = CGSizeMake(0, self.mainScrollView.frame.size.height+1>self.backView.frame.size.height+10+10?self.mainScrollView.frame.size.height+1:self.backView.frame.size.height+10+10);

    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:resourceInfo._id,@"infoid", nil];
    [[RequestManager sharedManager]addDelegate:self];
    [[RequestManager sharedManager]startRequestWithType:kRequestTypeClickInfo withData:dic];
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getComments];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)commentRequest:(NSString *)text
{
    
    NSString *cid = @"";
    NSString *str = [text substringWithRange:NSMakeRange(0, 2)];
    if ([str isEqualToString:@"回复"]) {
        cid = self.chooseComment._id;
    }
    NSDictionary *dic = @{@"id": self.resourceInfo._id?:@"",
                          @"content":text,
                          @"idtype":@"info",
                          @"cid":cid
                          };
    [[RequestManager sharedManager]addDelegate:self];
    [[RequestManager sharedManager]startRequestWithType:kRequestTypeAddComment withData:dic];
    
    
}



- (void)LikeRequest:(InfoListResponse*)info
{
    NSDictionary *dic = @{@"infoid": info==nil?@"":info._id};
    [[RequestManager sharedManager]addDelegate:self];
    [[RequestManager sharedManager]startRequestWithType:kRequestTypeLikeInfo withData:dic];
}


-(void)collectRequest:(InfoListResponse*)info
{
    NSDictionary *dic = @{@"favid": info==nil?@"":info._id,
                          @"idtype":@"info"};
    [[RequestManager sharedManager]addDelegate:self];
    [[RequestManager sharedManager]startRequestWithType:kRequestTypeAddFavorite withData:dic];
}

- (void)clickFreButtonClicked:(UIButton *)button
{
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

- (void)likeButtonClicked:(UIButton *)button
{
    [self LikeRequest:self.resourceInfo];
    
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


- (void)collectButtonClicked:(UIButton *)button
{
    [self collectRequest:self.resourceInfo];
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

- (void)commentButtonClicked:(UIButton *)button
{
    [self.commentField becomeFirstResponder];
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

- (void)shareButtonClicked:(UIButton *)button
{
    GeeShareView *share = [[GeeShareView alloc]init];
    
    share.shareToSina = ^(void) {
        
        self.sharemanager.info = self.resourceInfo;
        [self.sharemanager shareToSina];
        
    };
    
    share.shareToWechat = ^(void) {
        
        self.sharemanager.info = self.resourceInfo;
        [self.sharemanager sendLinkContent];
    };
    
    
    share.shareToWechatFriend = ^(void) {
        self.sharemanager.info = self.resourceInfo;
        [self.sharemanager sendLinkContentToWechatFriend];
    };
    
    share.shareToQQFriend = ^(void) {
        self.sharemanager.info = self.resourceInfo;
        [self.sharemanager sendLinkToQQFriend];
    };
    
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
    
    [[UIApplication sharedApplication].keyWindow addSubview:share];
}

-(void)resourceButton:(InfoListResponse *)info
{
    if ([info.resourceArray count]==1) {
        ResourceInfo  *res = (ResourceInfo*)[info.resourceArray objectAtIndex:0];
        if (res.type == kResourceVideo) {
            if ([res.playUrl length]>0) {
                //播放
//                GeeMoviePlayerViewController *player = [[GeeMoviePlayerViewController alloc]init];
//                player.playUrl = res.playUrl;
//                [self.navigationController pushViewController:player animated:YES];
                NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
                NSString *path=res.playUrl;
                // increase buffering for .wmv, it solves problem with delaying audio frames
                if ([path.pathExtension isEqualToString:@"wmv"])
                    parameters[KxMovieParameterMinBufferedDuration] = @(5.0);
                // disable deinterlacing for iPhone, because it's complex operation can cause stuttering
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
                    parameters[KxMovieParameterDisableDeinterlacing] = @(YES);
                KxMovieViewController *vc = [KxMovieViewController movieViewControllerWithContentPath:path
                                                                                           parameters:parameters];
                [self.navigationController pushViewController:vc animated:YES];

                
            }
        }
        else if ([res.ext isEqualToString:@"gif"])
        {
            [self showGif:res.playUrl];
        }
        else
        {
            //照片预览
            
            GeePictureScanViewController *vc = [[GeePictureScanViewController alloc]init];
            vc.infoList = info;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    else
    {
        //照片预览
        GeePictureScanViewController *vc = [[GeePictureScanViewController alloc]init];
        vc.infoList = info;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)showGif:(NSString *)url
{
    GeeShowGifViewController *vc = [[GeeShowGifViewController alloc]init];
    vc.gifUrl = url;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)prescanTapped
{
    [self resourceButton:self.resourceInfo];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length < 2) {
        [self toast:@"评论过短~"];
        return YES;
    }
    
    [self commentRequest:textField.text];
    [textField endEditing:YES];
    
    self.commentField.text = @"";
    return YES;
}

- (void)commitComment
{
    if (self.commentField.text.length < 2) {
        [self toast:@"评论过短~"];
        return;
    }
    
    [self commentRequest:self.commentField.text];
    [self.commentField endEditing:YES];
    
    self.commentField.text = @"";
}


- (void)deleteComment
{
    NSString *cid = self.chooseComment._id;

    NSDictionary *dic = @{
                          @"cid":cid
                          };
    [[RequestManager sharedManager]addDelegate:self];
    [[RequestManager sharedManager]startRequestWithType:kRequestTypeDelComment withData:dic];
}

- (void)getComments
{
    NSDictionary *dic = @{@"id": self.resourceInfo==nil?@"":self.resourceInfo._id,
                          @"getuserinfo":kRequestGetUserInfo,
                          @"getcomment":@"1",
                          @"idtype":@"info"};
    [[RequestManager sharedManager] addDelegate:self];
    [[RequestManager sharedManager]startRequestWithType:kRequestTypeGetCommentList withData:dic];
}

#pragma mark -- TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.commentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CommentResponse *comment = [self.commentArray objectAtIndex:indexPath.row];
    GeeCommentTableViewCell *cell = [GeeCommentTableViewCell cellForTableView:tableView];
    cell.info = comment;
    
    cell.toolButtonClicked = ^(int index) {
        
        self.chooseComment = comment;
        
        if (index == 0) {
            self.commentField.text = [NSString stringWithFormat:@"回复%@:",comment.userInfo.username];
            [self.commentField becomeFirstResponder];
            
        } else {
            [self deleteComment];
        }
        
        
        
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentResponse *comment = [self.commentArray objectAtIndex:indexPath.row];
    CGRect rect = [comment.comment caculateRectByFont:[UIFont systemFontOfSize:14] ByConstrainedSize:CGSizeMake(ScreenWidth-2*5-45-5-50, MAXFLOAT)];
    return rect.size.height+35;
}

#pragma mark -- WebRequest代理
- (void)webServiceRequest:(RequestType)requestType error:(NSError *)error userData:(id)userData
{
    NSLog(@"失败");
    
    if (requestType == kRequestTypeGetCommentList) {
        [self toast:@"获取评论失败"];
    } else if (requestType == kRequestTypeAddComment) {
        [self getComments];
        [self toast:@"回复失败"];
    } else if (requestType == kRequestTypeDelComment) {
        [self getComments];
        [self toast:@"删除失败"];
    }
    
}

- (void)webServiceRequest:(RequestType)requestType errorString:(NSString *)errorString userData:(id)userData
{
    [self toast:errorString];
}

- (void)webServiceRequest:(RequestType)requestType response:(id)response userData:(id)userData originalData:(id)data
{
    if (requestType == kRequestTypeGetCommentList) {
        self.commentArray = [[NSMutableArray alloc]initWithArray:response];;
        [self.commentTableView reloadData];
        self.commentTableView.frame = CGRectMake(5, CGRectGetMaxY(self.backView.frame)+5, ScreenWidth-2*5, self.commentTableView.contentSize.height);
        self.mainScrollView.contentSize = CGSizeMake(0, self.mainScrollView.frame.size.height+1>self.backView.frame.size.height+10+10+self.commentTableView.frame.size.height?self.mainScrollView.frame.size.height+1:self.backView.frame.size.height+10+10+self.commentTableView.frame.size.height);
    } else if (requestType == kRequestTypeAddComment) {
        [self getComments];
        [self toast:@"回复成功"];
    } else if (requestType == kRequestTypeDelComment) {
        [self getComments];
        [self toast:@"删除成功"];
    } else if (kRequestTypeAddFavorite == requestType) {
        [self toast:@"收藏成功"];
    }
    
}

@end
