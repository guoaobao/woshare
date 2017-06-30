//
//  GeeActContentListView.h
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/24.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventResponse.h"
#import "InfoListResponse.h"

@interface GeeActContentListView : UIView

@property(nonatomic, strong) EventResponse *eventInfo;

@property(nonatomic, copy) void(^resourceItemClicked)(InfoListResponse *info);

@end
