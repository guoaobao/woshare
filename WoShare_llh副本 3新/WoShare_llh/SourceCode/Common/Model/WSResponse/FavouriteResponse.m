//
//  FavouriteResponse.m
//  QYSDK
//
//  Created by 胡 波 on 13-4-23.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "FavouriteResponse.h"

@implementation FavouriteResponse
@synthesize _id;
@synthesize ct;
@synthesize dc;
@synthesize fc;
@synthesize fsize;
@synthesize isfd;
@synthesize nm;
@synthesize nsid;
@synthesize pid;
@synthesize suid;
@synthesize sunm;
@synthesize type;
@synthesize uid;
@synthesize unm;
@synthesize ut;

-(void)dealloc
{
    [_id release];
    [nm release];
    [nsid release];
    [pid release];
    [suid release];
    [sunm release];
    [uid release];
    [unm release];
    [super dealloc];
}

-(id)initWithDict:(NSDictionary *)dict withRequestType:(RequestType)requestType
{
    if(self = [super initWithDict:dict withRequestType:requestType])
    {
        self._id = [dict objectForKey:@"_id"];
        self.ct = [[dict objectForKey:@"ct"]doubleValue];
        self.dc = [[dict objectForKey:@"dc"]doubleValue];
        self.fc = [[dict objectForKey:@"fc"]doubleValue];
        self.fsize = [[dict objectForKey:@"fsize"]doubleValue];
        self.isfd = [[dict objectForKey:@"isfd"]boolValue];
        self.nm = [dict objectForKey:@"nm"];
        self.nsid = [dict objectForKey:@"nsid"];
        self.pid = [dict objectForKey:@"pid"];
        self.suid = [dict objectForKey:@"suid"];
        self.sunm = [dict objectForKey:@"sunm"];
        self.type = [[dict objectForKey:@"type"]doubleValue];
        self.uid = [dict objectForKey:@"uid"];
        self.unm = [dict objectForKey:@"unm"];
        self.ut = [[dict objectForKey:@"ut"]doubleValue];
        if ([[dict objectForKey:@"idtype"]isEqualToString:@"info"]) {
            self.isResource = NO;
        }
        else
        {
            self.isResource = YES;
        }
    }
    return  self;
}
@end
