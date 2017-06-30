//
//  GeeGoodLuckTableViewCell.h
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/24.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventWinnerResponse.h"

@interface GeeGoodLuckTableViewCell : UITableViewCell

+ (GeeGoodLuckTableViewCell *)cellForTableView:(UITableView *)tableView;

@property(nonatomic, strong) EventWinnerResponse *eventWinner;

@end
