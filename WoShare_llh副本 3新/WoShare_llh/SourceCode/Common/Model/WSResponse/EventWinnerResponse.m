//
//  EventWinnerResponse.m
//
//  Created by 波 胡 on 13-6-3
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EventWinnerResponse.h"

@implementation EventWinnerResponse

@synthesize status = _status;
@synthesize eventid = _eventid;
@synthesize uid = _uid;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize prize = _prize;
@synthesize level = _level;
@synthesize dateline = _dateline;
@synthesize username = _username;
@synthesize avatar = _avatar;

-(id)initWithDict:(NSDictionary *)dict withRequestType:(RequestType)requestType
{
    self = [super initWithDict:dict withRequestType:requestType];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.status = [self objectOrNilForKey:@"status" fromDictionary:dict];
            self.eventid = [self objectOrNilForKey:@"eventid" fromDictionary:dict];
            self.uid = [self objectOrNilForKey:@"uid" fromDictionary:dict];
            self.internalBaseClassIdentifier = [self objectOrNilForKey:@"id" fromDictionary:dict];
            self.prize = [self objectOrNilForKey:@"prize" fromDictionary:dict];
            self.level = [self objectOrNilForKey:@"level" fromDictionary:dict];
            self.dateline = [self objectOrNilForKey:@"dateline" fromDictionary:dict];
            self.username = [self objectOrNilForKey:@"username" fromDictionary:dict];
            self.avatar = [self objectOrNilForKey:@"avatar" fromDictionary:dict];
        self.award = [self objectOrNilForKey:@"award" fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:@"status"];
    [mutableDict setValue:self.eventid forKey:@"eventid"];
    [mutableDict setValue:self.uid forKey:@"uid"];
    [mutableDict setValue:self.internalBaseClassIdentifier forKey:@"id"];
    [mutableDict setValue:self.prize forKey:@"prize"];
    [mutableDict setValue:self.level forKey:@"level"];
    [mutableDict setValue:self.dateline forKey:@"dateline"];
    [mutableDict setValue:self.username forKey:@"username"];
    [mutableDict setValue:self.avatar forKey:@"avatar"];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}


- (void)dealloc
{
    [_status release];
    [_eventid release];
    [_uid release];
    [_internalBaseClassIdentifier release];
    [_prize release];
    [_level release];
    [_dateline release];
    [_username release];
    [_avatar release];
    [super dealloc];
}

@end
