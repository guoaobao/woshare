//
//  GeeUploadData.m
//  HappyShare
//
//  Created by eingbol on 13-5-8.
//  Copyright (c) 2013年 Lin Pan. All rights reserved.
//

#import "GeeUploadData.h"
#import "GeeHttpRequest.h"
#import "GeeUploadParam.h"

#include "CalcFileID.h"
#include "GeeUpload.h"


#define DO_STOP if(_isStop == YES)\
                {\
                    gr.Result = GU_ERROR_STOP;\
                    return gr;\
                }


///////////////////////////////////////////
@implementation IGeeUploadData

@synthesize param;
@synthesize tid;
@synthesize status;
@synthesize errorNum;
@synthesize per;
@synthesize lastResult;

- (void)dealloc
{
    [param release];
    [lastResult release];
    [super dealloc];
}

-(NSDictionary*)toDict
{
    NSDictionary* dict = [self.param toDict];
    NSMutableDictionary* mDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    [mDict setObject:[NSNumber numberWithInt:self.status] forKey:@"status"];
    return [NSDictionary dictionaryWithDictionary:mDict];
}

-(id)initWithDict:(NSDictionary*)dict
{
    self = [self init];
    if(self)
    {
        self.param = [[[GeeUploadParam alloc] initWithDict:dict] autorelease];
        id statusObj = [dict objectForKey:@"status"];
        if(statusObj)
        {
            self.status = (GeeTaskStatus)[statusObj intValue];
        }
    }
    return self;
}

@end


///////////////////////////////////////////////
@implementation IOSProgressCallbackData

@synthesize total;
@synthesize upload;
@synthesize per;
@synthesize data;

- (void)dealloc
{
    [data release];
    [super dealloc];
}

@end

//////////////////////////////////////
class GeeUploadCallback : public IGeeCallback
{
public:
    GeeUploadCallback(void* sel,void* obj,void* param)
    {
        _selector = (SEL)sel;
        _callbackObj = (NSObject*)obj;
        _data = (GeeUploadData*)param;
    }
    virtual void progressFunc(ProgressCallbackData* data)
    {
        IOSProgressCallbackData* iosData = [[IOSProgressCallbackData alloc] init];
        iosData.total = data->total;
        iosData.upload = data->upload;
        iosData.per = data->per;
        iosData.data = _data;
        [_callbackObj performSelector:_selector withObject:(id)iosData];
        [iosData release];
    }
private:
    NSObject* _callbackObj;
    SEL _selector;
    GeeUploadData* _data;
};

static IGeeCallback* createCallback(void* sel,void* obj,void* param)
{
    return (IGeeCallback*)new GeeUploadCallback(sel,obj,param);
}

///////////////////////////////////////////////

@implementation GeeUploadData

@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self) {
        _isStop = NO;
        _gu = NULL;
        _totalSize = 0;
        _baseSize = 0;
    }
    return self;
}

- (void)dealloc
{
    if(_gu)
    {
        GeeUpload* gu = (GeeUpload*)_gu;
        delete gu;
        _gu = NULL;
    }
    delegate = nil;
    [super dealloc];
}

-(GeeUploadResult*)operation:(NSString*)url parentName:(NSString*)name
{
    NSLog(@"operation,url:%@,name:%@",url,name);
    GeeUploadResult* gr = [[[GeeUploadResult alloc] init] autorelease];
    //init
    _isStop = NO;
    if([self calSize] != 1)
    {
        gr.result = GU_ERROR_CALFILEID;
        self.lastResult = gr;
        return gr;
    }
    //
    for (GeeUploadFileInfo* fileinfo in self.param.fileinfos)
    {
        if(fileinfo.status == GEE_TASK_COMPLETE)
            continue;
        NSDictionary* dict = [self.param toUploadDict];
        NSMutableDictionary* uploadDict = [NSMutableDictionary dictionaryWithDictionary:dict];
        //nm or pid
        if(self.param.pid && [self.param.pid length] > 0)
        {
            [uploadDict setObject:self.param.pid forKey:@"pid"];
        }
        else
        {
            [uploadDict setObject:name forKey:@"nm"];
        }
        //filename
        [uploadDict setObject:fileinfo.filename forKey:@"fn"];
        //fid
        std::string fid = "";
        if(CalcFileID([fileinfo.path cStringUsingEncoding:[NSString defaultCStringEncoding]],fid) != 1)
        {
            gr.result = GU_ERROR_CALFILEID;
            self.lastResult = gr;
            return gr;
        }
        [uploadDict setObject:[NSString stringWithFormat:@"%s",fid.c_str()] forKey:@"fid"];
        long long size;
        if(CaclFileSize([fileinfo.path cStringUsingEncoding:[NSString defaultCStringEncoding]],size) != 1)
        {
            gr.result = GU_ERROR_CALFILESIZE;
            self.lastResult = gr;
            return gr;
        }
        [uploadDict setObject:[NSNumber numberWithLongLong:size] forKey:@"size"];
        
        DO_STOP;
        
        NSLog(@"requestUploadServerAddress start...");
        ServerAddressRequestResult* sr = [GeeHttpRequest requestUploadServerAddress:url dict:uploadDict];
        NSLog(@"requestUploadServerAddress,result:%d,cdnResult:%d",sr.result,sr.cdnResult);
        if(sr.result == -3)
        {
            gr.result = 1;
            fileinfo.nsid = sr.nsid;
            //100% progress
            IOSProgressCallbackData* iosData = [[IOSProgressCallbackData alloc] init];
            _baseSize += size;
            iosData.total = _totalSize;
            iosData.upload = _baseSize;
            iosData.per = (double)_baseSize/(double)_totalSize;
            iosData.data = self;
            [self progressFuncCallback:iosData];
            [iosData release];
        }
        else if(sr.result == 1)
        {
            _gu = new GeeUpload();
            GeeUpload* gu = (GeeUpload*)_gu;
            int resConn = gu->connect([sr.serverAddress cStringUsingEncoding:[NSString defaultCStringEncoding]], sr.serverPort);
            IGeeCallback* callback = createCallback(@selector(progressFuncCallback:),self,self);
            gu->setCallback(callback);
            if(resConn == GU_OK)
            {
                std::string nsid = "";
                int resSend = gu->sendFile([sr.sessionId cStringUsingEncoding:[NSString defaultCStringEncoding]], [fileinfo.path cStringUsingEncoding:[NSString defaultCStringEncoding]],nsid);
                if(resSend == GU_OK)
                {
                    gr.result = 1;
                    fileinfo.nsid = [NSString stringWithFormat:@"%s",nsid.c_str()];
                    fileinfo.status = GEE_TASK_COMPLETE;
                }
                else
                {
                    gr.result = resSend;
                }
                gu->close();
            }
            else
            {
                gr.result = resConn;
            }
            delete gu;
            _gu = NULL;
            if(gr.result != 1)
            {
                break;
            }
        }
        else if(sr.result == -994)
        {
            gr.result = sr.result;
            gr.cdnResult = sr.cdnResult;
            break;
        }
        else
        {
            gr.result = sr.result;
            break;
        }
    }
    
    self.lastResult = gr;
    
    return gr;
}

-(void)stop
{
    _isStop = YES;
    if(_gu)
    {
        ((GeeUpload*)_gu)->stop();
    }
}

-(int)calSize
{
    for (GeeUploadFileInfo* fileinfo in self.param.fileinfos)
    {
        long long size;
        if(CaclFileSize([fileinfo.path cStringUsingEncoding:[NSString defaultCStringEncoding]],size) != 1)
        {
            return 0;
        }
        _totalSize += size;
        if(fileinfo.status == GEE_TASK_COMPLETE)
            _baseSize += size;
    }
    return 1;
}

-(void)progressFuncCallback:(IOSProgressCallbackData*)data
{
    data.total = _totalSize;
    data.upload += _baseSize;
    data.per = (double)data.upload/(double)data.total;
    self.per = data.per;
    if(delegate)
    {
        if([delegate respondsToSelector:@selector(progressCallback:)])
        {
            [delegate progressCallback:data];
        }
    }
}

-(NSDictionary*)toDict
{
    return [super toDict];
}

-(id)initWithDict:(NSDictionary*)dict
{
    return [super initWithDict:dict];
}

@end
