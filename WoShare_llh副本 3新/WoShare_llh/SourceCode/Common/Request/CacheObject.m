//
//  CacheObject.m
//  QYSDK
//
//  Created by 胡 波 on 13-9-12.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "CacheObject.h"

@implementation CacheObject
static CacheObject *_sharedCacheObjectInstance=nil;
+(CacheObject*)CacheObject
{
    @synchronized(self)
    {
        if(_sharedCacheObjectInstance==nil)
        {
            _sharedCacheObjectInstance=[[self alloc] init];
        }
        return _sharedCacheObjectInstance;
    }
    return nil;
}

-(id)init
{
    if (self = [super init]) {
        _needRefresh = NO;
        _expirationDate = 60;
    }
    return self;
}


@end
