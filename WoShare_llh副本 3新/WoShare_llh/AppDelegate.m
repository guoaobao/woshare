//
//  AppDelegate.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/21.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "AppDelegate.h"

#import "GeeBaseNavigationController.h"
#import "GeeHomeViewController.h"
#import "GeeLeftViewController.h"
#import "PPRevealSideViewController.h"
#import "GeeLoginViewController.h"
#import "GeeUploadPlistTaskManager.h"
#import "RequestType.h"
#import "ASIHTTPRequest.h"
#import "RequestType.h"
#import "URLDefine.h"
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>


@interface AppDelegate ()<WXApiDelegate>

@property(nonatomic, strong) TencentOAuth *auth;

@end

@implementation AppDelegate


+(AppDelegate*)sharedAppDelegate
{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];

    UINavigationController *root = [[GeeBaseNavigationController alloc]initWithRootViewController:[[GeeHomeViewController alloc]init]];
    self.rootNavController = root;
    self.sideViewController = [[PPRevealSideViewController alloc]initWithRootViewController:root];
    self.sideViewController.directionsToShowBounce = PPRevealSideDirectionNone;
    [self.sideViewController setPanInteractionsWhenClosed:PPRevealSideInteractionNone];
    [self.sideViewController setPanInteractionsWhenOpened:PPRevealSideInteractionNone];
    GeeLeftViewController *leftViewController = [GeeLeftViewController shareManager];
    [self.sideViewController preloadViewController:leftViewController forSide:PPRevealSideDirectionLeft];
    self.window.rootViewController = self.sideViewController;
    [self.window makeKeyAndVisible];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    [self getConfig];
    
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
    
    [[RequestManager sharedManager]startService];
    
    //向微信注册
    [WXApi registerApp:@"wxa84971f204e7d28d" withDescription:@"悦分享"];

    //QQ
    self.auth = [[TencentOAuth alloc] initWithAppId:@"801431200" andDelegate:nil]; //注册
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginAction) name:kNotificationLogin object:nil];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
//    return [WeiboSDK handleOpenURL:url delegate:self];
    
    if ([WXApi handleOpenURL:url delegate:self]) {
        return YES;
    } else if ([WeiboSDK handleOpenURL:url delegate:self]) {
        return YES;
    } else if ([TencentOAuth HandleOpenURL:url]) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
//    return [WeiboSDK handleOpenURL:url delegate:self ];
    if ([WXApi handleOpenURL:url delegate:self]) {
        return YES;
    } else if ([WeiboSDK handleOpenURL:url delegate:self]) {
        return YES;
    } else if ([TencentOAuth HandleOpenURL:url]) {
        return YES;
    } else {
        return NO;
    }
}

/*! @brief 收到一个来自微信的请求，第三方应用程序处理完后调用sendResp向微信发送结果
 *
 * 收到一个来自微信的请求，异步处理完成后必须调用sendResp发送处理结果给微信。
 * 可能收到的请求有GetMessageFromWXReq、ShowMessageFromWXReq等。
 * @param req 具体请求内容，是自动释放的
 */
-(void) onReq:(BaseReq*)req
{
    
}



/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp具体的回应内容，是自动释放的
 */
-(void) onResp:(BaseResp*)resp
{
}


/**
 收到一个来自微博客户端程序的请求
 
 收到微博的请求后，第三方应用应该按照请求类型进行处理，处理完后必须通过 [WeiboSDK sendResponse:] 将结果回传给微博
 @param request 具体的请求对象
 */
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

/**
 收到一个来自微博客户端程序的响应
 
 收到微博的响应后，第三方应用可以通过响应类型、响应的数据和 WBBaseResponse.userInfo 中的数据完成自己的功能
 @param response 具体的响应对象
 */
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if([response isKindOfClass:WBShareMessageToContactResponse.class])
    {
        NSString *title = NSLocalizedString(@"发送结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode, NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil),response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        WBShareMessageToContactResponse* shareMessageToContactResponse = (WBShareMessageToContactResponse*)response;
        NSString* accessToken = [shareMessageToContactResponse.authResponse accessToken];
        if (accessToken)
        {
            self.wbtoken = accessToken;
        }
        NSString* userID = [shareMessageToContactResponse.authResponse userID];
        if (userID) {
            self.wbCurrentUserID = userID;
        }
        [alert show];
    }
}


#pragma mark -loginAction

- (void)loginAction
{
    [self initGeeUploader];
}

- (void)showLoginFrom:(UIViewController*)owner successToViewController:(UIViewController *)objViewController
{
    if (owner == objViewController) {
        NSLog(@"woner和ObjViewController不能为同一个");
        return;
    }
    
    GeeLoginViewController *loginVC = [[GeeLoginViewController alloc] init];
    loginVC.objViewController = objViewController;
    GeeBaseNavigationController *nav = [[GeeBaseNavigationController alloc] initWithRootViewController:loginVC];
    
    [owner presentViewController:nav animated:YES completion:nil];
}


- (void)initGeeUploader
{
    IGeeUploadTaskManager* manager = [[GeeUploadMemTaskManager alloc] initWithUID:[RequestManager sharedManager].userInfo.uid isRemoveCompleteTask:YES isRemoveErrorTask:YES];
    GeeUploadManager *tempUploader = [[GeeUploadManager alloc] initWithUrl:[NSString stringWithFormat:@"%@%@%@",NewBaseAppURL,GetUploadURL,[RequestManager sharedManager].userInfo.token] uploadParentFolderName:kBundleName taskManager:manager];
    self.geeUploadManager = tempUploader;
    
    [self.geeUploadManager doTask];
}

#pragma mark - get config

-(void)getConfig
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BaseAppURL,GetConfigURL]];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSString *response = [request responseString];
        NSString *path = FVGetPathWithType(kFVPathTypeConfigCache, nil);
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:response,@"jsondic",[NSDate date],@"savedate", nil];
        BOOL result = [dict writeToFile:path atomically:YES];
        if (!result) {
            //            FVLog(@"cache error with code 4068");
        }
        else
        {
            //            FVLog(@"\n-------------------------------------\nconfig cache ok\n-------------------------------------\n");
        }
        //        _isGotConfig = YES;
        NSData *resultData = [response dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *resultDict = [resultData objectFromJSONData];
        [self parseConfig:[resultDict objectForKey:@"data"]];

    }
    else
    {
        NSString *path = FVGetPathWithType(kFVPathTypeConfigCache, nil);
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
        if ([dic objectForKey:@"jsondic"] ==nil) {
            //            _isGotConfig = NO;
        }
        else
        {
            //            _isGotConfig = YES;
            NSData *resultData = [[dic objectForKey:@"jsondic"] dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *resultDict = [resultData objectFromJSONData];
            [self parseConfig:[resultDict objectForKey:@"data"]];

        }
    }
}




- (void)parseConfig:(NSDictionary *)dic
{
    NSDictionary *defaultInfoDic = [dic objectForKey:@"defaultinfo"];
    NSDictionary *iphoneCopyRightDic = [dic objectForKey:@"iphone_copyrightinfo"];
    NSDictionary *thirdUserInfoDic = [dic objectForKey:@"thirduser"];
    NSDictionary *weixinInfoDic = [thirdUserInfoDic objectForKey:@"weixin"];
    NSDictionary *qqInfoDic = [thirdUserInfoDic objectForKey:@"qq"];
    NSDictionary *tencentInfoDic = [thirdUserInfoDic objectForKey:@"tencent"];
    NSDictionary *sinaInfoDic = [thirdUserInfoDic objectForKey:@"sina"];
    NSDictionary *smsDic = [thirdUserInfoDic objectForKey:@"sms"];
    NSDictionary *supereyeDic = [thirdUserInfoDic objectForKey:@"supereyes"];
    [Config shareInstance].versionDescription = [iphoneCopyRightDic objectForKey:@"description"];
    [Config shareInstance].minVersionNum = [iphoneCopyRightDic objectForKey:@"minversion"];
    [Config shareInstance].versionNum = [iphoneCopyRightDic objectForKey:@"version"];
    [Config shareInstance].capthcaTime = [defaultInfoDic objectForKey:@"captchafailtime"];
    [Config shareInstance].resourceDownUrl = [defaultInfoDic objectForKey:@"resourcedownurl"];
    [Config shareInstance].defaultMood = [defaultInfoDic objectForKey:@"defaultmood"];
    [Config shareInstance].sinaAppKey = [sinaInfoDic objectForKey:@"appkey"];
    [Config shareInstance].sinaAppSecret = [sinaInfoDic objectForKey:@"appsecret"];
    [Config shareInstance].sinaAuthCallbackUrl = [sinaInfoDic objectForKey:@"authcburl"];
    [Config shareInstance].sinaShareContent = [sinaInfoDic objectForKey:@"sharecontent"];
    [Config shareInstance].sinaInviteContent = [sinaInfoDic objectForKey:@"invitecontent"];
    [Config shareInstance].sinaShareInfoLink = [sinaInfoDic objectForKey:@"shareinfolink"];
    [Config shareInstance].sinaShareLink = [sinaInfoDic objectForKey:@"sharelink"];
    [Config shareInstance].smsShareContent = [smsDic objectForKey:@"sharecontent"];
    [Config shareInstance].smsShareLink = [smsDic objectForKey:@"sharelink"];
    [Config shareInstance].smsInviteContent = [smsDic objectForKey:@"invitecontent"];
    [Config shareInstance].smsShareInfoLink = [smsDic objectForKey:@"shareinfolink"];
    
    [Config shareInstance].defaultResourceBrief = [defaultInfoDic objectForKey:@"defaultbrief"];
    [Config shareInstance].downloadLink = [iphoneCopyRightDic objectForKey:@"downloadurl"];
    [Config shareInstance].useProtocolUrl = [defaultInfoDic objectForKey:@"useprotocolurl"];
    [Config shareInstance].ludateline = [[dic objectForKey:@"ludateline"]doubleValue];
    [Config shareInstance].linkupdatelimit = [[defaultInfoDic objectForKey:@"linkupdatelimit"]doubleValue];
    [Config shareInstance].rtspappcode = [supereyeDic objectForKey:@"appcode"];
    [Config shareInstance].rtsppassword = [supereyeDic objectForKey:@"password"];
    [Config shareInstance].rtsptoken = [supereyeDic objectForKey:@"token"];
    [Config shareInstance].rtspusername = [supereyeDic objectForKey:@"username"];
    
    [Config shareInstance].WXAppKey = [weixinInfoDic objectForKey:@"appkey"];
    [Config shareInstance].WXAppSecret = [weixinInfoDic objectForKey:@"appsecret"];
    [Config shareInstance].WXAuthCallbackUrl = [weixinInfoDic objectForKey:@"authcburl"];
    [Config shareInstance].WXShareContent = [weixinInfoDic objectForKey:@"sharecontent"];
    [Config shareInstance].WXInviteContent = [weixinInfoDic objectForKey:@"invitecontent"];
    [Config shareInstance].WXShareInfoLink = [weixinInfoDic objectForKey:@"shareinfolink"];
    [Config shareInstance].WXShareLink = [weixinInfoDic objectForKey:@"sharelink"];
    
    [Config shareInstance].TXWBAppKey = [tencentInfoDic objectForKey:@"appkey"];
    [Config shareInstance].TXWBAppSecret = [tencentInfoDic objectForKey:@"appsecret"];
    [Config shareInstance].TXWBAuthCallbackUrl = [tencentInfoDic objectForKey:@"authcburl"];
    [Config shareInstance].TXWBShareContent = [tencentInfoDic objectForKey:@"sharecontent"];
    [Config shareInstance].TXWBInviteContent = [tencentInfoDic objectForKey:@"invitecontent"];
    [Config shareInstance].TXWBShareInfoLink = [tencentInfoDic objectForKey:@"shareinfolink"];
    [Config shareInstance].TXWBShareLink = [tencentInfoDic objectForKey:@"sharelink"];
    
    [Config shareInstance].qZoneAppKey = [qqInfoDic objectForKey:@"appkey"];
    [Config shareInstance].qZoneAppSecret = [qqInfoDic objectForKey:@"appsecret"];
    [Config shareInstance].qZoneAuthCallbackUrl = [qqInfoDic objectForKey:@"authcburl"];
    [Config shareInstance].qZoneShareContent = [qqInfoDic objectForKey:@"sharecontent"];
    [Config shareInstance].qZoneInviteContent = [qqInfoDic objectForKey:@"invitecontent"];
    [Config shareInstance].qZoneShareInfoLink = [qqInfoDic objectForKey:@"shareinfolink"];
    [Config shareInstance].qZoneShareLink = [qqInfoDic objectForKey:@"sharelink"];
}


@end
