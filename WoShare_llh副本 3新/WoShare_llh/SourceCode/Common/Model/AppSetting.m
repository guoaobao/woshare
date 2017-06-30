//
//  AppSetting.m
//  QYSDK
//
//  Created by 胡 波 on 13-4-9.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "AppSetting.h"

@implementation AppSetting
@synthesize autoLogin=autoLogin_;
@synthesize isLogined=isLogined_;
-(id)init
{
    if (self = [super init]) {
        
    }
    return self;
}

-(void)dealloc
{
    [super dealloc];
}

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeBool:autoLogin_ forKey:@"autoLogin"];
    [aCoder encodeBool:isLogined_ forKey:@"isLogined"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if((self=[super init]))
    {
        autoLogin_ = [aDecoder decodeBoolForKey:@"autoLoin"];
        isLogined_ = [aDecoder decodeBoolForKey:@"isLogined"];
    }
    return self;
}
@end
