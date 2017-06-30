//
//  EventResponse.m
//  QYSDK
//
//  Created by 胡 波 on 13-4-23.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "EventFileResponse.h"

@implementation EventFileResponse
@synthesize _id,nsid,title,type,eventid,votenum,username,uid,dateline,as,sort,ms;
- (void)dealloc
{
    [nsid release];
    [title release];
    [username release];
    [super dealloc];
}
-(id)initWithDict:(NSDictionary *)dict withRequestType:(RequestType)requestType
{
    if(self = [super initWithDict:dict withRequestType:requestType])
    {
        self._id = [[dict objectForKey:@"id"]doubleValue];
        self.nsid = [dict objectForKey:@"nsid"];
        self.type = [[dict objectForKey:@"type"]doubleValue];
        self.uid = [[dict objectForKey:@"uid"]doubleValue];
        self.ms = [[dict objectForKey:@"ms"]doubleValue];
        self.sort = [[dict objectForKey:@"sort"]doubleValue];
        self.as = [[dict objectForKey:@"as"]doubleValue];
        self.votenum = [[dict objectForKey:@"votenum"]doubleValue];
        self.username = [dict objectForKey:@"username"];
        self.eventid = [[dict objectForKey:@"eventid"]doubleValue];
        self.title = [dict objectForKey:@"title"];
        self.dateline = [[dict objectForKey:@"dateline"]doubleValue];
    }
    return  self;
}
@end
