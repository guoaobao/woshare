//
//  FeedResponse.h
//  QYSDK
//
//  Created by 胡 波 on 13-5-14.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "BaseResponse.h"
#import "UserInfoResponse.h"

typedef enum {
    kTagImageTypeCollect        = 1,
    kTagImageTypeFollower       = 2,
    kTagImageTypeLike           = 3,
    kTagImageTypeShare          = 4,
    kTagImageTypeTalk           = 5,
    kTagImageTypeVote           = 6
}kTagImageType;

@interface FeedResponse : BaseResponse
@property (nonatomic, copy) NSString *_id;
@property (nonatomic, copy) NSString *actid;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *ct;
@property (nonatomic, copy) NSString *nsid;
@property (nonatomic, copy) NSString *read;
@property (nonatomic, copy) NSString *tuid;
@property (nonatomic, copy) NSString *tunm;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *unm;
@property (nonatomic, copy) NSString *ut;
@property (nonatomic, copy) NSString *thumburl;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL    isResource;
@property (nonatomic, assign)BOOL    isDeleted;
@property (nonatomic, assign)kTagImageType tagType;
@property (nonatomic, retain) UserInfoResponse *userInfo;

@end
