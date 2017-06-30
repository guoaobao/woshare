//
//  DataSource.h
//  QYSDK
//
//  Created by 胡 波 on 13-4-8.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppSetting.h"
#import "LocalAccount.h"
#import "FlowCount.h"
#import "Location.h"
@interface DataSource : NSObject
{
    AppSetting          *appSetting_;
    LocalAccount        *account_;
    FlowCount           *flowCount_;
}
@property (nonatomic,retain)LocalAccount        *account;
@property (nonatomic,retain)AppSetting          *appSetting;
@property (nonatomic,retain)FlowCount           *flowCount;

+(DataSource*)sharedDataSource;
+(void)releaseInstance;
-(NSString*)getDeviceID;

@end
