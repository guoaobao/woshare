//
//  AppSetting.h
//  QYSDK
//
//  Created by 胡 波 on 13-4-9.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface AppSetting : NSObject <NSCoding>
{
    BOOL        autoLogin_;
    BOOL        isLogined_;
}
@property (nonatomic,assign)    BOOL    autoLogin;
@property (nonatomic,assign)    BOOL    isLogined;
@end
