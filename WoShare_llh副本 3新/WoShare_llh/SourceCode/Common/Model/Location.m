//
//  Location.m
//  QYSDK
//
//  Created by 胡 波 on 13-5-13.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "Location.h"

@implementation Location
@synthesize longitude=longitude_;
@synthesize latitude=latitude_;
@synthesize addString=addString_;

-(id)initWithLatitude:(double)lat WithLongitude:(double)lon WithAddress:(NSString *)addr
{
    if (self = [super init]) {
        latitude_ = lat;
        longitude_ = lon;
        addString_ = [addr copy];
    }
    return  self;
}
- (void)dealloc
{
    [addString_ release];
    [super dealloc];
}
@end
