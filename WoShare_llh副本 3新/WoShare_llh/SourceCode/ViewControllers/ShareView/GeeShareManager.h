//
//  GeeShareManager.h
//  WoShare_llh
//
//  Created by 陆利刚 on 16/7/5.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeBaseObject.h"
#import "InfoListResponse.h"

@interface GeeShareManager : GeeBaseObject

@property(nonatomic, strong) InfoListResponse *info;

- (void)shareToSina;
//- (void)sendImageContent;
- (void)sendLinkContent;
- (void)sendLinkContentToWechatFriend;

- (void)sendLinkToQQFriend;

@end
