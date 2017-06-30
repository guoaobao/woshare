//
//  CommentResponse.m
//  QYSDK
//
//  Created by 胡 波 on 13-4-23.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "CommentResponse.h"
@implementation CommentResponse
@synthesize _id,suid,sid,stype,sunm,ct,comment,at,as,ap,auid,aunm,ip,userInfo,runm,sst;

-(id) initWithDict:(NSDictionary *)dict withRequestType:(RequestType)requestType{
    if (self = [super initWithDict:dict withRequestType:requestType]) {
        self._id = [dict objectForKey:@"_id"];
        self.auid = [dict objectForKey:@"auid"];
        NSString *tempName = [NSString validateString:[dict objectForKey:@"aunm"]];
        self.aunm = tempName? tempName : @"游客";
        self.comment = [dict objectForKey:@"comment"];
        self.comment = [dict objectForKey:@"comment"];
        self.ct = [[dict objectForKey:@"ct"]doubleValue];
        self.ip = [[dict objectForKey:@"ip"]doubleValue];
        self.sid = [dict objectForKey:@"sid"];
        self.stype = [dict objectForKey:@"stype"];
        self.suid = [dict objectForKey:@"suid"];
        self.sunm = [dict objectForKey:@"sunm"];
        self.as = [[dict objectForKey:@"as"]doubleValue];
        self.ap = [dict objectForKey:@"ap"];
        self.at = [[dict objectForKey:@"at"]doubleValue];
        self.runm = [dict objectForKey:@"runm"];
        self.sst = [[dict objectForKey:@"ct"]doubleValue];
    }
    return self;
}

-(void)dealloc{
    [runm release];
    [_id release];
    [auid release];
    [aunm release];
    [comment release];
    [sid release];
    [stype release];
    [suid release];
    [sunm release];
    [ap release];
    [userInfo release];
    [super dealloc];
}
@end
