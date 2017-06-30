//
//  GeeQuickReplyView.h
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/28.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeeQuickReplyView : UIView

@property(nonatomic, copy) void(^sendButtonClicked)(NSString *text);

@end
