//
//  GeeUploadCommonFunc.h
//  HappyShare
//
//  Created by eingbol on 13-5-8.
//  Copyright (c) 2013年 Lin Pan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeeUploadCommonFunc : NSObject

+(BOOL)writeImage:(UIImage*)image toFileAtPath:(NSString*)aPath;
+(long)getNowTime;

@end
