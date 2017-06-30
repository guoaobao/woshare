//
//  CollectResourceList.h
//  HappyShare
//
//  Created by Lin Pan on 13-4-18.
//  Copyright (c) 2013年 Lin Pan. All rights reserved.
//
//  用户收藏的资源

#import "ResourceInfo.h"

@interface CollectResourceInfo : ResourceInfo

@property(copy,nonatomic) NSString *collectId;
@property(copy,nonatomic) NSString *collectTime;
@property(copy,nonatomic) NSString *collectUid;
@property(copy,nonatomic) NSString *collectUsername;

- (id)initWithCollectInfo:(NSDictionary *)collectDic resourceInfo:(NSDictionary *)resourceDic;
@end
