//
//  GiftObject.h
//  HappyShareSE
//
//  Created by 胡波 on 13-12-18.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GiftObject : NSObject
@property (nonatomic,retain)NSString    *giftURL;
@property (nonatomic,retain)NSString    *giftID;
@property (nonatomic,retain)NSString    *giftName;
- (id)initWithDic:(NSDictionary*)dic;
@end