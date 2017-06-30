//
//  GeeUploadManager.m
//  QYSDK
//
//  Created by eingbol on 13-4-26.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "GeeUploadManager.h"
#import "GeeUploadCommonFunc.h"
#import "GeeHttpRequest.h"

@implementation GeeUploadManager

@synthesize uploadUrl;
@synthesize errorInfoUrl;
@synthesize delegate;
@synthesize uploadParentFolderName;

-(id)init
{
    self = [super init];
    if(self)
    {
        _thread = nil;
        _isThreadRunning = NO;
    }
    return self;
}

-(id)initWithUrl:(NSString*)url uploadParentFolderName:(NSString*)name taskManager:(IGeeUploadTaskManager*)manager
{
    self = [self init];
    if(self)
    {
        self.uploadUrl = url;
        self.uploadParentFolderName = name;
        _manager = [manager retain];
    }
    return self;
}

-(id)initWithUrl:(NSString*)url taskManager:(IGeeUploadTaskManager*)manager
{
    self = [self init];
    if(self)
    {
        self.uploadUrl = url;
        _manager = [manager retain];
    }
    return self;
}

-(void)dealloc
{
    [_manager release];
    [uploadUrl release];
    [errorInfoUrl release];
    [uploadParentFolderName release];
    [_thread release];
    delegate = nil;
    [super dealloc];
}

-(void)startThread
{
    NSLog(@"startThread...");
    if(!_isThreadRunning && _thread)
    {
        [_thread release];
        _thread = nil;
    }
    if(_thread == nil)
    {
        _thread = [[NSThread alloc] initWithTarget:self selector:@selector(doThreadWork) object:nil];
        _isThreadRunning = YES;
        [_thread start];
    }
}

-(void)doThreadWork
{
    NSLog(@"doThreadWork...");
    GeeUploadData* data = [[_manager getNextTask] retain];
    while (data) {
        int res = [self processTask:data];
        NSLog(@"processTask result:%d",res);
        [data release];
        data = [[_manager getNextTask] retain];
        if(data && data.errorNum != 0 && data.status != GEE_TASK_COMPLETE)
        {
            sleep(pow(2.0, data.errorNum));
        }
    }
    [data release];
    NSLog(@"doThreadWork end...");
    _isThreadRunning = NO;
}

-(BOOL)addTask:(GeeUploadBaseParam*)param
{
    for (GeeUploadFileInfo* fileinfo in param.fileinfos)
    {
        if(fileinfo.videourl)//video
        {
            NSFileManager* fm = [NSFileManager defaultManager];
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString* path = [paths objectAtIndex:0];
            NSString* basePath = [NSString stringWithFormat:@"%@/gee_cache",path];
            if (![fm fileExistsAtPath:basePath])
            {
                if ([fm createDirectoryAtPath:basePath withIntermediateDirectories:YES attributes:nil error:nil] == NO)
                {
                    NSLog(@"创建文件夹失败：%@",basePath);
                    return NO;
                }
            }
            NSDate* date = [NSDate dateWithTimeIntervalSince1970:0];
            NSTimeInterval nowTime = [date timeIntervalSince1970];
            NSString* videoPath = [NSString stringWithFormat:@"%@/%f_%ld.tmp",basePath,nowTime,random()];
            NSString *back = [NSString stringWithFormat:@"%@",videoPath];
            NSError* error = nil;
            videoPath = [@"file://" stringByAppendingString:videoPath];
            [fm copyItemAtURL:fileinfo.videourl toURL:[NSURL URLWithString:videoPath] error:&error];
            if (error)
            {
                return NO;
            }
            fileinfo.path = back;
            fileinfo.status = GEE_TASK_PENDING;
        }
        else
        {
            NSFileManager* fm = [NSFileManager defaultManager];
            NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString* path = [paths objectAtIndex:0];
            NSString* basePath = [NSString stringWithFormat:@"%@/gee_cache",path];
            if (![fm fileExistsAtPath:basePath])
            {
                if ([fm createDirectoryAtPath:basePath withIntermediateDirectories:YES attributes:nil error:nil] == NO)
                {
                    NSLog(@"创建文件夹失败：%@",basePath);
                    return NO;
                }
            }
            NSDate* date = [NSDate dateWithTimeIntervalSince1970:0];
            NSTimeInterval nowTime = [date timeIntervalSince1970];
            NSString* imagePath = [NSString stringWithFormat:@"%@/%f_%ld.tmp",basePath,nowTime,random()];
            if(![GeeUploadCommonFunc writeImage:fileinfo.image toFileAtPath:imagePath])
            {
                NSLog(@"image write error");
                return NO;
            }
            fileinfo.path = imagePath;
            fileinfo.status = GEE_TASK_PENDING;
        }
    }
    
    GeeUploadData* data = [[GeeUploadData alloc] init];
    data.param = param;
    data.status = GEE_TASK_PENDING;
    [_manager addTask:data];
    [data release];
    [self startThread];
    return  YES;
}

-(BOOL)stopTask:(int)tid
{
    return [_manager stopTask:tid];
}

-(BOOL)startTask:(int)tid
{
    BOOL res = [_manager startTask:tid];
    [self startThread];
    return res;
}

-(BOOL)removeTask:(int)tid
{
    GeeUploadData* data = [[_manager getTask:tid] retain];
    if(data)
    {
        [_manager stopTask:tid];
        BOOL res = [_manager removeTask:tid];
        if(res)
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
        [data release];
        return res;
    }
    else
    {
        return NO;
    }
}
-(BOOL)stopAll
{
    return [_manager stopAll];
}

-(BOOL)startAll
{
    return [_manager startAll];
}

-(void)doTask
{
    [self startThread];
}

-(int)processTask:(GeeUploadData*)data
{
    NSLog(@"processTask,id:%d",data.tid);
    data.delegate = self;
    data.status = GEE_TASK_PROCESS;
    long startTime = [GeeUploadCommonFunc getNowTime];
    GeeUploadResult* gr = [data operation:uploadUrl parentName:uploadParentFolderName];
    long endTime = [GeeUploadCommonFunc getNowTime];
    data.delegate = nil;
    if(gr.result == 1)
    {
        data.status = GEE_TASK_COMPLETE;
    }
    else
    {
        if(data.status != GEE_TASK_STOP)
        {
            data.status = GEE_TASK_ERROR;
            data.errorNum++;
        }
    }
    //seterrorinfo
    if(errorInfoUrl)
    {
        GeeErrorInfo* errInfo = [[GeeErrorInfo alloc] init];
        errInfo.type = @"140";
        errInfo.name = @"tcp upload";
        errInfo.err = gr.result;
        errInfo.description = [gr errorString];
        errInfo.elapsed = (int)(startTime - endTime);
        int res = [GeeHttpRequest setErrorInfo:errorInfoUrl errorInfo:errInfo];
        NSLog(@"upload file seterrorinfo result:%d",res);
        [errInfo release];
    }
    [_manager save];
    if(delegate)
    {
        if([delegate respondsToSelector:@selector(uploadCompleteCallback:obj:)])
        {
            [delegate uploadCompleteCallback:gr obj:data];
        }
    }
    return gr.result;
}

-(void)progressCallback:(IOSProgressCallbackData*)obj
{
    if(delegate)
    {
        if([delegate respondsToSelector:@selector(progressCallback:)])
        {
            [delegate progressCallback:obj];
        }
    }
}

-(void)uploadCompleteCallback:(GeeUploadResult*)gr obj:(IGeeUploadData*)obj
{
    return;
}

-(NSMutableArray*)getTaskList
{
    return [_manager getTaskList];
}

@end
