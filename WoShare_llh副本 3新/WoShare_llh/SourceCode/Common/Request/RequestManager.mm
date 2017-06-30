//
//  RequestManager.m
//  QYSDK
//
//  Created by 胡 波 on 13-4-8.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "RequestManager.h"
#import "DelegateHandler.h"
#import "WebService.h"
#import "DataSource.h"
#import "Location.h"
#import "AnalyticalError.h"
#import "AppConfig.h"
#import "ASIHTTPRequest.h"
#import "DES3Util.h"
@interface RequestManager (Private)<WebServiceDelegate>
-(void)callbackDelegate:(RequestType)requestType object:(id)object;

@end

@implementation RequestManager
@synthesize userInfo=userInfo_;
@synthesize isLogined=isLogined_;
static RequestManager *_sharedRequestManagerInstance=nil;

+(RequestManager*)sharedManager
{
    @synchronized(self)
    {
        if(_sharedRequestManagerInstance==nil)
        {
            _sharedRequestManagerInstance=[[self alloc] init];
        }
        return _sharedRequestManagerInstance;
    }
    return nil;
}

+(void)releaseInstance
{
    if(_sharedRequestManagerInstance)
    {
        [_sharedRequestManagerInstance release];
        _sharedRequestManagerInstance=nil;
    }
    
}

+(id)alloc
{
    NSAssert(_sharedRequestManagerInstance==nil,@"Attempted to allocate a second instance of a singleton.");
    return [super alloc];
}

-(id)init
{
    if (self = [super init]) {
        delegateQueue_=[[NSMutableArray alloc] initWithCapacity:1];
        delegateHandlers_=[[NSMutableArray alloc] initWithCapacity:1];
        
        callbackLock_=[[NSLock alloc] init];
        
        reachability_=[[Reachability reachabilityWithHostName:@"www.baidu.com"]retain];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
        [reachability_ startNotifier];
        
        webService_ = [[WebService alloc]initWithDelegate:self];
        isLogined_ = NO;
        repeatTimes = 0;
    }
    return  self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [reachability_ release];
    [delegateQueue_ release];
    [delegateHandlers_ release];
    [webService_ release];
    [super dealloc];
}


#pragma mark - fast api
-(void)startService
{
    if ([Config getLocToken]) {
        [self startRequestWithType:kRequestTypeAutoLogin withData:[NSDictionary dictionaryWithObjectsAndKeys:[Config getLocToken],@"token", nil]];
        NSLog(@"token:%@",[Config getLocToken]);
    }
}


-(void)getHobbyRequest
{
    [self startRequestWithType:kRequestTypeGetHobby withData:nil];
}

-(void)getUsersNoteUidListRequest
{
    [self startRequestWithType:kRequestTypeGetNoteUids withData:nil];
}

-(void)getResourceRequest:(NSString*)nsid
{
    NSDictionary *dic = @{@"nsid": nsid};
    [self startRequestWithType:kRequestTypeGetNameSpaceInfo withData:dic];
}

-(void)getPhoneNumber
{
    repeatTimes ++;
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSInteger   curTimestamp = (int)time;
    NSString *res = [NSString stringWithFormat:@"%@%d%@",kAXSpid,curTimestamp,kAXPassword];
    NSString *responsed = [NSString stringwithMd5Encode:res];
    NSString *getURL = [NSString stringWithFormat:@"http://mob.kk3g.net/GetMsisdn?Axon_key=%@&spid=%@&timestamp=%d&response=%@",[[DataSource sharedDataSource]getDeviceID],kAXSpid,curTimestamp,responsed];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:getURL]];
    [request setDelegate:self];
    [request startAsynchronous];

}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *response = [request responseString];
    response = [response stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    response = [response stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    response = [response stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSDictionary *dic = [response objectFromJSONString];
    if ([[dic objectForKey:@"retCode"]integerValue]==0) {
        NSString *phone = [dic objectForKey:@"mob"];
        NSString *mobile = [DES3Util DESDecrypt:phone];
        [self startRequestWithType:kRequestTypeCheckMobile withData:[NSDictionary dictionaryWithObjectsAndKeys:mobile,@"phone",@"1",@"autologin", nil]];
    }
    else
    {
        if (repeatTimes <= 3) {
            [self getPhoneNumber];
        }
        else
        {
            for(id delegate in delegateQueue_)
            {
                if ([delegate respondsToSelector:@selector(webServiceRequest:errorString:userData:)]) {
                    [delegate webServiceRequest:kRequestTypeCheckMobile errorString:@"取号失败" userData:nil];
                }
            }
        }
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    if (repeatTimes <= 3) {
        [self getPhoneNumber];
    }
    else
    {
        for(id delegate in delegateQueue_)
        {
            if ([delegate respondsToSelector:@selector(webServiceRequest:errorString:userData:)]) {
                [delegate webServiceRequest:kRequestTypeCheckMobile errorString:@"取号失败" userData:nil];
            }
        }
    }
}

#pragma mark - api
#pragma mark - api
//-(void)startRequestWithParameter:(BaseParameter *)parameter withCacheObject:(CacheObject*)cache
//{
//    RequestType     type = parameter.requestType;
//    NSDictionary    *dic =  [self getDict:type withParameter:parameter];
//    [self startRequestWithType:type withData:dic withCacheObject:cache];
//}
//
//-(void)startRequestWithParameter:(BaseParameter *)parameter
//{
//    RequestType     type = parameter.requestType;
//    NSDictionary    *dic =  [self getDict:type withParameter:parameter];
//    [self startRequestWithType:type withData:dic withCacheObject:nil];
//}

-(void)startRequestWithType:(RequestType)type withData:(NSDictionary *)dic
{
    if (self.isLogined && type == kRequestTypeLogin) {
        return;
    }
    [self startRequestWithType:type withData:dic withCacheObject:nil];
}

-(void)startRequestWithType:(RequestType)type withData:(NSDictionary *)dic withCacheObject:(CacheObject*)cache
{
    if (self.isLogined && type == kRequestTypeLogin) {
        return;
    }
    [webService_ startWithRequestType:type withData:dic withCachePara:cache];
}

//-(void)startService
//{
//    if ([Config getLocToken]) {
//        AutoLoginParameter *para = [[[AutoLoginParameter alloc]init]autorelease];
//        para.token = [Config getLocToken];
//        [self startRequestWithParameter:para];
//        FVLog(@"###########################\n autologin\n ###########################");
//    }
//}
//
//-(void)autoLoginWithToken:(BOOL)isToken
//{
//    if (isToken && [DataSource sharedDataSource].appSetting.isLogined && [[DataSource sharedDataSource].account.token length]>0) {
//        AutoLoginParameter *para = [[[AutoLoginParameter alloc]init]autorelease];
//        para.token = [DataSource sharedDataSource].account.token;
//        [self startRequestWithParameter:para];
//        FVLog(@"###########################\n autologin\n ###########################");
//    }
//    else
//    {
//        if ([DataSource sharedDataSource].appSetting.isLogined && [[DataSource sharedDataSource].account.username length]>0 && [[DataSource sharedDataSource].account.password length]>0) {
//            LoginParameter *para = [[[LoginParameter alloc]init]autorelease];
//            para.account = [DataSource sharedDataSource].account.username;
//            para.password = [DataSource sharedDataSource].account.password;
//            [self startRequestWithParameter:para];
//            FVLog(@"###########################\n autologin\n ###########################");
//        }
//    }
//}

-(id)startRequestWithTypeSynchro:(RequestType)type withData:(NSDictionary *)dic
{
    return nil;
}

-(void)logout
{
    [webService_ logout];
}

-(UserInfoResponse*)userInfo
{
    return webService_.userInfo;
}

-(BOOL)isLogined
{
    return webService_.isLogined;
}

- (NSString *)picbaseurl
{
    return webService_.picbaseurl;
}

//-(NSDictionary*)getDict:(RequestType)type withParameter:(BaseParameter*)parameter
//{
//    switch (type) {
//        case kRequestTypeGetUpload:
//            return [(UpLoadUrlParameter*)parameter getDict];
//        case kRequestTypeCompleteUpLoad:
//            return [(CompleteUploadParameter*)parameter getDict];
//        case kRequestTypeGetDiskList:
//            return [(DiskListParameter*)parameter getDict];
//        case kRequestTypeGetRecentUploadList:
//            return [(RecentFileListParameter*)parameter getDict];
//        case kRequestTypeSearchNs:
//            return[(SearchNsParameter*)parameter getDict];
//        case kRequestTypeCreateFolder:
//            return [(CreateFolderParameter*)parameter getDict];
//        case kRequestTypeMoveFile:
//            return [(MoveFileParameter*)parameter getDict];
//        case kRequestTypeRenameFile:
//            return [(RenameFileParameter*)parameter getDict];
//        case kRequestTypeDelFile:
//            return [(DeleteFileParameter*)parameter getDict];
//        case kRequestTypeRestoreFile:
//            return [(RestoreFileParameter*)parameter getDict];
//        case kRequestTypeGetDownloadURL:
//            return [(DownloadUrlParameter*)parameter getDict];
//        case kRequestTypeGetNameSpaceInfo:
//            return [(NameSpaceInfoParameter*)parameter getDict];
//        case kRequestTypeSetFolderInfo:
//            return [(SetFolderInfoParameter*)parameter getDict];
//        case kRequestTypeLikens:
//            return [(LikensParamater*)parameter getDict];
//        case kRequestTypeClickns:
//            return [(ClicknsParameter*)parameter getDict];
//        case kRequestTypeGetSpaceStatInfo:
//            return [(SpaceStatInfoParameter*)parameter getDict];
//        case kRequestTypeSetFileInfo:
//            return [(SetFileInfoParameter*)parameter getDict];
//            //disk
//        case kRequestTypeGetAppCategory:
//            return [(AppCategoryParameter*)parameter getDict];
//        case kRequestTypeGetTopCategory:
//            return [(TopCategoryParameter*)parameter getDict];
//        case kRequestTypeGetChildrenBlock:
//            return [(ChildrenBlockParameter*)parameter getDict];
//        case kRequestTypeGetBlockFileList:
//            return [(BlockFileListParameter*)parameter getDict];
//        case kRequestTypeGetBlockUserList:
//            return [(BlockUserListParameter*)parameter getDict];
//        case kRequestTypeGetScheduleList:
//            return [(ScheduleListParameter*)parameter getDict];
//        case kRequestTypeGetHotWordsList:
//            return [(HotWordParameter*)parameter getDict];
//        case kRequestTypeGetPrizeList:
//            return [(PrizeListParameter*)parameter getDict];
//        case kRequestTypePrize:
//            return [(PrizeParameter*)parameter getDict];
//            //app
//        case kRequestTypeRegister:
//            return [(RegisterParameter*)parameter getDict];
//        case kRequestTypeLogin:
//            return [(LoginParameter*)parameter getDict];
//        case kRequestTypeLogout:
//            return [(LogoutParameter*)parameter getDict];
//        case kRequestTypeModifyPassword:
//            return [(ModifyPasswordParameter*)parameter getDict];
//        case kRequestTypeModifyUserName:
//            return [(ModifyUsernameParameter*)parameter getDict];
//        case kRequestTypeModifyAvatar:
//            return [(ModifyAvatarParameter*)parameter getDict];
//        case kRequestTypeModifyBackground:
//            return [(ModifyBackgroundParameter*)parameter getDict];
//        case kRequestTypeSearchUser:
//            return [(SearchUserParameter*)parameter getDict];
//        case kRequestTypeGetHotUserList:
//            return [(HotUserListParameter*)parameter getDict];
//        case kRequestTypeGetPersonageList:
//            return [(PersonageListParameter*)parameter getDict];
//        case kRequestTypeBindMobile:
//            return [(BindMobileParameter*)parameter getDict];
//        case kRequestTypeUnbindMobile:
//            return [(UnBindMobileParameter*)parameter getDict];
//        case kRequestTypeAutoLogin:
//            return [(AutoLoginParameter*)parameter getDict];
//            //user
//        case kRequestTypeNote:
//            return [(NoteParameter*)parameter getDict];
//        case kRequestTypeGetNoteList:
//            return [(NoteListParameter*)parameter getDict];
//        case kRequestTypeGetNoteUids:
//            return [(NoteUidParameter*)parameter getDict];
//            //note
//        case kRequestTypeGetFavoriteList:
//            return [(FavorriteListParameter*)parameter getDict];
//        case kRequestTypeAddClass:
//            return [(AddFavouriteClassParameter*)parameter getDict];
//        case kRequestTypeAddFavorite:
//            return [(AddFavouriteParameter*)parameter getDict];
//        case kRequestTypeDelFavorite:
//            return [(DelFavouriteParameter*)parameter getDict];
//            //favourite
//        case kRequestTypeGetCommentList:
//            return [(CommentListParameter*)parameter getDict];
//        case kRequestTypeAddComment:
//            return [(AddCommentParameter*)parameter getDict];
//        case kRequestTypeDelComment:
//            return [(DeleteCommentParameter*)parameter getDict];
//            //comment
//        case kRequestTypeGetEventList:
//            return [(EventListParameter*)parameter getDict];
//        case kRequestTypeGetEventInfo:
//            return [(EventInfoParameter*)parameter getDict];
//        case kRequestTypeGetEventFileList:
//            return [(EventFileListParameter*)parameter getDict];
//        case kRequestTypeGetEventUserList:
//            return [(EventUserListParameter*)parameter getDict];
//        case kRequestTypeGetJoinedEventList:
//            return [(JoinedEventListParameter*)parameter getDict];
//        case kRequestTypeVote:
//            return [(VoteParameter*)parameter getDict];
//        case kRequestTypeApplyGuests:
//            return [(ApplyGuestParameter*)parameter getDict];
//        case kRequestTypeGetEventWinnerList:
//            return [(EventClassListParameter*)parameter getDict];
//            //event
//        case kRequestTypeGetUsermsgList:
//            return [(MessageListParameter*)parameter getDict];
//        case kRequestTypeCompleteRead:
//            return [(CompleteReadParameter*)parameter getDict];
//        case kRequestTypeDeleteUsermsg:
//            return [(DeleteCommentParameter*)parameter getDict];
//        case kRequestTypeSetReceivemsg:
//            return [(SetReceivemsgParameter*)parameter getDict];
//        case kRequestTypeSendmsg:
//            return [(SendmsgParameter*)parameter getDict];
//        case kRequestTypeGetFeedsList:
//            return [(FeedsListParameter*)parameter getDict];
//        case kRequestTypeCompleteReadFeeds:
//            return [(CompleteReadFeedsParameter*)parameter getDict];
//        case kRequestTypeDeleteFeeds:
//            return [(DeleteFeedsParameter*)parameter getDict];
//        case kRequestTypeGetEventClassList:
//            return [(EventClassListParameter*)parameter getDict];
//            //message
//        case kRequestTypeGetBackupUrl:
//            return [(BackupUrlParameter*)parameter getDict];
//        case kRequestTypeCompleteBackup:
//            return [(CompleteBackupParameter*)parameter getDict];
//        case kRequestTypeGetResumeUrl:
//            return [(ResumeUrlParameter*)parameter getDict];
//        case kRequestTypeGetLinkInviteList:
//            return [(LinkInviteListParameter*)parameter getDict];
//        case kRequestTypeGetLinkSearchList:
//            return [(LinkSearchListParameter*)parameter getDict];
//            //link
//        case kRequestTypeGetConfig:
//            return [(ConfigParameter*)parameter getDict];
//        case kRequestTypeGetSourceInfo:
//            return [(SourceInfoParameter*)parameter getDict];
//        case kRequestTypeSetErrorInfo:
//            return [(SetErrorInfoParameter*)parameter getDict];
//        case kRequestTypeFeedback:
//            return [(FeedBackParameter*)parameter getDict];
//        case kRequestTypeReport:
//            return [(ReportParameter*)parameter getDict];
//        case kRequestTypeCompleteShare:
//            return [(CompleteShareParameter*)parameter getDict];
//        case kRequestTypeSendCaptcha:
//            return [(SendCaptchaParameter*)parameter getDict];
//        case kRequestTypeCheckCaptcha:
//            return [(CheckCaptchaParameter*)parameter getDict];
//        case kRequestTypeSetDeviceToken:
//            return [(SetDeviceTokenParameter*)parameter getDict];
//            //system
//        case kRequestTypeGetSNSInviteList:
//            return [(SNSInviteListParameter*)parameter getDict];
//        case kRequestTypeGetSNSSearchList:
//            return [(SNSSearchListParameter*)parameter getDict];
//        case kRequestTypeGetSinaAuthinfoByUid:
//            return [(GetSNSAuthinfoUidParameter*)parameter getDict];
//        case kRequestTypeBindSinaUserByUid:
//            return [(BindSNSUserUidParameter*)parameter getDict];
//        case kRequestTypeGetSinaAuthinfo:
//            return [(GetSNSAuthinfoParameter*)parameter getDict];
//        case kRequestTypeBindSinaUser:
//            return [(BindSNSUserParameter*)parameter getDict];
//        case kRequestTypeBindSinaOldUser:
//            return [(BindSNSOldUserParameter*)parameter getDict];
//        case kRequestTypeBindSinaNewUser:
//            return [(BindSNSNewUserParameter*)parameter getDict];
//        case kRequestTypeUnbindSinaUser:
//            return [(UnBindSNSUserParameter*)parameter getDict];
//        case kRequestTypeGetQQAuthinfoByUid:
//            return [(GetSNSAuthinfoUidParameter*)parameter getDict];
//        case kRequestTypeBindQQUserByUid:
//            return [(BindSNSUserUidParameter*)parameter getDict];
//        case kRequestTypeGetQQAuthinfo:
//            return [(GetSNSAuthinfoParameter*)parameter getDict];
//        case kRequestTypeBindQQUser:
//            return [(BindSNSUserParameter*)parameter getDict];
//        case kRequestTypeBindQQOldUser:
//            return [(BindSNSOldUserParameter*)parameter getDict];
//        case kRequestTypeBindQQNewUser:
//            return [(BindSNSNewUserParameter*)parameter getDict];
//        case kRequestTypeUnbindQQUser:
//            return [(UnBindSNSUserParameter*)parameter getDict];
//        case kRequestTypeGetTencentAuthinfoByUid:
//            return [(GetSNSAuthinfoUidParameter*)parameter getDict];
//        case kRequestTypeBindTencentUserByUid:
//            return [(BindSNSUserUidParameter*)parameter getDict];
//        case kRequestTypeGetTencentAuthinfo:
//            return [(GetSNSAuthinfoParameter*)parameter getDict];
//        case kRequestTypeBindTencentUser:
//            return [(BindSNSUserParameter*)parameter getDict];
//        case kRequestTypeBindTencentOldUser:
//            return [(BindSNSOldUserParameter*)parameter getDict];
//        case kRequestTypeBindTencentNewUser:
//            return [(BindSNSNewUserParameter*)parameter getDict];
//        case kRequestTypeUnbindTencentUser:
//            return [(UnBindSNSUserParameter*)parameter getDict];
//            //SNS
//        case kRequestTypeQSearchNS:
//            return [(QSearchNSParameter*)parameter getDict];
//        default:
//            break;
//    }
//    return nil;
//}

#pragma mark - Delegates
-(void)addDelegate:(id<RequestManagerDelegate>)delegate
{
    if(delegate==nil)
        return;
    if([delegateQueue_ containsObject:delegate])
        return;
    [delegateQueue_ removeAllObjects];
    [delegateQueue_ addObject:delegate];
//    if(isLockDelegateQueue_)
//    {
//        DelegateHandler *handler=[[DelegateHandler alloc] initWithDelegate:delegate shouldAdd:YES];
//        [delegateHandlers_ addObject:handler];
//        [handler release];
//    }
//    else
//        [delegateQueue_ addObject:delegate];
}

-(void)removeDelegate:(id)delegate
{
    if(delegate==nil)
        return;
    if(isLockDelegateQueue_)
    {
        DelegateHandler *handler=[[DelegateHandler alloc] initWithDelegate:delegate shouldAdd:NO];
        [delegateHandlers_ addObject:handler];
        [handler release];
    }
    else
        [delegateQueue_ removeObject:delegate];
}

-(void)handleDelegates
{
    for(DelegateHandler *handler in delegateHandlers_)
    {
        if(handler.delegate)
        {
            if(handler.shouldAdd)
            {
                if(![delegateQueue_ containsObject:handler.delegate])
                    [delegateQueue_ addObject:handler.delegate];
            }
            else
                [delegateQueue_ removeObject:handler.delegate];
        }
    }
    [delegateHandlers_ removeAllObjects];
}

#pragma mark - Network Reachability
-(NetworkStatus)currentReachabilityStatus
{
    return [reachability_ currentReachabilityStatus];
}

-(void)reachabilityChanged:(NSNotification* )notif
{
    Reachability* curReach = [notif object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus status=[curReach currentReachabilityStatus];
    
    if(status == NotReachable)
    {
        
    }
    else if(status == ReachableViaWiFi)
    {
        
    }
    else if(status == ReachableViaWWAN)
    {
        
    }
    
    [self callbackDelegate:kRequestTypeNetworkChanged object:[NSNumber numberWithInt:status] originalData:nil];
}

#pragma mark - Callback Delegate
-(void)callbackDelegate:(RequestType)requestType object:(id)object originalData:(id)data
{
    [self callbackDelegate:requestType response:object userData:nil originalData:data];
}

-(void)callbackDelegate:(RequestType)requestType response:(id)response userData:(id)userData originalData:(id)data
{
    [callbackLock_ lock];
    
    isLockDelegateQueue_=YES;
    for(id delegate in delegateQueue_)
    {
        if (requestType == kRequestTypeNetworkChanged) {
            if([delegate respondsToSelector:@selector(networkStatusChanged:)])
                [delegate networkStatusChanged:(NetworkStatus)[(NSNumber*)response intValue]];
        }
        else if (requestType>=kRequestTypeWSMin&&requestType<=kRequestTypeWSMax)
        {
            if([response isKindOfClass:[NSError class]])
            {
                if([delegate respondsToSelector:@selector(webServiceRequest:error:userData:)])
                    [delegate webServiceRequest:requestType error:response userData:userData];
            }
            else
            {
                if ([response isKindOfClass:[NSDictionary class]]) {
                    if ([(NSDictionary*)response objectForKey:@"status"] != nil) {
                        if ([[(NSDictionary*)response objectForKey:@"status"]integerValue] < 1) {
                            NSString *errorData = [[[AnalyticalError getErrorInfo:[(NSDictionary*)response objectForKey:@"status"] responseData:response]retain]autorelease];
                            if ([delegate respondsToSelector:@selector(webServiceRequest:errorString:userData:)]) {
                                [delegate webServiceRequest:requestType errorString:errorData userData:userData];
                            }
                            if ([delegate respondsToSelector:@selector(webServiceRequest:errorData:userData:)]) {
                                [delegate webServiceRequest:requestType errorData:response userData:userData];
                            }
                        }
                    }
                    else
                    {
                        if([delegate respondsToSelector:@selector(webServiceRequest:response:userData:originalData:)])
                            [delegate webServiceRequest:requestType response:response userData:userData originalData:data];
                    }
                }
                else
                {
                    if([delegate respondsToSelector:@selector(webServiceRequest:response:userData:originalData:)])
                        [delegate webServiceRequest:requestType response:response userData:userData originalData:data];
                }
            }
        }
    }
    [self handleDelegates];
    isLockDelegateQueue_=NO;
    
    [callbackLock_ unlock];
}

#pragma mark - WebService Delegate
-(void)webService:(WebService*)webService requestType:(RequestType)requestType didFinish:(id)response userData:(id)userData originalData:(id)data
{
    [self callbackDelegate:requestType response:response userData:userData originalData:data];
}

-(void)webService:(WebService*)webService requestType:(RequestType)requestType didFail:(NSError*)error userData:(id)userData
{
    [self callbackDelegate:requestType response:error userData:userData originalData:nil];
}

-(void)webService:(WebService *)webService requestType:(RequestType)requestType didFinishWithError:(id)errorData userData:(id)userData
{
    if ([errorData isKindOfClass:[NSDictionary class]]) {
        if ([[(NSDictionary*)errorData objectForKey:@"status"]integerValue] < 1) {
            NSString *error = [[[AnalyticalError getErrorInfo:[(NSDictionary*)errorData objectForKey:@"status"] responseData:errorData]retain]autorelease];
            if ([error integerValue] == -109) {
//                [self autoLoginWithToken:YES];
            }
        }
    }
    [self callbackDelegate:requestType response:errorData userData:userData originalData:nil];
}


#pragma mark - AlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001) {
        
    }
    else if(alertView.tag == 990)
    {
        
    }
    else if(alertView.tag == 2000)
    {
        
    }
}
@end
