//
//  SNSUserResponse.m
//  F4WoPai
//
//  Created by liuleijie on 13-6-9.
//  Copyright (c) 2013年 zlvod. All rights reserved.
//

#import "SNSUserResponse.h"

@implementation SNSUserResponse
//新浪
@synthesize avatar;
@synthesize nickname;
@synthesize snsuid;

//通讯录
@synthesize uid;
@synthesize username;
@synthesize mobile;
@synthesize mood;
@synthesize truename;
-(id)initWithDict:(NSDictionary *)dict withRequestType:(RequestType)requestType{
    self = [super initWithDict:dict withRequestType:requestType];
    if (self) {
        self.avatar = [self objectOrNilForKey:@"avatar" fromDictionary:dict];
        self.nickname = [self objectOrNilForKey:@"nickname" fromDictionary:dict];
        self.snsuid = [self objectOrNilForKey:@"snsuid" fromDictionary:dict];
        self.uid = [self objectOrNilForKey:@"uid" fromDictionary:dict];
        self.username = [self objectOrNilForKey:@"username" fromDictionary:dict];
        self.mobile = [self objectOrNilForKey:@"mobile" fromDictionary:dict];
        self.mood = [self objectOrNilForKey:@"mood" fromDictionary:dict];
        self.truename = [self objectOrNilForKey:@"truename" fromDictionary:dict];
        
    }
    return self;
}

-(void)dealloc{
    [avatar release];
    [nickname release];
    [snsuid release];
    [uid release];
    [username release];
    [mobile release];
    [mood release];
    [truename release];
    [super dealloc];
}

@end
