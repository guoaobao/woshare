//
//  CacheObject.h
//  QYSDK
//
//  Created by 胡 波 on 13-9-12.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheObject : NSObject
@property (nonatomic,assign)double    expirationDate;
@property (nonatomic,assign)BOOL      needRefresh;
+(CacheObject*)CacheObject;
@end
