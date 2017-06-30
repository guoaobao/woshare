//
//  GeeUploadCommon.m
//  HappyShare
//
//  Created by eingbol on 13-5-8.
//  Copyright (c) 2013年 Lin Pan. All rights reserved.
//

#import "GeeUploadCommon.h"

@implementation GeeUploadResult

@synthesize result;
@synthesize cdnResult;

- (void)dealloc
{
    [super dealloc];
}

-(NSString*)toString
{
    if(self.result == 1)
    {
        return @"上传成功";
    }
    else if(self.result == -994)
    {
        if(self.cdnResult == -1)
        {
            return @"文件已存在";
        }
    }
    
    return @"上传失败";
}

-(NSString*)errorString
{
    return  [NSString stringWithFormat:@"result:%d,cdnResult:%d",self.result,self.cdnResult];
}

@end