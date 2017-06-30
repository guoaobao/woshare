//
//  GeeBaseShareSquareTableHeaderView.h
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/27.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeeBaseShareSquareTableHeaderView : UIView

@property(nonatomic, copy) void(^headerViewChangged)(NSInteger index);

- (void)setSelectedIndex:(NSInteger)index;
- (NSInteger)getSelectedIndex;

@end
