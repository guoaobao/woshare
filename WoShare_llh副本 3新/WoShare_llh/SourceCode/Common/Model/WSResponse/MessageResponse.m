//
//  MessageResponse.m
//  QYSDK
//
//  Created by 胡 波 on 13-4-23.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "MessageResponse.h"

@implementation MessageResponse
@synthesize type,msg,tuid,tunm,dvcid,suid,sunm,read,readtype,ct,userInfo,uid,_id;
- (void)dealloc
{
    [_id release];
    [type release];
    [msg release];
    [tuid release];
    [tunm release];
    [dvcid release];
    [suid release];
    [sunm release];
    [readtype release];
    [read release];
    [ct release];
    [userInfo release];
    [uid release];
    [super dealloc];
}
-(id)initWithDict:(NSDictionary *)dict withRequestType:(RequestType)requestType
{
    if(self = [super initWithDict:dict withRequestType:requestType])
    {
        self.type = [self objectOrNilForKey:@"type" fromDictionary:dict];
        self.msg = [self objectOrNilForKey:@"msg" fromDictionary:dict];
        self.tuid = [self objectOrNilForKey:@"tuid" fromDictionary:dict];
        self.tunm = [self objectOrNilForKey:@"tunm" fromDictionary:dict];
        self.dvcid = [self objectOrNilForKey:@"dvcid" fromDictionary:dict];
        self.suid = [self objectOrNilForKey:@"suid" fromDictionary:dict];
        self.sunm = [self objectOrNilForKey:@"sunm" fromDictionary:dict];
        self.readtype = [self objectOrNilForKey:@"readtype" fromDictionary:dict];
        self.read = [self objectOrNilForKey:@"read" fromDictionary:dict];
        self.ct = [self objectOrNilForKey:@"ct" fromDictionary:dict];
        self.uid = [self objectOrNilForKey:@"uid" fromDictionary:dict];
        self._id = [self objectOrNilForKey:@"_id" fromDictionary:dict];
        self.acme = [self objectOrNilForKey:@"acme" fromDictionary:dict];
        self.time= [NSString stringWithDate:[NSDate dateWithTimeIntervalSince1970:[self.ct floatValue]] formater:@"yyyy-MM-dd hh:mm"];
    }
    return  self;
}
@end
