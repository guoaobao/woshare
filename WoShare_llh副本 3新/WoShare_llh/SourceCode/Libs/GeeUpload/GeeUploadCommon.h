//
//  GeeUploadCommon.h
//  HappyShare
//
//  Created by eingbol on 13-5-8.
//  Copyright (c) 2013年 Lin Pan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GU_ERROR_CALFILEID      -20001
#define GU_ERROR_CALFILESIZE    -20002
#define GU_ERROR_HTTPREQUEST    -20003
#define GU_ERROR_JSON_PARSE     -20004

enum _GeeTaskStatus
{
    GEE_TASK_PENDING = 0,
    GEE_TASK_PROCESS = 1,
    GEE_TASK_STOP = 2,
    GEE_TASK_COMPLETE = 3,
    GEE_TASK_ERROR = 4,
};
typedef enum _GeeTaskStatus GeeTaskStatus;

@interface GeeUploadResult : NSObject

@property int result;
@property int cdnResult;

-(NSString*)toString;
-(NSString*)errorString;

@end