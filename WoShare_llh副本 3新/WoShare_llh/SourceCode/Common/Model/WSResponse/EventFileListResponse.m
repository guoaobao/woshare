//
//  EventFileListResponse.m
//  QYSDK
//
//  Created by 胡 波 on 13-5-14.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "EventFileListResponse.h"

@implementation EventFileListResponse
@synthesize eventFile,nameSpaceInfo,commentArray,userInfoArray,picbaseurl,userInfo;
- (void)dealloc
{
    [eventFile release];
    [nameSpaceInfo release];
    [commentArray release];
    [userInfo release];
    [userInfoArray  release];
    [picbaseurl release];
    [super dealloc];
}
@end
