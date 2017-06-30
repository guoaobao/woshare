//
//  GeeBaseShareSquareViewController.h
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/27.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeBaseViewController.h"

#import "NSString+CaculateSize.h"
#import "GeeBaseShareSquareTableHeaderView.h"
#import "EGORefreshTableHeaderView.h"
#import "GeeBaseShareSquareTableViewCell.h"

#import "RequestManager.h"
#import "AppDelegate.h"
#import "ResourceInfo.h"
#import "UIImage+GIF.h"

#import "GeeDetailInfoViewController.h"
#import "GeeUpLoadViewController.h"
#import "GeeShareView.h"
#import "GeeActivitySquareViewController.h"
@class GeeShareManager;

@interface GeeBaseShareSquareViewController : GeeBaseViewController <RequestManagerDelegate>


- (void)refreshData:(NSDictionary *)dict andInterface:(RequestType)interface;
- (void)resouceChanged:(NSInteger)index;
- (void)hideTableViewHeader;

- (void)firstRefreshData:(NSDictionary *)dict andInterFace:(RequestType)interface;

- (void)setupUserHeaderView:(InfoListResponse *)resource;

@property(nonatomic, strong) NSDictionary *requestDict;
@property(nonatomic, assign) RequestType requestType;

@end
