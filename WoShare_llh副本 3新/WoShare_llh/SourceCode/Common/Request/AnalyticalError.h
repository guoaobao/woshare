//
//  AnalyticalError.h
//  WisdomCloud
//
//  Created by leijie liu on 12-6-18.
//  Copyright (c) 2012年 zlvod. All rights reserved.
//
//  Change By Apan
//  2012-7-9
//  1.Change Instanse Method to Class Method
//  2.Change Params

#import <UIKit/UIKit.h>

@interface AnalyticalError : NSObject

+(NSString *) getErrorInfo: (NSString *)status responseData:(id)data;

@end
