//
//  GeeUpLoadViewController.h
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/22.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeBaseViewController.h"

@interface GeeUpLoadViewController : GeeBaseViewController

@property(nonatomic, copy) NSString *eventid;
@property(nonatomic, assign) BOOL isHideSelectEventBtn;

@property(nonatomic, strong) UIViewController *popToViewController;

@end
