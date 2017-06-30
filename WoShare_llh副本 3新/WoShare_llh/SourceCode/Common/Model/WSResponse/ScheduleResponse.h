//
//  ScheduleResponse.h
//  QYSDK
//
//  Created by 胡 波 on 13-4-23.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "BaseResponse.h"

@interface ScheduleResponse : BaseResponse
@property(nonatomic,copy)NSString *channelid;
@property(nonatomic,copy)NSString *end;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *start;
@property(nonatomic,copy)NSString *weekday;
@end
