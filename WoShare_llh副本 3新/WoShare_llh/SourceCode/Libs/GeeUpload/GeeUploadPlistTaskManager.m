//
//  GeeUploadPlistTaskManager.m
//  HappyShare
//
//  Created by eingbol on 13-5-9.
//  Copyright (c) 2013年 Lin Pan. All rights reserved.
//

#import "GeeUploadPlistTaskManager.h"

#define GEE_PLIST_KEY @"GEE_UPLOAD_LIST_V1"

@implementation GeeUploadPlistTaskManager

- (id)init
{
    self = [super init];
    if (self) {
        id list = [[NSUserDefaults standardUserDefaults] objectForKey:GEE_PLIST_KEY];
        if(list)
        {
            NSMutableArray* array = (NSMutableArray*)list;
            //get max index
            for (NSDictionary* dict in array)
            {
                GeeUploadData* data = [[GeeUploadData alloc] initWithDict:dict];
                if((self.isRemoveCompleteTask && data.status == GEE_TASK_COMPLETE) || (self.isRemoveErrorTask && data.status == GEE_TASK_ERROR))
                {
                    for (GeeUploadFileInfo* fileinfo in data.param.fileinfos) {
                        //remove tmp file;
                        NSFileManager* fm = [NSFileManager defaultManager];
                        NSError* errorString = nil;
                        BOOL removeResult = [fm removeItemAtPath:fileinfo.path error:&errorString];
                        if(!removeResult && errorString)
                        {
                            NSLog(@"remove tmp file error,%@",[errorString localizedDescription]);
                        }
                    }
                }
                else
                {
                    if(data.status == GEE_TASK_ERROR || data.status == GEE_TASK_PROCESS)
                        data.status = GEE_TASK_PENDING;
                    
                    data.tid = _index++;
                    [_taskList addObject:data];
                }
                [data release];
            }
        }
    }
    return self;
}

-(BOOL)addTask:(GeeUploadData*)data
{
    [_lock lock];
    [_taskList addObject:data];
    //add to plist
    [self save2Plist];
    [_lock unlock];
    return YES;
}

-(BOOL)removeTask:(int)tid
{
    GeeUploadData* data = [self getTask:tid];
    [_lock lock];
    if(data)
    {
        [_taskList removeObject:data];
        //add to plist
        [self save2Plist];
        [_lock unlock];
        return YES;
    }
    else
    {
        [_lock unlock];
        return NO;
    }
}

-(BOOL)save;
{
    return [self save2Plist];
}

-(BOOL)save2Plist
{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    for (GeeUploadData* data in _taskList)
    {
        [array addObject:[data toDict]];
    }
    NSArray* tempArray = [NSArray arrayWithArray:array];
    [[NSUserDefaults standardUserDefaults] setObject:tempArray forKey:GEE_PLIST_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [array release];
    return YES;
}

@end
