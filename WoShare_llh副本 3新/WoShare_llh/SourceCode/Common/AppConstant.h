//
//  AppConstant.h
//  woshare
//
//  Created by 胡波 on 14-2-21.
//  Copyright (c) 2014年 胡波. All rights reserved.
//

#ifndef woshare_AppConstant_h
#define woshare_AppConstant_h

#define kBundleName             @"悦分享"
#define kIDLevel                @"0"
#define kFirstLaunch            @"firstLaunch"
#define kTransferNetWorkKey     @"TransferNerWork"  //传输网络
#define kAutoClearCache         @"AutoClearCache"   //自动清除缓存
#define kRequestError           @"网络出错了哦,请重试!"
#define kLocCids                @"LocalCids"        //本地存储的栏目cid
#define kLocToken               @"LocalToken"       //存储本地token
#define kCaptchaTime            @"captchaTime"      //保存验证码时间
#define kAgreement              @"Agreement"        //用户协议
#define kAppIdLevel             @"4"
#define kDefaultUploadBrief     @"为了让别人对你的作品感兴趣，请卖力地写几句吧"
#define kDefaultSinaAccount     @"@湖南联通悦分享"
#define kDefaultFeedback        @"请提供您的宝贵意见或建议"
#define kDefaultResourceBrief   @"暂无简介"

#define kDefaultReviewNO        @"未通过审核"
#define kDefaultReviewWaiting   @"审核中"

#define kDefaultRows            20
#define kDefaultLoadMoreHeight  0

#define kSelectMoreColumn               @"selectMoreColumn"
#define kNotificationUpdataColumn       @"UpdataColumn"
#define kModifyPSWWhileLoginByUnicom    @"ModifyPSWWhileLoginByUnicom"

#define kRequestDataTypeFile            @"2"
#define kRequestDataTypeFold            @"1"
#define kRequestGetUserInfo             @"1"

#define kAnxunMobileURL                 @"http://110.52.11.184/openapi/"


#define kAXSpid                         @"yueshare"
#define kAXPassword                     @"hnaction"

#define kNotificationLogin          @"notificationLogin"
#define kNotificationLogout          @"notificationLogout"

#define kChangeNameNotification     @"changeNameNotification"

#define kNewMessageNotification         @"hasnewmessage"
#define LJSMSALERTTEXT @"IOS6.0及以上系统限制通讯录权限,请进行【设置】-【隐私】-【通讯录】允许后进行使用。"

#define kUmengAppKey @"5191f32d56240b462300554b"

#define kPlaceholderRectangleImage [UIImage imageNamed:@"hs_homepage_loading_defaultpic"]
#define kPlaceholderSquareImage    [UIImage imageNamed:@"hs_homepage_loading_defaultcpic"]
#define kPlaceholderMusicImage     [UIImage imageNamed:@"hs_invitation_audio"]
#define kBoyHeadImage              [UIImage imageNamed:@"默认头像"]

#define kTabbarHeight           (49)
#define kNavibarHeight          (64)

typedef enum
{
    kUpdateMust = 0,
    kUpdateChoice,
    kUpdateNone
}kUpdateType;

typedef enum
{
    kEventViewAllResource = 0,
    kEventViewMyResource,
    kEventViewRank,    //排名
    kEventViewFine,    //优秀
    kEventViewAward    //中奖名单
}kEventViewType;

#endif

/* 点赞动画
 UIView *zanView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
 zanView.backgroundColor = [UIColor redColor];
 [self.view addSubview:zanView];
 [UIView animateWithDuration:0.3 animations:^{
 zanView.transform = CGAffineTransformMakeScale(1.2, 1.2);
 } completion:^(BOOL finished) {
 [UIView animateWithDuration:0.3 animations:^{
 zanView.transform = CGAffineTransformMakeScale(0.9, 0.9);
 } completion:^(BOOL finished) {
 [UIView animateWithDuration:0.3 animations:^{
 zanView.transform = CGAffineTransformMakeScale(1.0, 1.0);
 } completion:^(BOOL finished) {
 
 }];
 }];
 }];
 */




