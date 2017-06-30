//
//  CollectResourceList.m
//  HappyShare
//
//  Created by Lin Pan on 13-4-18.
//  Copyright (c) 2013年 Lin Pan. All rights reserved.
//

#import "CollectResourceInfo.h"

@implementation CollectResourceInfo

- (id)initWithCollectInfo:(NSDictionary *)collectDic resourceInfo:(NSDictionary *)resourceDic
{
    
    self = [super initWithDic:resourceDic];
    if (self)
    {
        self.collectId = [collectDic objectForKey:@"_id"];
        self.collectTime =  [NSString stringWithDate:[NSDate dateWithTimeIntervalSince1970:[[collectDic objectForKey:@"sst"] floatValue]] formater:@"yyyy-MM-dd hh:mm"];
        self.collectUid = [collectDic objectForKey:@"uid"];
        self.collectUsername = [collectDic objectForKey:@"unm"];
    }
    return self;
}

- (void)dealloc
{
    [_collectId release];
    [_collectTime release];
    [_collectUid release];
    [_collectUsername release];
    [super dealloc];
}
@end
