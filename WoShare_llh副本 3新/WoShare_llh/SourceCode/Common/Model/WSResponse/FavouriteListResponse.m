//
//  FavouriteListResponse.m
//  QYSDK
//
//  Created by 胡 波 on 13-5-14.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "FavouriteListResponse.h"

@implementation FavouriteListResponse
@synthesize favorite,userInfo,commentArray,commentUser,picbaseurl,nameSpace;
- (void)dealloc
{
    [favorite release];
    [userInfo release];
    [commentUser release];
    [commentArray release];
    [picbaseurl release];
    [nameSpace release];
    [super dealloc];
}
@end
