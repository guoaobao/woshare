//
//  GeeBaseNavigationController.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/21.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeBaseNavigationController.h"

@interface GeeBaseNavigationController ()

@end

@implementation GeeBaseNavigationController

+ (void)initialize
{
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_barbackground"] forBarMetrics:UIBarMetricsDefault];
    
    NSMutableDictionary *fontDict = [NSMutableDictionary dictionary];
    fontDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    fontDict[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    [navigationBar setTitleTextAttributes:fontDict];
}

@end
