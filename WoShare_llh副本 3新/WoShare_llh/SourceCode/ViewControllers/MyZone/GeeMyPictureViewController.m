//
//  GeeMyPictureViewController.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/28.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeMyPictureViewController.h"

@interface GeeMyPictureViewController ()

@end

@implementation GeeMyPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的图片";
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"cateid"] = @"127";
    dict[@"rows"] = @"20";
    dict[@"getcomment"] = @"1";
    dict[@"getns"] = @"1";
    dict[@"getuserinfo"] = @"1";
    dict[@"page"] = @"1";
    dict[@"ft"] = @"3";
//    dict[@"order"] = @"hot";
    dict[@"uid"] = [RequestManager sharedManager].userInfo.uid;
    [self firstRefreshData:dict andInterFace:kRequestTypeQSearchinfo];
    
    [self setNavBackButton];
    
    [self hideTableViewHeader];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
