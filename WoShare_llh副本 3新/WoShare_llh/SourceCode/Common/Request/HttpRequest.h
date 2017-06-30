//
//  HttpRequest.h
//  QYSDK
//
//  Created by 胡 波 on 13-4-3.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestType.h"
#import "JSONKit.h"
#import "CacheObject.h"
@protocol HTTPRequestDelegate;

@interface HTTPRequest : NSObject {
    
    BOOL                    isLoading_;
    RequestType             requestType_;
    NSString                *urlString_;
    id<HTTPRequestDelegate> delegate_;
    
    NSDictionary            *parameters_;
    NSArray                 *fileData_;
    NSString                *cookies_;
    
    NSURLConnection         *connection_;
    NSMutableData           *currentData_;
    id                      userData_;
    
}
@property (nonatomic, readonly) BOOL                    isLoading;
@property (nonatomic, readonly) RequestType             requestType;
@property (nonatomic, assign)   id<HTTPRequestDelegate> delegate;
@property (nonatomic, retain)   NSDictionary            *parameters;
@property (nonatomic, retain)   NSArray                 *fileData;
@property (nonatomic, retain)   id                      userData;
@property (nonatomic, retain)   NSString                *cookies;
@property (nonatomic, retain)   NSString                *urlString;

@property (nonatomic, retain)   NSString                *nameString;
@property (nonatomic, retain)   CacheObject             *cacheObject;
-(id)initWithRequestType:(RequestType)requestType;

-(void)startWithUrl:(NSString*)_url;
-(void)startGetWithUrl:(NSString *)_url;
-(void)cancel;

@end


@protocol HTTPRequestDelegate <NSObject>

-(void)httpRequest:(HTTPRequest*)request didFinish:(id)result;
-(void)httpRequest:(HTTPRequest*)request didReceiveCookie:(NSString*)cookie;
-(void)httpRequest:(HTTPRequest*)request didFail:(NSError*)error;

@end
