//
//  GeeUploadManager.h
//  QYSDK
//
//  Created by eingbol on 13-4-26.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeeUploadBaseTaskManager.h"

@interface GeeUploadManager : NSObject<GeeUploadDelegate>
{
    NSThread* _thread;
    BOOL _isThreadRunning;
    IGeeUploadTaskManager* _manager;
}

-(id)initWithUrl:(NSString*)url uploadParentFolderName:(NSString*)name taskManager:(IGeeUploadTaskManager*)manager;
-(id)initWithUrl:(NSString*)url taskManager:(IGeeUploadTaskManager*)manager;

-(BOOL)addTask:(GeeUploadBaseParam*)param;
-(BOOL)stopTask:(int)tid;
-(BOOL)startTask:(int)tid;
-(BOOL)removeTask:(int)tid;
-(BOOL)stopAll;
-(BOOL)startAll;
-(void)doTask;

-(void)startThread;
-(void)doThreadWork;
-(int)processTask:(GeeUploadData*)data;
-(NSMutableArray*)getTaskList;

@property (nonatomic,retain)NSString* uploadUrl;
@property (nonatomic,retain)NSString* errorInfoUrl;
@property (nonatomic,assign)id<GeeUploadDelegate> delegate;
@property (nonatomic,retain)NSString* uploadParentFolderName;

@end
