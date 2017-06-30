//
//  Config.h
//  HappyShare
//
//  Created by 胡 波 on 13-7-17.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "UploadData.h"
#import "GiftObject.h"
#import "EventResponse.h"



typedef enum {
    kTransferNetWorkAny = 0,
    kTransferNetworkWifi
}kTransferNetWork;

typedef enum
{
    kLoginTypeNone,
    kLoginTypeUnicomNumber,
    kLoginTypeToken,  //使用之前的token登陆
    klOginTypeAccout, //使用普通帐号登陆
}kLoginType;

typedef enum
{
    kEventStartTypeNone,
    kEventStartTypeCDS,
    kEventStartTypeValentine,  //使用之前的token登陆
}kEventStartType;


@interface Config : NSObject
@property(retain,nonatomic) NSMutableArray *myNoteUids; //登入用户所有关注的uid
@property(copy,nonatomic) NSString *versionDescription;
@property(copy,nonatomic) NSString *minVersionNum;
@property(copy,nonatomic) NSString *versionNum;
@property(copy,nonatomic) NSString *capthcaTime; //配置的发送验证码时间
@property(copy,nonatomic) NSString *defaultMood;
@property(copy,nonatomic) NSString *defaultResourceBrief;
@property(copy,nonatomic) NSString *downloadLink;
@property(copy,nonatomic) NSString *resourceDownUrl;
@property(assign,nonatomic) double ludateline;
@property(assign,nonatomic) double linkupdatelimit;
//sina
@property(copy,nonatomic) NSString *sinaAppKey;
@property(copy,nonatomic) NSString *sinaAppSecret;
@property(copy,nonatomic) NSString *sinaAuthCallbackUrl;
@property(copy,nonatomic) NSString *sinaShareContent;
@property(copy,nonatomic) NSString *sinaShareLink;
@property(copy,nonatomic) NSString *sinaInviteContent;
@property(copy,nonatomic) NSString *sinaShareInfoLink;

@property(copy,nonatomic) NSString *qZoneAppKey;
@property(copy,nonatomic) NSString *qZoneAppSecret;
@property(copy,nonatomic) NSString *qZoneAuthCallbackUrl;
@property(copy,nonatomic) NSString *qZoneShareContent;
@property(copy,nonatomic) NSString *qZoneShareLink;
@property(copy,nonatomic) NSString *qZoneInviteContent;
@property(copy,nonatomic) NSString *qZoneShareInfoLink;

@property(copy,nonatomic) NSString *TXWBAppKey;
@property(copy,nonatomic) NSString *TXWBAppSecret;
@property(copy,nonatomic) NSString *TXWBAuthCallbackUrl;
@property(copy,nonatomic) NSString *TXWBShareContent;
@property(copy,nonatomic) NSString *TXWBShareLink;
@property(copy,nonatomic) NSString *TXWBInviteContent;
@property(copy,nonatomic) NSString *TXWBShareInfoLink;

@property(copy,nonatomic) NSString *WXAppKey;
@property(copy,nonatomic) NSString *WXAppSecret;
@property(copy,nonatomic) NSString *WXAuthCallbackUrl;
@property(copy,nonatomic) NSString *WXShareContent;
@property(copy,nonatomic) NSString *WXShareLink;
@property(copy,nonatomic) NSString *WXInviteContent;
@property(copy,nonatomic) NSString *WXShareInfoLink;
//sms
@property(copy,nonatomic) NSString *smsShareContent;
@property(copy,nonatomic) NSString *smsShareLink;
@property(copy,nonatomic) NSString *smsInviteContent;
@property(copy,nonatomic) NSString *smsShareInfoLink;
//发送验证的时间
@property(retain,nonatomic) NSDate *sendCaptchaTime;  //保存发送验证码的时间
@property(copy,nonatomic) NSString *sendCapthcaPhone; //保存发送验证码的对象
@property(copy,nonatomic) NSString *captchaString;


@property(copy,nonatomic) NSString *useProtocolUrl; //用户协议
@property(retain,nonatomic) NSMutableDictionary *hobbyDic;//所有爱好 ,以k－v 形式 interestid->name
@property(assign,nonatomic)int     hasNewMessage;
@property(retain,nonatomic)NSString *rtspappcode;
@property(retain,nonatomic)NSString *rtspusername;
@property(retain,nonatomic)NSString *rtsppassword;
@property(retain,nonatomic)NSString *rtsptoken;
@property(assign,nonatomic) kLoginType loginType;  //登陆的方式
@property(retain,nonatomic) UploadData *uploadingData; //保存正在上传的data

@property(assign,nonatomic) BOOL        isTabBar;

@property(retain,nonatomic) UploadData *cdsUploadData;
@property(retain,nonatomic) GiftObject *cdsGift;
@property(assign,nonatomic) UIViewController *vc;
@property(retain,nonatomic) EventResponse *cdsEvent;
@property(retain,nonatomic) NSString *cdsEventID;
@property(retain,nonatomic) NSString *cdsPhoneNumber;
@property(assign,nonatomic) BOOL    intoEdit;
@property(assign,nonatomic) BOOL    isInit;
@property(assign,nonatomic) kEventStartType startType;

@property(retain,nonatomic) UploadData *vdUploadData;
@property(nonatomic,copy)   NSString *smsShareWords;
@property(nonatomic,copy)   NSString *snsShareWords;
@property(nonatomic,copy)   NSString *phoneplaceholder;
@property(nonatomic,copy)   NSString *detialplaceholder;


+ (Config *)shareInstance;

+ (NSString *)getLocToken;
+ (void)setLocToken:(NSString *)token;
+ (void)removeLocToken;

//设置传输时的默认网络
+ (void)setDeafultTransferNetWork:(kTransferNetWork)netWork;
+ (kTransferNetWork)getDeafultTransferNerWork;
//配置清除缓存
+ (void)setAutoClearCacheValue:(BOOL)isAuto;
+ (BOOL)getAutoClearCacheValue;
////判断是不是第一次，用key做区分
+ (BOOL)bFirstTime:(NSString *)key;
+ (void)setNotFirstTime:(NSString *)key;
//本地存储的cid管理
+ (NSArray *)getLocCids;
+ (void)addLocCid:(NSString *)cid;//增加一个cid
+ (void)removeLocCid:(NSString *)cid;//删除一个cid
+ (void)addLocCidArray:(NSArray *)cidArray;
//保存用户是否记住用户协议
+ (void)setAgreementSetting:(BOOL)isAgree;
+ (BOOL)getAgreementSetting;

+ (void)setIsGetPush:(BOOL)ispush;
+ (BOOL)getIsGetPush;

//增加一个关注uid
- (void)addNoteUid:(NSString *)uid;
//减去一个关注uid
- (void)removeNoteUid:(NSString *)uid;

+(BOOL)needShowBootView;
+(void)setLocalTime;
+(void)setLastCatURL:(NSString*)str;
+(NSString*)getLastCatURL;
@end
