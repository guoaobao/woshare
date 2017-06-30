//
//  DiskFileListResponse.h
//  QYSDK
//
//  Created by 胡 波 on 13-5-14.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseResponse.h"
#import "UserInfoResponse.h"
#import "NSResponse.h"
@interface DiskFileListResponse : BaseResponse
@property (nonatomic, retain)   UserInfoResponse          *userInfo;
@property (nonatomic, retain)   NSResponse                *nameSpaceInfo;
@property (nonatomic, retain)   NSMutableArray            *nameSpaceArray;
@property (nonatomic, retain)   NSMutableArray            *commentArray;
@property (nonatomic, retain)   NSMutableArray            *userInfoArray;
@property (nonatomic, copy)     NSString                  *picbaseurl;
@end
