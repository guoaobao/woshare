//
//  GeeUploadBaseTaskManager.h
//  HappyShare
//
//  Created by eingbol on 13-5-9.
//  Copyright (c) 2013年 Lin Pan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeeUploadData.h"

@interface IGeeUploadTaskManager : NSObject

-(BOOL)addTask:(GeeUploadData*)data;
-(BOOL)removeTask:(int)tid;
-(BOOL)stopTask:(int)tid;
-(BOOL)startTask:(int)tid;
-(BOOL)stopAll;
-(BOOL)startAll;
-(BOOL)save;

-(GeeUploadData*) getNextTask;
-(GeeUploadData*) getTask:(int)tid;
-(NSMutableArray*) getTaskList;

@property (nonatomic,retain)NSString* uid;
@property int maxErrorNum;
@property BOOL isRemoveCompleteTask;
@property BOOL isRemoveErrorTask;

@end

@interface GeeUploadBaseTaskManager : IGeeUploadTaskManager
{
    NSLock* _lock;  
}

@end
