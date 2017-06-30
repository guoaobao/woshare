//
//  GeeUploadMemTaskManager.m
//  HappyShare
//
//  Created by eingbol on 13-5-9.
//  Copyright (c) 2013年 Lin Pan. All rights reserved.
//

#import "GeeUploadMemTaskManager.h"

@implementation GeeUploadMemTaskManager

- (id)init
{
    self = [super init];
    if (self) {
        _taskList = [[NSMutableArray alloc] init];
        _index = 0;
    }
    return self;
}

-(id)initWithUID:(NSString*)userId
{
    self = [self init];
    if(self)
    {
        self.uid = userId;
    }
    return self;
}

-(id)initWithUID:(NSString*)userId isRemoveCompleteTask:(BOOL)isRemove
{
    self = [self initWithUID:userId];
    if(self)
    {
        self.isRemoveCompleteTask = isRemove;
    }
    return self;
}

-(id)initWithUID:(NSString*)userId isRemoveCompleteTask:(BOOL)isRemoveComp isRemoveErrorTask:(BOOL)isRemoveError
{
    self = [self initWithUID:userId];
    if(self)
    {
        self.isRemoveCompleteTask = isRemoveComp;
        self.isRemoveErrorTask = isRemoveError;
    }
    return self;
}

- (void)dealloc
{
    for (GeeUploadData* data in _taskList)
    {
        [data stop];
    }
    [_taskList release];
    [super dealloc];
}

-(BOOL)addTask:(GeeUploadData*)data
{
    [_lock lock];
    data.tid = _index++;
    [_taskList addObject:data];
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
        [_lock unlock];
        return YES;
    }
    else
    {
        [_lock unlock];
        return NO;
    }
}

-(BOOL)startTask:(int)tid
{
    GeeUploadData* data = [self getTask:tid];
    [_lock lock];
    if(data)
    {
        data.status = GEE_TASK_PENDING;
        data.errorNum = 0;//reset
        [_lock unlock];
        return YES;
    }
    else
    {
        [_lock unlock];
        return NO;
    }
}

-(BOOL)stopAll
{
    [_lock lock];
    for (GeeUploadData* data in _taskList)
    {
        if(data.status != GEE_TASK_COMPLETE)
            [data stop];
    }
    [_lock unlock];    
    return YES;
}

-(BOOL)startAll
{
    [_lock lock];    
    for (GeeUploadData* data in _taskList)
    {
        if(data.status == GEE_TASK_STOP || data.status == GEE_TASK_ERROR)
        {
            data.status = GEE_TASK_PENDING;
            data.errorNum = 0;//reset
        }
    }
    [_lock unlock];     
    return YES;
}

-(GeeUploadData*) getNextTask
{
    [_lock lock];
    for(GeeUploadData* data in _taskList)
    {
        if([data.param.uid isEqualToString:self.uid] && (data.status == GEE_TASK_PENDING || (data.status == GEE_TASK_ERROR && data.errorNum < self.maxErrorNum)))
        {
            [_lock unlock]; 
            return data;
        }
    }
    [_lock unlock]; 
    return nil;
}

-(GeeUploadData*) getTask:(int)tid
{
    [_lock lock];
    for(GeeUploadData* data in _taskList)
    {
        if(data.tid == tid && [data.param.uid isEqualToString:self.uid])
        {
            [_lock unlock];
            return data;
        }
    }
    [_lock unlock];
    return nil;
}

-(NSMutableArray*) getTaskList
{
    [_lock lock];
    NSMutableArray* arrayTemp = [[[NSMutableArray alloc] init] autorelease];
    for (GeeUploadData* data in _taskList)
    {
        if([data.param.uid isEqualToString:self.uid])
        {
            [arrayTemp addObject:data];
        }
    }
    [_lock unlock];
    return arrayTemp;
}

@end
