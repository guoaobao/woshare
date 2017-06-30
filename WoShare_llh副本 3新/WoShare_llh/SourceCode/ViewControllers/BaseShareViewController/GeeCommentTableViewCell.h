//
//  GeeCommentTableViewCell.h
//  WoShare_llh
//
//  Created by 陆利刚 on 16/7/4.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentResponse.h"

@interface GeeCommentTableViewCell : UITableViewCell

+ (GeeCommentTableViewCell *)cellForTableView:(UITableView *)tableView;

@property(nonatomic, strong) CommentResponse *info;

@property(nonatomic, copy) void(^toolButtonClicked)(int index);//0:回复 1:删除

@end
