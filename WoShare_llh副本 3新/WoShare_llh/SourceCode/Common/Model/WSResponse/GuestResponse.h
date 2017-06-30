//
//  GuestResponse.h
//  QYSDK
//
//  Created by 胡 波 on 13-4-23.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "BaseResponse.h"

@interface GuestResponse : BaseResponse
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *eventid;
@end
