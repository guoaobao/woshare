//
//  AppDelegate.h
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/21.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeeUploadManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WeiboSDKDelegate>

+(AppDelegate*)sharedAppDelegate;
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic, strong) PPRevealSideViewController *sideViewController;
@property(nonatomic, strong) UINavigationController *rootNavController;
- (void)showLoginFrom:(UIViewController*)owner successToViewController:(UIViewController *)objViewController;


@property (strong, nonatomic) GeeUploadManager          *geeUploadManager;

@property (strong, nonatomic) NSString *wbtoken;
@property (strong, nonatomic) NSString *wbRefreshToken;
@property (strong, nonatomic) NSString *wbCurrentUserID;

@end

