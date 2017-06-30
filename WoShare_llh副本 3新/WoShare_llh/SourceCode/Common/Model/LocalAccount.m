//
//  LocalAccount.m
//  QYSDK
//
//  Created by 胡 波 on 13-4-9.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "LocalAccount.h"

@implementation LocalAccount
@synthesize username=username_;
@synthesize password=password_;
@synthesize token=token_;
-(id)init
{
    if (self = [super init]) {
        
    }
    return self;
}

-(void)dealloc
{
    [username_ release];
    [password_ release];
    [token_ release];
    [super dealloc];
}

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:username_ forKey:@"username"];
    [aCoder encodeObject:password_ forKey:@"password"];
    [aCoder encodeObject:token_ forKey:@"token"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if((self=[super init]))
    {
        username_=[[aDecoder decodeObjectForKey:@"username"]retain];
        password_=[[aDecoder decodeObjectForKey:@"password"]retain];
        token_   =[[aDecoder decodeObjectForKey:@"token"]retain];
    }
    return self;
}

@end
