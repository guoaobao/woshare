//
//  RequestManager.h
//  QYSDK
//
//  Created by 胡 波 on 13-4-8.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestType.h"
#import "Reachability.h"
#import "UserInfoResponse.h"
//#import "Parameter.h"
//#import "SNSParameter.h"
#import "CacheObject.h"
@protocol RequestManagerDelegate;
@class WebService;
@class Location;
@interface RequestManager : NSObject
{
    Reachability    *reachability_;

    
    BOOL            isLockDelegateQueue_;
    NSMutableArray  *delegateQueue_;
    NSMutableArray  *delegateHandlers_;
    
    NSLock          *callbackLock_;
    
    WebService      *webService_;
    
    int             repeatTimes;
    
}
@property (nonatomic,readonly)  NetworkStatus   currentReachabilityStatus;
@property (nonatomic,readonly)  UserInfoResponse        *userInfo;
@property (nonatomic,readonly)  BOOL            isLogined;
@property(nonatomic, copy) NSString *picbaseurl;
+(RequestManager*)sharedManager;
+(void)releaseInstance;

-(void)addDelegate:(id<RequestManagerDelegate>)delegate;
-(void)removeDelegate:(id)delegate;

-(void)startRequestWithType:(RequestType)type withData:(NSDictionary *)dic;
-(void)startRequestWithType:(RequestType)type withData:(NSDictionary *)dic withCacheObject:(CacheObject*)cache;
-(id)startRequestWithTypeSynchro:(RequestType)type withData:(NSDictionary *)dic;

-(void)logout;
-(void)startService;
-(void)getPhoneNumber;
-(void)getHobbyRequest;
-(void)getUsersNoteUidListRequest;
-(void)getResourceRequest:(NSString*)nsid;
@end

@protocol RequestManagerDelegate <NSObject>
@optional
-(void)networkStatusChanged:(NetworkStatus)networkStatus;

-(void)webServiceRequest:(RequestType)requestType response:(id)response userData:(id)userData originalData:(id)data;
-(void)webServiceRequest:(RequestType)requestType error:(NSError*)error userData:(id)userData;
-(void)webServiceRequest:(RequestType)requestType errorString:(NSString*)errorString userData:(id)userData;
-(void)webServiceRequest:(RequestType)requestType errorData:(NSDictionary*)errorData userData:(id)userData;

@end
