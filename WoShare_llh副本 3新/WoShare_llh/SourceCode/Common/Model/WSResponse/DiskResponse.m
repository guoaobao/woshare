//
//  DiskResponse.m
//  QYSDK
//
//  Created by 胡 波 on 13-4-23.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "DiskResponse.h"

@implementation DiskResponse
@synthesize username,mood,experience,credit,notenum,fansnum,favoritenum,avatar,spacepic,sharenum,diskusesize,disksize,grouptitle;
- (void)dealloc
{
//    [username release];
//    [mood release];
//    [avatar release];
//    [spacepic release];
//    [grouptitle release];
    [super dealloc];
}
-(id)initWithDict:(NSDictionary *)dict withRequestType:(RequestType)requestType
{
    if(self = [super initWithDict:dict withRequestType:requestType])
    {
        self.username = [dict objectForKey:@"username"];
        self.mood = [dict objectForKey:@"mood"];
        self.experience = [[dict objectForKey:@"experience"]doubleValue];
        self.credit = [[dict objectForKey:@"credit"]doubleValue];
        self.notenum = [[dict objectForKey:@"notenum"]doubleValue];
        self.favoritenum = [[dict objectForKey:@"favoritenum"]doubleValue];
        self.fansnum = [[dict objectForKey:@"fansnum"]doubleValue];
        self.avatar = [dict objectForKey:@"avatar"];
        self.spacepic = [dict objectForKey:@"spacepic"];
        self.sharenum = [[dict objectForKey:@"sharenum"]doubleValue];
        self.disksize = [[dict objectForKey:@"disksize"]doubleValue];
        self.diskusesize = [[dict objectForKey:@"diskusesize"]doubleValue];
        self.grouptitle = [dict objectForKey:@"grouptitle"];

    }
    return  self;
}
@end
