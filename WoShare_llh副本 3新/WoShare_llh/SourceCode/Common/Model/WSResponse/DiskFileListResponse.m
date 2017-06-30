//
//  DiskFileListResponse.m
//  QYSDK
//
//  Created by 胡 波 on 13-5-14.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "DiskFileListResponse.h"

@implementation DiskFileListResponse
@synthesize userInfoArray,commentArray,nameSpaceArray,picbaseurl,userInfo,nameSpaceInfo;
- (void)dealloc
{
    [userInfo release];
    [nameSpaceInfo release];
    [userInfoArray release];
    [commentArray release];
    [nameSpaceArray release];
    [picbaseurl release];
    [super dealloc];
}
@end
