//
//  HttpRequest.m
//  QYSDK
//
//  Created by 胡 波 on 13-4-3.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "HTTPRequest.h"
#import "FVKit.h"
@interface HTTPRequest (Private)<NSURLConnectionDelegate>

-(void)setPostData:(NSMutableURLRequest*)request;

@end

@implementation HTTPRequest
@synthesize isLoading=isLoading_;
@synthesize requestType=requestType_;
@synthesize delegate=delegate_;
@synthesize parameters=parameters_;
@synthesize fileData=fileData_;
@synthesize userData=userData_;
@synthesize cookies=cookies_;
@synthesize urlString=urlString_;
-(id)initWithRequestType:(RequestType)requestType
{
    if((self=[super init]))
    {
        requestType_=requestType;
    }
    return self;
}

-(void)dealloc
{
    [parameters_ release];
    [fileData_ release];
    [userData_ release];
    [urlString_ release];
    if(connection_)
    {
        [connection_ cancel];
        [connection_ release];
    }
    [currentData_ release];
    [cookies_ release];
    [_cacheObject release];
    [_nameString release];
    [super dealloc];
}

-(void)startWithUrl:(NSString *)_url
{//post
    [self cancel];
    urlString_ = [_url retain];
    NSURL *url=[NSURL URLWithString:_url];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request addValue:@"TRUE" forHTTPHeaderField:@"Mobile-Device"];
    if(cookies_)
        [request addValue:cookies_ forHTTPHeaderField:@"Cookie"];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    NSDictionary  *dic  = nil;
    if (parameters_ != nil) {
        NSString *jsonString = [parameters_ JSONString];
        dic = [NSDictionary dictionaryWithObjectsAndKeys:jsonString,@"input",nil];
    }
    [self setPostData:request withDic:dic];
    currentData_=[[NSMutableData alloc] init];
    isLoading_=YES;
    connection_=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(void)startGetWithUrl:(NSString *)_url
{//get
    [self cancel];
    urlString_ = [_url retain];
    NSURL *url=[NSURL URLWithString:_url];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request addValue:@"TRUE" forHTTPHeaderField:@"Mobile-Device"];
    if(cookies_)
        [request addValue:cookies_ forHTTPHeaderField:@"Cookie"];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    currentData_=[[NSMutableData alloc] init];
    isLoading_=YES;
    connection_=[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(void)cancel
{
    if(connection_)
    {
        [connection_ cancel];
        [connection_ release];
        connection_=nil;
    }
    if(currentData_)
    {
        [currentData_ release];
        currentData_=nil;
    }
    isLoading_=NO;
}

-(void)setPostData:(NSMutableURLRequest*)request withDic:(NSDictionary*)dic
{
    [request setHTTPMethod:@"POST"];
    NSString *stringBoundary = @"0xKhTmLbOuNdArY";
    [request addValue:[NSString stringWithFormat:@"multipart/form-data; charset=utf-8; boundary=%@",stringBoundary] forHTTPHeaderField:@"Content-Type"];
    NSMutableData *postData=[NSMutableData data];
    [postData appendData:[[NSString stringWithFormat:@"--%@\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *endItemBoundary=[NSString stringWithFormat:@"\r\n--%@\r\n",stringBoundary];
    NSArray *allKeys=[dic allKeys];
    for(NSString *key in allKeys)
    {
        NSInteger index=[allKeys indexOfObject:key];
        [postData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key] dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[[dic objectForKey:key] dataUsingEncoding:NSUTF8StringEncoding]];
        if(index!=([allKeys count]-1)||[fileData_ count]>0)
            [postData appendData:[endItemBoundary dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    for(NSDictionary *fileInfo in fileData_)
    {
        NSString *s=[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",[fileInfo objectForKey:@"key"],[fileInfo objectForKey:@"fileName"]];
        [postData appendData:[s dataUsingEncoding:NSUTF8StringEncoding]];
        s=@"Content-Type: image/jpeg\r\n\r\n";
        [postData appendData:[s dataUsingEncoding:NSUTF8StringEncoding]];
        [postData appendData:[fileInfo objectForKey:@"data"]];
    }
    
    [postData appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request addValue: [NSString stringWithFormat:@"%d",postData.length] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
}



//http://110.52.11.184/openapi/?Axon_key=6ac259c56f1405156fe4ca007332b841&spid=3g.sina.com.cn&appid=001&timestamp=1322042253&response=bb88e0721a6bbe3c084ffe9a1d58d277

-(NSString *)urlEncode:(NSString *)str
{
	NSString *result=(NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, CFSTR(":/?#[]@!$'()*+,;="), kCFStringEncodingUTF8);
	return [result autorelease];
}

#pragma mark NSURLConnection Delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if([response isKindOfClass:[NSHTTPURLResponse class]])
    {
        NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
        NSDictionary *allHeaderFields=[httpResponse allHeaderFields];
        NSString *cookies=[allHeaderFields objectForKey:@"Set-Cookie"];
        if(cookies)
        {
            if(delegate_&&[delegate_ respondsToSelector:@selector(httpRequest:didReceiveCookie:)])
                [delegate_ httpRequest:self didReceiveCookie:cookies];
        }
        
    }
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [currentData_ appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    isLoading_=NO;
    [connection_ release];
    connection_=nil;
    
    //debug log
//    FVLog(@"\n-------------------------------------\nRequestURL:%@\n\nResult:%@\n-------------------------------------\n",[self urlString],[[[NSString alloc] initWithData:currentData_ encoding:NSUTF8StringEncoding] autorelease]);
    //Here callback result
    NSDictionary *dic = [currentData_ objectFromJSONData];
    if ([_nameString length]>0) {
        [[NSFileManager defaultManager]createFileAtPath:_nameString contents:nil attributes:nil];
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[[[NSString alloc] initWithData:currentData_ encoding:NSUTF8StringEncoding] autorelease],@"jsondic",[NSDate date],@"savedate", nil];
        BOOL result = [dict writeToFile:_nameString atomically:YES];
        if (!result) {
            FVLog(@"cache error with code 4068");
        }
        else
        {
            FVLog(@"\n-------------------------------------\ncache ok\n-------------------------------------\n");
        }
    }
    if(delegate_&&[delegate_ respondsToSelector:@selector(httpRequest:didFinish:)])
        [delegate_ httpRequest:self didFinish:dic];
    
    [currentData_ release];
    currentData_=nil;
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    isLoading_=NO;
    [connection_ release];
    connection_=nil;
    [currentData_ release];
    currentData_=nil;
    
//    FVLog(@"\n-------------------------------------\nRequestURL:%@\n\nRequest failed:%@\n-------------------------------------\n",[self urlString],[error localizedDescription]);
    
    if(delegate_&&[delegate_ respondsToSelector:@selector(httpRequest:didFail:)])
        [delegate_ httpRequest:self didFail:error];
}


@end

