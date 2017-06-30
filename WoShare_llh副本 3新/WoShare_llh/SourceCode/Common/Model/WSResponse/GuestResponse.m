//
//  GuestResponse.m
//  QYSDK
//
//  Created by 胡 波 on 13-4-23.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "GuestResponse.h"

@implementation GuestResponse
@synthesize mobile,name,uid,eventid;
-(id) initWithDict:(NSDictionary *)dict withRequestType:(RequestType)requestType{
    self = [super initWithDict:dict withRequestType:requestType];
    if (self) {
        self.mobile = [dict objectForKey:@"mobile"];
        self.uid = [dict objectForKey:@"uid"];
        self.name = [dict objectForKey:@"name"];
        self.eventid = [dict objectForKey:@"eventid"];
    }
    return self;
}

-(void)dealloc{
    
    [mobile release];
    [uid release];
    [name release];
    [eventid release];
    [super dealloc];
}
@end
