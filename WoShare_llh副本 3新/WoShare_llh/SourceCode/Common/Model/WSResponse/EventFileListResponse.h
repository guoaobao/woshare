//
//  EventFileListResponse.h
//  QYSDK
//
//  Created by 胡 波 on 13-5-14.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "BaseResponse.h"
#import "NSResponse.h"
#import "UserInfoResponse.h"
#import "EventFileResponse.h"
@interface EventFileListResponse : BaseResponse
@property (nonatomic, retain)   EventFileResponse         *eventFile;
@property (nonatomic, retain)   UserInfoResponse          *userInfo;
@property (nonatomic, retain)   NSResponse                *nameSpaceInfo;
@property (nonatomic, retain)   NSMutableArray            *commentArray;
@property (nonatomic, retain)   NSMutableArray            *userInfoArray;
@property (nonatomic, copy)     NSString                  *picbaseurl;

@end
