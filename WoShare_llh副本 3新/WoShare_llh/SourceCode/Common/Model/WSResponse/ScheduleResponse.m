//
//  ScheduleResponse.m
//  QYSDK
//
//  Created by 胡 波 on 13-4-23.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "ScheduleResponse.h"

@implementation ScheduleResponse
@synthesize channelid;
@synthesize end;
@synthesize name;
@synthesize start;
@synthesize weekday;

-(id) initWithDict:(NSDictionary *)dict withRequestType:(RequestType)requestType{
    self = [super initWithDict:dict withRequestType:requestType];
    if (self) {
        self.channelid = [dict objectForKey:@"channelid"];
        self.end = [dict objectForKey:@"end"];
        self.name = [dict objectForKey:@"name"];
        self.start = [dict objectForKey:@"start"];
        self.weekday = [dict objectForKey:@"weekday"];
    }
    return self;
}

-(void)dealloc{
    
    [channelid release];
    [end release];
    [name release];
    [start release];
    [weekday release];
    [super dealloc];
}
@end
