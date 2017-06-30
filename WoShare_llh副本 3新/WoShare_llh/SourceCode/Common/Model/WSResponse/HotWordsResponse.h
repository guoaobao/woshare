//
//  HotWordsResponse.h
//  QYSDK
//
//  Created by 胡 波 on 13-5-14.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "BaseResponse.h"

@interface HotWordsResponse : BaseResponse
@property(nonatomic, copy) NSString *appid;
@property(nonatomic, copy) NSString *recommend;
@property(nonatomic, copy) NSString *status;
@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSString *wordid;
@property(nonatomic, copy) NSString *wordname;

@end
