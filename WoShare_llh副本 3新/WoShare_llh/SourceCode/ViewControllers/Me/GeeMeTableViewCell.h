//
//  GeeMeTableViewCell.h
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/23.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeeMeTableViewCell : UITableViewCell

+ (GeeMeTableViewCell *)cellForTableView:(UITableView *)tableView;
@property(nonatomic, copy) NSString *imageName;
@property(nonatomic, copy) NSString *functionName;

@end
