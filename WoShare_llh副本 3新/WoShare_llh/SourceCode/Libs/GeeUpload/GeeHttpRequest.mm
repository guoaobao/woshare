//
//  GeeHttpRequest.m
//  HappyShare
//
//  Created by eingbol on 13-5-8.
//  Copyright (c) 2013年 Lin Pan. All rights reserved.
//

#import "GeeHttpRequest.h"
#import "ASIFormDataRequest.h"
#import "GeeUploadCommon.h"
#import "JSONKit.h"

#define GEE_HTTP_REQUEST_TIMEOUT 10.0

@implementation BaseRequestResult

@synthesize result;

@end

@implementation ServerAddressRequestResult

@synthesize serverAddress;
@synthesize serverPort;
@synthesize sessionId;
@synthesize nsid;
@synthesize cdnResult;

- (void)dealloc
{
    [serverAddress release];
    [sessionId release];
    [nsid release];
    [super dealloc];
}

@end

@implementation GeeErrorInfo

@synthesize type;
@synthesize name;
@synthesize err;
@synthesize description;
@synthesize elapsed;

- (void)dealloc
{
    [type release];
    [name release];
    [description release];
    [super dealloc];
}

-(NSDictionary*)toDict
{
    return [NSDictionary dictionaryWithObjectsAndKeys:self.type,@"type",self.name,@"name",[NSNumber numberWithInt:self.err],@"errno",self.description,@"description",[NSNumber numberWithInt:self.elapsed],@"elapsed", nil];
}

@end

@implementation GeeHttpRequest

+(ServerAddressRequestResult*)requestUploadServerAddress:(NSString*)url dict:(NSDictionary*)dict
{
    ServerAddressRequestResult* sr = [[[ServerAddressRequestResult alloc] init] autorelease];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    [request setTimeOutSeconds:(NSTimeInterval)GEE_HTTP_REQUEST_TIMEOUT];
    [request setPostValue:[dict JSONString] forKey:@"input"];
    [request startSynchronous];
    if(![request error])//success
    {
        NSString* resultStr = [request responseString];
        NSData* resultData = [resultStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* resultDict = [resultData objectFromJSONData];
        if(resultDict)
        {
            NSString* resultDictStatus = [resultDict objectForKey:@"status"];
            NSDictionary* resultDictData = [resultDict objectForKey:@"data"];
            if(resultDictStatus && resultDictData)
            {
                if([resultDictStatus intValue] == 1)
                {
                    NSString* strNsid = [resultDictData objectForKey:@"nsid"];
                    if (strNsid && [strNsid length] > 0)
                    {
                        //fid exits
                        sr.result = -3;
                        sr.nsid = strNsid;
                    }
                    else
                    {
                        sr.serverAddress = [resultDictData objectForKey:@"serverIP"];
                        sr.serverPort = [[resultDictData objectForKey:@"port"] intValue];
                        sr.sessionId = [resultDictData objectForKey:@"sessionId"];
                        if(sr.serverAddress && sr.serverPort && sr.sessionId)
                        {
                            sr.result = 1;
                        }
                        else
                        {
                            sr.result = GU_ERROR_JSON_PARSE;
                        }
                    }
                    
                }
                else if([resultDictStatus intValue] == -994)
                {
                    sr.result = -994;
                    if ([resultDictData isKindOfClass:[NSDictionary class]]) {
                        id resultObj = [resultDictData objectForKey:@"result"];
                        if(resultObj)
                        {
                            sr.cdnResult = [resultObj intValue];//[[resultDict objectForKey:@"data"] intValue];
                        }
                    }else{
                        sr.result = [[resultDict objectForKey:@"data"] intValue];
                    }
                    
                    
                }
                else
                {
                    sr.result = [resultDictStatus intValue];
                }
            }
            else
            {
                sr.result = GU_ERROR_JSON_PARSE;
            }
        }
        else
        {
            sr.result = GU_ERROR_JSON_PARSE;
        }
    }
    else
    {
        sr.result = GU_ERROR_HTTPREQUEST;
    }
    return sr;
}

+(int)setErrorInfo:(NSString*)url errorInfo:(GeeErrorInfo*)errorInfo
{
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    [request setTimeOutSeconds:(NSTimeInterval)GEE_HTTP_REQUEST_TIMEOUT];
    [request setPostValue:[[errorInfo toDict] JSONString] forKey:@"input"];
    [request startSynchronous];
    int result = 0;
    if(![request error])//success
    {
        NSString* resultStr = [request responseString];
        NSData* resultData = [resultStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* resultDict = [resultData objectFromJSONData];
        if(resultDict)
        {
            id resultObj = [resultDict objectForKey:@"status"];
            if(resultObj)
            {
                result = [resultObj intValue];
            }
            else
            {
                result = GU_ERROR_JSON_PARSE;
            }
        }
        else
        {
            result = GU_ERROR_JSON_PARSE;
        }
    }
    else
    {
        result = GU_ERROR_HTTPREQUEST;
    }
    return result;
}

@end
