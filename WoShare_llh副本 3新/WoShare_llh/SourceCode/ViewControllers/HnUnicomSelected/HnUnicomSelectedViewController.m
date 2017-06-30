//
//  HnUnicomSelectedViewController.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/7/22.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "HnUnicomSelectedViewController.h"

@interface HnUnicomSelectedViewController ()

@end

@implementation HnUnicomSelectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"精选";
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"cateid"] = @"127";
    dict[@"rows"] = @"20";
    dict[@"getcomment"] = @"1";
    dict[@"getns"] = @"1";
    dict[@"getuserinfo"] = @"1";
    dict[@"page"] = @"1";
    dict[@"cid"] = @"72";
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
