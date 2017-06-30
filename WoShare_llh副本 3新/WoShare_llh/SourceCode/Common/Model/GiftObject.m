//
//  GiftObject.m
//  HappyShareSE
//
//  Created by 胡波 on 13-12-18.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "GiftObject.h"

@implementation GiftObject
- (id)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        // Custom initialization
        _giftID = [dic objectForKey:@"id"];
        _giftName = [dic objectForKey:@"name"];
        _giftURL = [dic objectForKey:@"pic"];
    }
    return self;
}
@end
