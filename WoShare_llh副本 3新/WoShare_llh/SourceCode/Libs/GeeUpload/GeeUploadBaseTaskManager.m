//
//  GeeUploadBaseTaskManager.m
//  HappyShare
//
//  Created by eingbol on 13-5-9.
//  Copyright (c) 2013年 Lin Pan. All rights reserved.
//

#import "GeeUploadBaseTaskManager.h"

@implementation IGeeUploadTaskManager

@synthesize uid;
@synthesize maxErrorNum;
@synthesize isRemoveCompleteTask;
@synthesize isRemoveErrorTask;

- (id)init
{
    self = [super init];
    if (self) {
        maxErrorNum = 1;
        isRemoveCompleteTask = YES;
        isRemoveErrorTask = NO;
    }
    return self;
}

- (void)dealloc
{
    [uid release];
    [super dealloc];
}

-(BOOL)addTask:(GeeUploadData*)data
{
    return NO;
}

-(BOOL)removeTask:(int)tid
{
    return NO;
}

-(BOOL)stopTask:(int)tid
{
    return NO;
}

-(BOOL)startTask:(int)tid;
{
    return NO;
}

-(BOOL)stopAll
{
    return NO;
}

-(BOOL)startAll
{
    return NO;
}

-(BOOL)save;
{
    return NO;
}

-(GeeUploadData*) getNextTask
{
    return nil;
}

-(GeeUploadData*) getTask:(int)tid
{
    return nil;
}

-(NSMutableArray*) getTaskList
{
    return nil;
}

@end

@implementation GeeUploadBaseTaskManager

- (id)init
{
    self = [super init];
    if (self) {
        _lock = [[NSLock alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_lock release];
    [super dealloc];
}

-(BOOL)stopTask:(int)tid
{
    GeeUploadData* data = [self getTask:tid];
    [_lock lock];
    if(data)
    {
        [data stop];
        data.status = GEE_TASK_STOP;
        [_lock unlock];
        return YES;
    }
    else
    {
        [_lock unlock];
        return NO;
    }
}

@end
