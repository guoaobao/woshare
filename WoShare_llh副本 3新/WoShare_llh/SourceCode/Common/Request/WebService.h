//
//  WebService.h
//  QYSDK
//
//  Created by 胡 波 on 13-4-3.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestType.h"
#import "FVKit.h"
#import "UserInfoResponse.h"
#import "JSONKit.h"
#import "CacheObject.h"
@protocol WebServiceDelegate;

@interface WebService : NSObject {
    
    NSMutableArray          *requestQueue_;
    id<WebServiceDelegate>  delegate_;
    
    NSString                *cookies_;
    UserInfoResponse        *userInfo_;
    BOOL                    isLogined_;
    JSONDecoder             *json_;
}

@property (nonatomic, assign)   id<WebServiceDelegate>  delegate;
@property (nonatomic, retain) UserInfoResponse        *userInfo;
@property (nonatomic, readonly) BOOL                    isLogined;
-(id)initWithDelegate:(id<WebServiceDelegate>)delegate;
-(void)startWithRequestType:(RequestType)type withData:(NSDictionary*)dic withCachePara:(CacheObject*)cache;


-(void)logout;

@property(nonatomic, copy) NSString *picbaseurl;
@end


@protocol WebServiceDelegate <NSObject>

//接口回调
-(void)webService:(WebService*)webService requestType:(RequestType)requestType didFinish:(id)response userData:(id)userData originalData:(id)data;
-(void)webService:(WebService*)webService requestType:(RequestType)requestType didFail:(NSError*)error userData:(id)userData;
-(void)webService:(WebService *)webService requestType:(RequestType)requestType didFinishWithError:(id)errorData userData:(id)userData;
@end
