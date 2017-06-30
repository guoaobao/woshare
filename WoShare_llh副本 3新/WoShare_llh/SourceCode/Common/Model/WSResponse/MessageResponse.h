//
//  MessageResponse.h
//  QYSDK
//
//  Created by 胡 波 on 13-4-23.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "BaseResponse.h"
#import "UserInfoResponse.h"
@interface MessageResponse : BaseResponse
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,copy)NSString *tuid;
@property(nonatomic,copy)NSString *tunm;
@property(nonatomic,copy)NSString *dvcid;
@property(nonatomic,copy)NSString *suid;
@property(nonatomic,copy)NSString *sunm;
@property(nonatomic,copy)NSString *read;
@property(nonatomic,copy)NSString *readtype;
@property(nonatomic,copy)NSString *acme;
@property(nonatomic,copy)NSString *ct;
@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *_id;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,retain)UserInfoResponse *userInfo;
@end
