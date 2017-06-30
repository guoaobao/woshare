//
//  Config.m
//  HappyShare
//
//  Created by 胡 波 on 13-7-17.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "AppConfig.h"

@implementation Config
+ (Config *)shareInstance
{
    static Config *instance;
    @synchronized(self)
    {
        if(!instance)
        {
            instance = [[Config alloc] init];
        }
    }
    
    return instance;
}

+ (void)setDeafultTransferNetWork:(kTransferNetWork)netWork
{
    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%d",netWork] forKey:kTransferNetWorkKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (kTransferNetWork)getDeafultTransferNerWork
{
    id value = [[NSUserDefaults standardUserDefaults] valueForKey:kTransferNetWorkKey];
    if (!value) {
        return kTransferNetWorkAny;
    }
    if ([value intValue] == 0) {
        return  kTransferNetWorkAny;
    }
    else
    {
        return kTransferNetworkWifi;
    }
}

+ (void)setAutoClearCacheValue:(BOOL)isAuto
{
    [[NSUserDefaults standardUserDefaults] setBool:isAuto forKey:kAutoClearCache];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)getAutoClearCacheValue
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kAutoClearCache];
}

+ (BOOL)bFirstTime:(NSString *)key
{
    return ![[NSUserDefaults standardUserDefaults] boolForKey:key];
}
+ (void)setNotFirstTime:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSArray *)getLocCids
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLocCids];
}
+ (void)addLocCid:(NSString *)cid
{
    NSArray *cidArr = [Config getLocCids];
    NSMutableArray *mutiCidArr = [[NSMutableArray alloc] initWithArray:cidArr];
    if (![mutiCidArr containsObject:cid])
    {
        [mutiCidArr addObject:cid];
    }
    [[NSUserDefaults standardUserDefaults] setObject:mutiCidArr forKey:kLocCids];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [mutiCidArr release];
}
+ (void)removeLocCid:(NSString *)cid
{
    NSArray *cidArr = [Config getLocCids];
    NSMutableArray *mutiCidArr = [[NSMutableArray alloc] initWithArray:cidArr];
    if ([mutiCidArr containsObject:cid])
    {
        [mutiCidArr removeObject:cid];
    }
    [[NSUserDefaults standardUserDefaults] setObject:mutiCidArr forKey:kLocCids];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [mutiCidArr release];
}
+ (void)addLocCidArray:(NSArray *)cidArray
{
    [[NSUserDefaults standardUserDefaults] setObject:cidArray forKey:kLocCids];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)addNoteUid:(NSString *)uid
{
    if (![self.myNoteUids containsObject:uid])
    {
        [self.myNoteUids addObject:uid];
    }
}

- (void)removeNoteUid:(NSString *)uid
{
    if ([self.myNoteUids containsObject:uid])
    {
        [self.myNoteUids removeObject:uid];
    }
}

+ (NSString *)getLocToken
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kLocToken];
}

+ (void)setLocToken:(NSString *)token
{
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:kLocToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (void)removeLocToken
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kLocToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setAgreementSetting:(BOOL)isAgree
{
    [[NSUserDefaults standardUserDefaults] setBool:isAgree forKey:kAgreement];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL)getAgreementSetting
{
    return  [[NSUserDefaults standardUserDefaults] boolForKey:kAgreement];
}

+ (void)setIsGetPush:(BOOL)ispush
{
    [[NSUserDefaults standardUserDefaults] setBool:ispush forKey:@"ispush"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)getIsGetPush
{
    return  [[NSUserDefaults standardUserDefaults] boolForKey:@"ispush"];

}

-(void)setHasNewMessage:(int)hasNewMessage
{
    _hasNewMessage = hasNewMessage;
    [[NSNotificationCenter defaultCenter] postNotificationName:kNewMessageNotification object:nil];
}

+(BOOL)needShowBootView
{
    NSDate *oldDate = [self getOldLocalTime];
    NSDate *date = [NSDate date];
    double dateInter= -[date timeIntervalSinceNow];
    double oldDateInter = [oldDate timeIntervalSinceNow];
    if ((dateInter - oldDateInter) > 24*3600) {
        return YES;
    }
    else
        return YES;
}

+(void)setLocalTime
{
    NSDate *date = [NSDate date];
    [[NSUserDefaults standardUserDefaults] setObject:date forKey:@"localtime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSDate*)getOldLocalTime
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"localtime"];
}

+(void)setLastCatURL:(NSString*)str
{
    [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"LastCatURL"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString*)getLastCatURL
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"LastCatURL"];
}

- (void)dealloc
{
    [_myNoteUids release]; //登入用户所有关注的uid
    [_versionDescription release];
    [_minVersionNum release];
    [_versionNum release];
    [_capthcaTime release]; //配置的发送验证码时间
    [_defaultMood release];
    [_defaultResourceBrief release];
    [_downloadLink release];
    [_sinaAppKey release];
    [_sinaAppSecret release];
    [_sinaAuthCallbackUrl release];
    [_sinaShareContent release];
    [_sinaShareLink release];
    [_sinaInviteContent release];
    [_smsShareContent release];
    [_smsShareLink release];
    [_smsInviteContent release];
    [_sendCaptchaTime release];  //保存发送验证码的时间
    [_sendCapthcaPhone release]; //保存发送验证码的对象
    [_useProtocolUrl release]; //用户协议
    [_hobbyDic release];
    [_rtspappcode release];
    [_rtspusername release];
    [_rtsppassword release];
    [_rtsptoken release];
    [_uploadingData release];
    [_resourceDownUrl release];
    [super dealloc];
}


@end
