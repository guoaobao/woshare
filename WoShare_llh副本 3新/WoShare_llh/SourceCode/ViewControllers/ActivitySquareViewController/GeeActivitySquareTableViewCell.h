//
//  GeeActivitySquareTableViewCell.h
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/22.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventResponse.h"

@interface GeeActivitySquareTableViewCell : UITableViewCell

+ (GeeActivitySquareTableViewCell *)cellForTableView:(UITableView *)tableView;

@property(nonatomic, strong) EventResponse *eventInfo;

@end
