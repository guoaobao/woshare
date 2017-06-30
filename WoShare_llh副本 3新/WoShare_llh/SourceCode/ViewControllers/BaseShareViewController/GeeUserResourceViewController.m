//
//  GeeUserResourceViewController.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/7/11.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeUserResourceViewController.h"

@interface GeeUserResourceViewController ()

@end

@implementation GeeUserResourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [NSString stringWithFormat:@"%@的空间",self.resourceInfo.userinfo.username];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"cateid"] = @"127";
    dict[@"rows"] = @"20";
    dict[@"getcomment"] = @"1";
    dict[@"getns"] = @"1";
    dict[@"getuserinfo"] = @"1";
    dict[@"page"] = @"1";
    dict[@"uid"] = self.resourceInfo.userinfo.uid;
    [self firstRefreshData:dict andInterFace:kRequestTypeQSearchinfo];
    
    [self setNavBackButton];
    
    [self hideTableViewHeader];
    
    [self setupUserHeaderView:self.resourceInfo];
    
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
