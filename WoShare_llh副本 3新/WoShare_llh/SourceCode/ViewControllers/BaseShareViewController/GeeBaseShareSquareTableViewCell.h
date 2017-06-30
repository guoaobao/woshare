//
//  GeeBaseShareSquareTableViewCell.h
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/27.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoListResponse.h"

#define FontSize            14

@interface GeeBaseShareSquareTableViewCell : UITableViewCell

+ (GeeBaseShareSquareTableViewCell *)cellForTableView:(UITableView *)tableView;

//@property(nonatomic, assign) CGFloat cellHeight;
@property (nonatomic,strong)InfoListResponse            *info;

@property(nonatomic, copy) void(^playButtonClicked)();
@property(nonatomic, copy) void(^userHeadButtonClicked)();
@property(nonatomic, copy) void(^clickFrequencyButtonClicked)();
@property(nonatomic, copy) void(^likeButtonClicked)();
@property(nonatomic, copy) void(^collectButtonClicked)();
@property(nonatomic, copy) void(^commentuttonClicked)();
@property(nonatomic, copy) void(^shareButtonClicked)();


@end
