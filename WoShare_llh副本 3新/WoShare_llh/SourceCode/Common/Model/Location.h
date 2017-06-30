//
//  Location.h
//  QYSDK
//
//  Created by 胡 波 on 13-5-13.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject
{
    double      latitude_;
    double      longitude_;
    NSString    *addString_;
}
@property (nonatomic,readonly,copy) NSString        *addString;
@property (nonatomic,readonly)      double          latitude;
@property (nonatomic,readonly)      double          longitude;

-(id)initWithLatitude:(double)lat WithLongitude:(double)lon WithAddress:(NSString*)addr;
@end
