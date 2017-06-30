//
//  GeeHttpRequest.h
//  HappyShare
//
//  Created by eingbol on 13-5-8.
//  Copyright (c) 2013年 Lin Pan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseRequestResult : NSObject

@property int result;

@end

@interface ServerAddressRequestResult : BaseRequestResult

@property (nonatomic,retain)NSString* serverAddress;
@property int serverPort;
@property (nonatomic,retain)NSString* sessionId;
@property (nonatomic,retain)NSString* nsid;
@property int cdnResult;

@end

@interface GeeErrorInfo : NSObject

@property (nonatomic,retain)NSString* type;
@property (nonatomic,retain)NSString* name;
@property int err;
@property (nonatomic,retain)NSString* description;
@property int elapsed;

-(NSDictionary*)toDict;

@end

@interface GeeHttpRequest : NSObject

+(ServerAddressRequestResult*)requestUploadServerAddress:(NSString*)url dict:(NSDictionary*)dict;
+(int)setErrorInfo:(NSString*)url errorInfo:(GeeErrorInfo*)errorInfo;

@end
