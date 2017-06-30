//
//  GeeHomeViewController.m
//  woshare
//
//  Created by 陆利刚 on 16/6/16.
//  Copyright © 2016年 胡波. All rights reserved.
//

#import "GeeHomeViewController.h"


@interface GeeHomeViewController ()



@end

@implementation GeeHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"首页";
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"cateid"] = @"127";
    dict[@"rows"] = @"20";
    dict[@"getcomment"] = @"1";
    dict[@"getns"] = @"1";
    dict[@"getuserinfo"] = @"1";
    dict[@"page"] = @"1";
    dict[@"ft"] = @"1";
    dict[@"order"] = @"hot";
    [self firstRefreshData:dict andInterFace:kRequestTypeQSearchinfo];
}


@end
