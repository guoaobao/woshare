//
//  GeeShareView.h
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/22.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GeeShareView : UIView

@property(nonatomic, copy) void(^shareToSina)(void);
@property(nonatomic, copy) void(^shareToWechat)(void);
@property(nonatomic, copy) void(^shareToWechatFriend)(void);
@property(nonatomic, copy) void(^shareToQQFriend)(void);

@end
