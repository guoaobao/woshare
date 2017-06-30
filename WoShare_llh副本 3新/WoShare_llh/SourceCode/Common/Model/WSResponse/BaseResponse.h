//
//  BaseResponse.h
//  QYSDK
//
//  Created by 胡 波 on 13-4-23.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestType.h"
@interface BaseResponse : NSObject{
    RequestType requestType_;
}
@property(nonatomic, readonly)  RequestType requestType;
@property(nonatomic, retain)    NSDate      *creatdDate;
-(id)initWithDict:(NSDictionary *)dict withRequestType:(RequestType)requestType;
+(id)infoWithDict:(NSDictionary *)dict withRequestType:(RequestType)requestType;
-(id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;
@end
