//
//  CommentResponse.h
//  QYSDK
//
//  Created by 胡 波 on 13-4-23.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "BaseResponse.h"
#import "UserInfoResponse.h"
@interface CommentResponse : BaseResponse
@property (nonatomic, retain) NSString *_id;
@property (nonatomic, retain) NSString *sid;
@property (nonatomic, retain) NSString *stype;
@property (nonatomic, retain) NSString *suid;
@property (nonatomic, retain) NSString *sunm;
@property (nonatomic, retain) NSString *comment;
@property (nonatomic, retain) NSString *auid;
@property (nonatomic, retain) NSString *aunm;
@property (nonatomic, assign) double   ip;
@property (nonatomic, assign) double   ct;
@property (nonatomic, assign) double   as;
@property (nonatomic, retain) NSString *ap;
@property (nonatomic, assign) double   at;
@property (nonatomic, retain) NSString *runm;
@property (nonatomic, assign) double   sst;
@property (nonatomic, retain)UserInfoResponse   *userInfo;
@end
