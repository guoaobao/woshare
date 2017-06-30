//
//  GeeMyCollectionViewController.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/7/4.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeMyCollectionViewController.h"

@implementation GeeMyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的收藏";
    
    
    
    NSDictionary *dic = @{@"getns":@"1",
                          @"getinfo":@"1",
                          @"getuserinfo":kRequestGetUserInfo,
                          @"page":@"1",
                          @"rows":[NSString stringWithFormat:@"%d", kDefaultRows],
                          @"uid":[RequestManager sharedManager].userInfo.uid==nil?@"0":[RequestManager sharedManager].userInfo.uid,
                          };
//    [[RequestManager sharedManager]startRequestWithType:kRequestTypeGetFavoriteList withData:dic];
    
    [self firstRefreshData:dic andInterFace:kRequestTypeGetFavoriteList];
    
    [self setNavBackButton];
    
    [self hideTableViewHeader];
}

@end
