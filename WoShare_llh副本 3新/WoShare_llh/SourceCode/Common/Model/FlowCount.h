//
//  FlowCount.h
//  QYSDK
//
//  Created by 胡 波 on 13-5-2.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlowCount : NSObject <NSCoding>
{
    NSString            *countString_;
    long long int       lastCount_;
    long long int       currentCount_;
}
@property (nonatomic,readonly) NSString     *countString;
@end
