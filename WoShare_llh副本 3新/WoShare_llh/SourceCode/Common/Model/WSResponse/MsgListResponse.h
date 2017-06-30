//
//  MsgListResponse.h
//  woshare
//
//  Created by 胡波 on 14-4-2.
//  Copyright (c) 2014年 胡波. All rights reserved.
//

#import "BaseResponse.h"
#import "UserInfoResponse.h"
@interface MsgListResponse : BaseResponse
@property (nonatomic,retain)NSArray *msgList;
@property (nonatomic,retain)UserInfoResponse    *user;
@end
