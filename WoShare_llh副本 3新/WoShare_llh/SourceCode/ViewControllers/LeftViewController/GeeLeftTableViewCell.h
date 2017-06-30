//
//  GeeLeftTableViewCell.h
//  woshare
//
//  Created by 陆利刚 on 16/6/20.
//  Copyright © 2016年 胡波. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeeLeftTableViewCell : UITableViewCell

+ (GeeLeftTableViewCell *)cellForTableView:(UITableView *)tableView;

@property(nonatomic, copy) NSString *cellName;
@property(nonatomic, copy) NSString *leftCellIcon;
@property(nonatomic, copy) NSString *rightCellIcon;

@end
