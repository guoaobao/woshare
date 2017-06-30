//
//  GeeActDetailSegmentView.h
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/24.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeeActDetailSegmentView : UIView

@property(nonatomic, strong) NSArray *titleArray;

@property(nonatomic, copy) void(^buttonClickedAtIndex)(NSInteger index);

@end
