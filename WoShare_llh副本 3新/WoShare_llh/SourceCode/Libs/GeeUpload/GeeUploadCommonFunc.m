//
//  GeeUploadCommonFunc.m
//  HappyShare
//
//  Created by eingbol on 13-5-8.
//  Copyright (c) 2013年 Lin Pan. All rights reserved.
//

#import "GeeUploadCommonFunc.h"

@implementation GeeUploadCommonFunc

+(BOOL)writeImage:(UIImage*)image toFileAtPath:(NSString*)aPath
{
    if ((image == nil) || (aPath == nil) || ([aPath isEqualToString:@""]))
        return NO;
    
    @try
    {
        NSData *imageData = nil;
        NSString *ext = [aPath pathExtension];
        if ([ext isEqualToString:@"png"])
            imageData = UIImagePNGRepresentation(image);
        else
        {
            // the rest, we write to jpeg
            // 0. best, 1. lost. about compress.
            imageData = UIImageJPEGRepresentation(image, 0);
        }
        if ((imageData == nil) || ([imageData length] <= 0))
            return NO;
        [imageData writeToFile:aPath atomically:YES];
        
        return YES;
    }
    @catch (NSException *e)
    {
        NSLog(@"create thumbnail exception.");
    }
    
    return NO;
}

+(long)getNowTime
{
    return time(0);
}

@end
