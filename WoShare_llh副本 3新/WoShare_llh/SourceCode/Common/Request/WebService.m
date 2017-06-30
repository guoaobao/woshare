//
//  WebService.m
//  QYSDK
//
//  Created by 胡 波 on 13-4-3.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "WebService.h"
#import "HttpRequest.h"
#import "JSONKit.h"
#import "DataSource.h"
#import "URLDefine.h"
#import "BaseResponse.h"
#import "DiskFileListResponse.h"
#import "FavouriteResponse.h"
#import "FavouriteListResponse.h"
#import "EventFileListResponse.h"
#import "NSResponse.h"
#import "CommentResponse.h"
#import "MessageResponse.h"
#import "FeedResponse.h"
#import "EventClassResponse.h"
#import "AppConfig.h"
#import "ResourceInfo.h"
#import "CollectResourceInfo.h"
#import "InfoListResponse.h"
#import "AppConfig.h"
#import "MsgListResponse.h"

@interface WebService (Private)<HTTPRequestDelegate>

@end

@implementation WebService
@synthesize delegate=delegate_;
@synthesize userInfo=userInfo_;
@synthesize isLogined=isLogined_;
-(id)initWithDelegate:(id<WebServiceDelegate>)delegate
{
    if((self=[super init]))
    {
        delegate_=delegate;
        requestQueue_=[[NSMutableArray alloc] initWithCapacity:0];
        userInfo_ = [[UserInfoResponse alloc]init];
        json_ = [[JSONDecoder alloc]init];
    }
    return self;
}

-(void)dealloc
{
    for (id obj in requestQueue_) {
        if ([obj isKindOfClass:[HTTPRequest class]]) {
            HTTPRequest *temp = (HTTPRequest *)obj;
            temp.delegate = nil;
        }
    }
    if (userInfo_) {
        [userInfo_ release];
        userInfo_ = nil;
    }
    [json_ release];
    [requestQueue_ release];
    [cookies_ release];
    [super dealloc];
}

#pragma mark - API
-(void)startWithRequestType:(RequestType)type withData:(NSDictionary*)dic withCachePara:(CacheObject*)cache
{
    NSArray         *file = [dic objectForKey:@"fileData"];
    NSDictionary    *para = [dic objectForKey:@"parameter"];
    if (file == nil) {
        para = dic;
    }
    
    if (type == kRequestTypeGetPhoneNumber) {
        [self sendGetRequest:type parameters:dic];
        return;
    }
    
    if (cache == nil) {
        [self startWithRequestType:type withData:dic];
    }
    else
    {
        NSString *fileName = [self getFileNameMD5Encode:para];
        NSString *folder = FVGetJsonCachePathWithRequestType(type);
        if (folder) {
            NSString *path = [folder stringByAppendingPathComponent:fileName];
//            FVLog(@"\n cache file path : %@",path);
            if([[NSFileManager defaultManager] fileExistsAtPath:path])
            {
                NSDictionary *JsonDic = [NSDictionary dictionaryWithContentsOfFile:path];
                BOOL outTime = [self isOutTime:(NSDate*)[JsonDic objectForKey:@"savedate"] withoutTime:cache.expirationDate];
                if (JsonDic) {
                    if (!outTime) {
                        if (!cache.needRefresh) {
                            FVLog(@"return cache");
                            NSString*str = [JsonDic objectForKey:@"jsondic"];
                            double delayInSeconds = 0.3;
                            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                                // code to be executed on the main queue after delay
                                [self parseResult:[str objectFromJSONString] withRequestType:type withUserData:dic];
                            });
                            
                        }
                        else
                        {
                            FVLog(@"cache need refresh");
                            [self startWithRequestType:type withData:dic withCache:[NSDictionary dictionaryWithObjectsAndKeys:cache,@"cacheobject",path,@"path", nil]];
                        }
                    }
                    else
                    {
                        FVLog(@"cache out time");
                        [self startWithRequestType:type withData:dic withCache:[NSDictionary dictionaryWithObjectsAndKeys:cache,@"cacheobject",path,@"path", nil]];
                    }
                }
                else
                {
                    FVLog(@"cache error with code 0101");
                    [self startWithRequestType:type withData:dic withCache:[NSDictionary dictionaryWithObjectsAndKeys:cache,@"cacheobject",path,@"path", nil]];
                }
            }
            else
            {
                FVLog(@"cache doing");
                [self startWithRequestType:type withData:dic withCache:[NSDictionary dictionaryWithObjectsAndKeys:cache,@"cacheobject",path,@"path", nil]];
            }
        }
        else
        {
            FVLog(@"cache error with code 0100");
            [self startWithRequestType:type withData:dic];
        }
    }
}

-(NSString*)getFileNameMD5Encode:(NSDictionary*)dic
{
    NSString *result = [dic JSONString];
    return [NSString stringwithMd5Encode:result];
}

-(BOOL)isOutTime:(NSDate*)saveDate withoutTime:(double)secs
{
    double interval= [saveDate timeIntervalSinceNow];
    if (-interval > secs) {
        return YES;
    }
    else
        return NO;
}

-(void)startWithRequestType:(RequestType)type withData:(NSDictionary*)dic
{
    [self startWithRequestType:type withData:dic withCache:nil];
}

-(void)startWithRequestType:(RequestType)type withData:(NSDictionary *)dic withCache:(NSDictionary*)cache
{
    NSArray         *file = [dic objectForKey:@"fileData"];
    NSDictionary    *para = [dic objectForKey:@"parameter"];
    
    if (file == nil) {
        [self sendRequest:type parameters:dic userData:dic withCache:cache];
    }
    else
    {
        [self sendRequest:type parameters:para fileData:file userData:dic withCache:cache];
    }
}

-(void)logout
{
    if (userInfo_) {
        [userInfo_ release];
        userInfo_ = nil;
        userInfo_ = [[UserInfoResponse alloc]init];
    }
    isLogined_ = NO;
    [DataSource sharedDataSource].appSetting.isLogined = NO;
}


#pragma mark - URL

-(NSString*)getUrlWithRequestType:(RequestType)_type
{
    switch (_type) {
        case kRequestTypeGetUpload:
            return [self getCompleteURL:GetUploadURL];
        case kRequestTypeCompleteUpLoad:
            return [self getCompleteURL:CompleteUpLoadURL];
        case kRequestTypeGetDiskList:
            return [self getCompleteURL:GetDiskListURL];
        case kRequestTypeGetRecentUploadList:
            return [self getCompleteURL:GetRecentUploadListURL];
        case kRequestTypeSearchNs:
            return [self getCompleteURL:SearchNsURL];
        case kRequestTypeCreateFolder:
            return [self getCompleteURL:CreateFolderURL];
        case kRequestTypeMoveFile:
            return [self getCompleteURL:MoveFileURL];
        case kRequestTypeRenameFile:
            return [self getCompleteURL:RenameFileURL];
        case kRequestTypeDelFile:
            return [self getCompleteURL:DelFileURL];
        case kRequestTypeRestoreFile:
            return [self getCompleteURL:RestoreFileURL];
        case kRequestTypeGetDownloadURL:
            return [self getCompleteURL:GetDownloadURL];
        case kRequestTypeGetNameSpaceInfo:
            return [self getCompleteURL:GetNameSpaceInfoURL];
        case kRequestTypeSetFolderInfo:
            return [self getCompleteURL:SetFolderInfoURL];
        case kRequestTypeLikens:
            return [self getCompleteURL:LikensURL];
        case kRequestTypeClickns:
            return [self getCompleteURL:ClicknsURL];
        case kRequestTypeGetSpaceStatInfo:
            return [self getCompleteURL:GetSpaceStatInfoURL];
        case kRequestTypeSetFileInfo:
            return [self getCompleteURL:SetFileInfoURL];
        case kRequestTypeGetNSList:
            return [self getCompleteURL:GetNSList];
            //disk
        case kRequestTypeGetAppCategory:
            return [self getCompleteURL:GetAppCategoryURL];
        case kRequestTypeGetTopCategory:
            return [self getCompleteURL:GetTopCategoryURL];
        case kRequestTypeGetChildrenBlock:
            return [self getCompleteURL:GetChildrenBlockURL];
        case kRequestTypeGetBlockFileList:
            return [self getCompleteURL:GetBlockFileListURL];
        case kRequestTypeGetBlockUserList:
            return [self getCompleteURL:GetBlockUserListURL];
        case kRequestTypeGetScheduleList:
            return [self getCompleteURL:GetSchedulelistURL];
        case kRequestTypeGetHotWordsList:
            return [self getCompleteURL:GetHotWordsListURL];
        case kRequestTypeGetPrizeList:
            return [self getCompleteURL:GetPrizeListURL];
        case kRequestTypePrize:
            return [self getCompleteURL:PrizeURL];
        case kRequestTypeGetSuperEyeList:
            return [self getCompleteURL:GetSuperEyeListURL];
        case kRequestTypeGetPicDataList:
            return [self getCompleteURL:GetPicDataListURL];
            //app
        case kRequestTypeRegister:
            return [self getNewCompleteURL:RegisterURL];
        case kRequestTypeLogin:
            return [self getNewCompleteURL:LoginURL];
        case kRequestTypeLogout:
            return [self getCompleteURL:LogoutURL];
        case kRequestTypeModifyPassword:
            return [self getNewCompleteURL:ModifyPasswordURL];
        case kRequestTypeModifyUserName:
            return [self getCompleteURL:ModifyUserNameURL];
        case kRequestTypeModifyAvatar:
            return [self getCompleteURL:ModifyAvatarURL];
        case kRequestTypeModifyBackground:
            return [self getCompleteURL:ModifyBackgroundURL];
        case kRequestTypeSearchUser:
            return [self getCompleteURL:SearchUserURL];
        case kRequestTypeGetHotUserList:
            return [self getCompleteURL:GetHotUserListURL];
        case kRequestTypeGetPersonageList:
            return [self getCompleteURL:GetPersonAgeListURL];
        case kRequestTypeBindMobile:
            return [self getCompleteURL:BindMobileURL];
        case kRequestTypeUnbindMobile:
            return [self getCompleteURL:UnbindMobileURL];
        case kRequestTypeAutoLogin:
            return [self getNewCompleteURL:AutoLoginURL];
        case kRequestTypeLoginByMobile:
            return [self getCompleteURL:MobileNumberLoginURL];
        case kRequestTypeGetHobby:
            return [self getCompleteURL:GetHobbyURL];
        case kRequestTypeModifyPasswordForgot:
            return [self getNewCompleteURL:ModifyPasswordForgotURL];
        case kRequestTypeCheckMobile:
            return [self getCompleteURL:CheckUnicomMobileURL];
        case kRequestTypeFindPassWord:
            return [self getNewCompleteURL:FindUserPassWord];
            //user
        case kRequestTypeNote:
            return [self getCompleteURL:NoteURL];
        case kRequestTypeGetNoteList:
            return [self getCompleteURL:GetNoteListURL];
        case kRequestTypeGetNoteUids:
            return [self getCompleteURL:GetNoteUidsURL];
            //note
        case kRequestTypeGetFavoriteList:
            return [self getCompleteURL:GetFavoriteListURL];
        case kRequestTypeAddClass:
            return [self getCompleteURL:AddClassURL];
        case kRequestTypeAddFavorite:
            return [self getNewCompleteURL:AddFavoriteURL];
        case kRequestTypeDelFavorite:
            return [self getNewCompleteURL:DelFavoriteURL];
            //favourite
        case kRequestTypeGetCommentList:
            return [self getCompleteURL:GetCommentListURL];
        case kRequestTypeAddComment:
            return [self getCompleteURL:AddCommentURL];
        case kRequestTypeDelComment:
            return [self getCompleteURL:DelCommentURL];
            //comment
        case kRequestTypeGetEventList:
            return [self getCompleteURL:GetEventListURL];
        case kRequestTypeGetEventInfo:
            return [self getCompleteURL:GetEventInfoURL];
        case kRequestTypeGetEventFileList:
            return [self getCompleteURL:GetEventFileListURL];
        case kRequestTypeGetEventUserList:
            return [self getCompleteURL:GetEventUserListURL];
        case kRequestTypeGetJoinedEventList:
            return [self getCompleteURL:GetJoinedEventListURL];
        case kRequestTypeVote:
            return [self getCompleteURL:VoteURL];
        case kRequestTypeApplyGuests:
            return [self getCompleteURL:ApplyGuestsURL];
        case kRequestTypeGetEventWinnerList:
            return [self getCompleteURL:GetEventWinnerListURL];
            //event
        case kRequestTypeGetUsermsgList:
            return [self getCompleteURL:GetUsermsglistURL];
        case kRequestTypeCompleteRead:
            return [self getCompleteURL:CompleteReadURL];
        case kRequestTypeDeleteUsermsg:
            return [self getCompleteURL:DeleteUsermsgURL];
        case kRequestTypeSetReceivemsg:
            return [self getCompleteURL:SetReceivemsgURL];
        case kRequestTypeSendmsg:
            return [self getCompleteURL:SendmsgURL];
        case kRequestTypeGetFeedsList:
            return [self getCompleteURL:GetFeedsListURL];
        case kRequestTypeCompleteReadFeeds:
            return [self getCompleteURL:CompleteReadFeedsURL];
        case kRequestTypeDeleteFeeds:
            return [self getCompleteURL:DeleteFeedsURL];
        case kRequestTypeGetEventClassList:
            return [self getCompleteURL:GetEventClassListURL];
        case kRequestTypeGetMyMsgList:
            return [self getCompleteURL:GetmymsglistURL];
            //message
        case kRequestTypeGetBackupUrl:
            return [self getCompleteURL:GetBackupURL];
        case kRequestTypeCompleteBackup:
            return [self getCompleteURL:CompleteBackupURL];
        case kRequestTypeGetResumeUrl:
            return [self getCompleteURL:GetResumeURL];
        case kRequestTypeGetLinkInviteList:
            return [self getCompleteURL:GetLinkInviteListURL];
        case kRequestTypeGetLinkSearchList:
            return [self getCompleteURL:GetLinkSearchListURL];
            //link
        case kRequestTypeGetConfig:
            return [self getCompleteURL:GetConfigURL];
        case kRequestTypeGetSourceInfo:
            return [self getCompleteURL:GetSourceInfoURL];
        case kRequestTypeSetErrorInfo:
            return [self getCompleteURL:SetErrorInfoURL];
        case kRequestTypeFeedback:
            return [self getCompleteURL:FeedBackURL];
        case kRequestTypeReport:
            return [self getCompleteURL:ReportURL];
        case kRequestTypeCompleteShare:
            return [self getCompleteURL:CompleteShareURL];
        case kRequestTypeSendCaptcha:
            return [self getNewCompleteURL:SendCaptchaURL];
        case kRequestTypeCheckCaptcha:
            return [self getCompleteURL:CheckCaptchaURL];
        case kRequestTypeSetDeviceToken:
            return [self getCompleteURL:SetDeviceTokenURL];
        case kRequestTypeSendCaptchaEmail:
            return [self getCompleteURL:SendCaptchaEmailURL];
            //system
        case kRequestTypeGetSNSInviteList:
            return [self getCompleteURL:GetSNSInviteListURL];
        case kRequestTypeGetSNSSearchList:
            return [self getCompleteURL:GetSNSSearchListURL];
        case kRequestTypeGetSinaAuthinfoByUid:
            return [self getCompleteURL:GetSinaAuthInfoByUidURL];
        case kRequestTypeBindSinaUserByUid:
            return [self getCompleteURL:BindSinaUserByUidURL];
        case kRequestTypeGetSinaAuthinfo:
            return [self getCompleteURL:GetSinaAuthInfoURL];
        case kRequestTypeBindSinaUser:
            return [self getCompleteURL:BindSinaUserURL];
        case kRequestTypeBindSinaOldUser:
            return [self getCompleteURL:BindSinaOldUserURL];
        case kRequestTypeBindSinaNewUser:
            return [self getCompleteURL:BindSinaNewUserURL];
        case kRequestTypeUnbindSinaUser:
            return [self getCompleteURL:UnbindSinaUserURL];
        case kRequestTypeGetQQAuthinfoByUid:
            return [self getCompleteURL:GetQQAuthInfoByUidURL];
        case kRequestTypeBindQQUserByUid:
            return [self getCompleteURL:BindQQUserByUidURL];
        case kRequestTypeGetQQAuthinfo:
            return [self getCompleteURL:GetQQAuthInfoURL];
        case kRequestTypeBindQQUser:
            return [self getCompleteURL:BindQQUserURL];
        case kRequestTypeBindQQOldUser:
            return [self getCompleteURL:BindQQOldUserURL];
        case kRequestTypeBindQQNewUser:
            return [self getCompleteURL:BindQQNewUserURL];
        case kRequestTypeUnbindQQUser:
            return [self getCompleteURL:UnbindQQUserURL];
        case kRequestTypeGetTencentAuthinfoByUid:
            return [self getCompleteURL:GetTencentAuthInfoByUidURL];
        case kRequestTypeBindTencentUserByUid:
            return [self getCompleteURL:BindTencentUserByUidURL];
        case kRequestTypeGetTencentAuthinfo:
            return [self getCompleteURL:GetTencentAuthInfoURL];
        case kRequestTypeBindTencentUser:
            return [self getCompleteURL:BindTencentUserURL];
        case kRequestTypeBindTencentOldUser:
            return [self getCompleteURL:BindTencentOldUserURL];
        case kRequestTypeBindTencentNewUser:
            return [self getCompleteURL:BindTencentNewUserURL];
        case kRequestTypeUnbindTencentUser:
            return [self getCompleteURL:UnbindTencentUserURL];
        case kRequestTypeCompleteInvite:
            return [self getCompleteURL:CompleteInviteURL];
        case kRequestTypeSendSms:
            return [self getCompleteURL:SendSmsURL];
            //SNS
        case kRequestTypeQSearchNS:
            return [self getCompleteURL:QSearchNSURL];
        case kRequestTypeQSearchinfo:
            return [self getNewCompleteURL:QSearchinfoURL];
        case kRequestTypeGetInfoInfo:
            return [self getCompleteURL:GetInfoInfoURL];
        case kRequestTypeGetInfonsList:
            return [self getCompleteURL:GetInfonsListURL];
        case kRequestTypeClickInfo:
            return [self getCompleteURL:ClickInfoURL];
        case kRequestTypeLikeInfo:
            return [self getNewCompleteURL:LikeInfoURL];
        case kRequestTypeSearchInfo:
            return [self getCompleteURL:SearchInfoURL];
        case kRequestTypeAddInfo:
            return [self getNewCompleteURL:AddInfoURL];
        case kRequestTypeDeleteInfo:
            return [self getCompleteURL:DeleteInfoURL];
        case kRequestTypeGetProductList:
            return [self getCompleteURL:GetProductListURL];
        case kRequestTypeOrderProduct:
            return [self getCompleteURL:OrderProductURL];
        case kRequestTypeGetInfoList:
            return [self getCompleteURL:GetInfoList];
        case kRequestTypeGetLikeInfoList:
            return [self getCompleteURL:GetLikeInfoListURL];
        case kRequestTypeJoinEvent:
            return [self getCompleteURL:JoinEventURL];
        case kRequestTypeGetCredit:
            return [self getCompleteURL:GetCreditURL];
        case kRequestTypeSetPageVisitLog:
            return [self getCompleteURL:SetPageVisitLogURL];
        case kRequestTypeGetCollectInfoList:
            return [self getCompleteURL:GetFavoriteUserListURL];
        default:
            break;
    }
    return nil;
}

-(NSString*)getCompleteURL:(NSString*)url
{
    NSString *aToken = [userInfo_.token length]==0?@"":userInfo_.token;
    return [NSString stringWithFormat:@"%@%@%@",BaseAppURL,url,aToken];
}

- (NSString *)getNewCompleteURL:(NSString *)url
{
    NSString *aToken = [userInfo_.token length]==0?@"":userInfo_.token;
    return [NSString stringWithFormat:@"%@%@%@",NewBaseAppURL,url,aToken];
}

-(NSString*)urlString:(NSDictionary*)parameters
{
    NSMutableString *s=[NSMutableString stringWithString:kAnxunMobileURL];
    [s appendString:@"?"];
    NSArray *allKeys=[parameters allKeys];
    for(NSString *key in allKeys)
    {
        NSInteger index=[allKeys indexOfObject:key];
        if(index==0)
            [s appendFormat:@"%@=%@",key,[parameters objectForKey:key]];
        else
            [s appendFormat:@"&%@=%@",key,[parameters objectForKey:key]];
    }
    return [NSString stringWithString:s];
}

#pragma mark - SendRequest
-(void)sendRequest:(RequestType)requestType parameters:(NSDictionary*)parameters  userData:(id)userData withCache:(NSDictionary*)cache
{
    [self sendRequest:requestType parameters:parameters fileData:nil userData:userData withCache:cache];
}

-(void)sendRequest:(RequestType)requestType parameters:(NSDictionary *)parameters fileData:(NSArray*)fileData userData:(id)userData withCache:(NSDictionary*)cache
{
    HTTPRequest *request=[[HTTPRequest alloc] initWithRequestType:requestType];
    request.userData=userData;
    request.parameters=parameters;
    request.fileData=fileData;
    request.delegate=self;
    request.nameString = [cache objectForKey:@"path"];
    request.cacheObject = [cache objectForKey:@"cacheobject"];
    [requestQueue_ addObject:request];
    [request startWithUrl:[self getUrlWithRequestType:requestType]];
    [request release];
}

-(void)sendGetRequest:(RequestType)requestType parameters:(NSDictionary *)parameters
{
    HTTPRequest *request=[[HTTPRequest alloc] initWithRequestType:requestType];
    request.delegate=self;
    [requestQueue_ addObject:request];
    [request startGetWithUrl:[self urlString:parameters]];
    [request release];
}

#pragma mark - HTTPRequest Delegate
-(void)httpRequest:(HTTPRequest*)request didFinish:(id)result
{
    id userData         = [[[request userData] retain]autorelease];
    if (request.requestType == kRequestTypeGetPhoneNumber) {
        NSDictionary *dic = [result retain];
        NSInteger resultcode = [[dic objectForKey:@"resultcode"] integerValue];
        switch (resultcode) {
            case 0:
            {
                NSString *phonenumber = [NSString decodeDES:[dic objectForKey:@"mobkey"]];
                if (delegate_ && [delegate_ respondsToSelector:@selector(webService:requestType:didFinish:userData:originalData:)]) {
                    [delegate_ webService:self requestType:request.requestType didFinish:phonenumber userData:userData originalData:result];
                }
            }break;
            default:
            {
                if (delegate_&&[delegate_ respondsToSelector:@selector(webService:requestType:didFinishWithError:userData:)]) {
                    [delegate_ webService:self requestType:request.requestType didFinishWithError:dic userData:userData];
                }
            }break;
        }
    }
    else
        [self parseResult:result withRequestType:request.requestType withUserData:userData];
    [requestQueue_ removeObject:request];
}

-(void)httpRequest:(HTTPRequest *)request didReceiveCookie:(NSString*)cookie
{
    [cookies_ release];
    cookies_=[cookie retain];
}

-(void)httpRequest:(HTTPRequest*)request didFail:(NSError*)error
{
    id userData=[[[request userData] retain] autorelease];
    NSString *path = [[[request nameString]retain]autorelease];
    if([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        NSDictionary *JsonDic = [NSDictionary dictionaryWithContentsOfFile:path];
        if (JsonDic) {
            NSString*str = [JsonDic objectForKey:@"jsondic"];
            [self parseResult:[str objectFromJSONString] withRequestType:request.requestType withUserData:userData];
        }
    }
    else
    {
        if(delegate_&&[delegate_ respondsToSelector:@selector(webService:requestType:didFail:userData:)])
            [delegate_ webService:self requestType:request.requestType didFail:error userData:userData];
    }
    [requestQueue_ removeObject:request];
}

-(void)parseResult:(id)result withRequestType:(RequestType)requestType withUserData:(id)userData
{
    id response         = nil;
    NSDictionary *dic   = nil;
    if ([result isKindOfClass:[NSDictionary class]]) {
        dic = [[result retain]autorelease];
    }
    else
    {
        if (delegate_ && [delegate_ respondsToSelector:@selector(webService:requestType:didFinish:userData:originalData:)]) {
            [delegate_ webService:self requestType:requestType didFinish:result userData:userData originalData:result];
        }
        return;
    }
    NSString *status    = [dic objectForKey:@"status"];
    id data             = [dic objectForKey:@"data"];
    if([status integerValue] < 1)
    {
        if (delegate_&&[delegate_ respondsToSelector:@selector(webService:requestType:didFinishWithError:userData:)]) {
            [delegate_ webService:self requestType:requestType didFinishWithError:dic userData:userData];
        }
    }
    else
    {
        if (requestType == kRequestTypeModifyPassword) {
            if (delegate_ && [delegate_ respondsToSelector:@selector(webService:requestType:didFinish:userData:originalData:)]) {
                [delegate_ webService:self requestType:requestType didFinish:status userData:userData originalData:result];
            }
        }
        if ([data isKindOfClass:[NSDictionary class]])
        {
            if (requestType == kRequestTypeLogin||
                requestType==kRequestTypeAutoLogin ||
                requestType == kRequestTypeLoginByMobile||
                requestType == kRequestTypeCheckMobile) {
                if (userInfo_) {
                    [userInfo_ release];
                    userInfo_ = nil;
                }
                userInfo_ = [[UserInfoResponse alloc]initWithDict:data withRequestType:requestType];
                isLogined_ = YES;
                if (![userInfo_.token isEqualToString:[DataSource sharedDataSource].account.token]) {
                    [DataSource sharedDataSource].account.token = userInfo_.token;
                }
                [DataSource sharedDataSource].appSetting.isLogined = YES;
                [DataSource sharedDataSource].account.username = userInfo_.username;
                [DataSource sharedDataSource].account.password = userInfo_.password;
                [Config setLocToken:userInfo_.token];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogin object:nil];

                
                if (delegate_ &&[delegate_ respondsToSelector:@selector(webService:requestType:didFinish:userData:originalData:)]) {
                    [delegate_ webService:self requestType:requestType didFinish:userInfo_ userData:userData originalData:result];
                }
            }
            else if (requestType==kRequestTypeBindSinaUser||
                     requestType==kRequestTypeBindSinaOldUser||
                     requestType==kRequestTypeBindSinaNewUser||
                     requestType==kRequestTypeBindQQUser||
                     requestType==kRequestTypeBindQQOldUser||
                     requestType==kRequestTypeBindQQNewUser||
                     requestType==kRequestTypeBindTencentUser||
                     requestType==kRequestTypeBindTencentOldUser||
                     requestType==kRequestTypeBindTencentNewUser||
                     requestType==kRequestTypeGetSinaAuthinfo||
                     requestType==kRequestTypeGetSinaAuthinfoByUid||
                     requestType==kRequestTypeGetQQAuthinfo||
                     requestType==kRequestTypeGetQQAuthinfoByUid||
                     requestType==kRequestTypeGetTencentAuthinfo||
                     requestType==kRequestTypeGetTencentAuthinfoByUid)
            {
                BOOL autoLogin = [[userData objectForKey:@"autologin"]intValue];
                if (autoLogin) {
                    if (userInfo_) {
                        [userInfo_ release];
                        userInfo_ = nil;
                    }
                    userInfo_ = [[UserInfoResponse alloc]initWithDict:data withRequestType:requestType];
                    isLogined_ = YES;
                    if (![userInfo_.token isEqualToString:[DataSource sharedDataSource].account.token]) {
                        [DataSource sharedDataSource].account.token = userInfo_.token;
                    }
                    [DataSource sharedDataSource].appSetting.isLogined = YES;
                    [DataSource sharedDataSource].account.username = userInfo_.username;
                    [DataSource sharedDataSource].account.password = userInfo_.password;
                    [Config setLocToken:userInfo_.token];
                    if (delegate_ &&[delegate_ respondsToSelector:@selector(webService:requestType:didFinish:userData:originalData:)]) {
                        [delegate_ webService:self requestType:requestType didFinish:userInfo_ userData:userData originalData:result];
                    }
                }
                else
                {
                    if (delegate_ &&[delegate_ respondsToSelector:@selector(webService:requestType:didFinish:userData:originalData:)]) {
                        [delegate_ webService:self requestType:requestType didFinish:data userData:userData originalData:result];
                    }
                }
            }
            else if (requestType == kRequestTypeGetLikeInfoList)
            {
                NSDictionary *dict = [data objectForKey:@"userinfolist"];
                if (![dict isKindOfClass:[NSDictionary class]]) {
                    if (delegate_ &&[delegate_ respondsToSelector:@selector(webService:requestType:didFinish:userData:originalData:)]) {
                        [delegate_ webService:self requestType:requestType didFinish:[[[NSMutableArray alloc]initWithCapacity:0]autorelease] userData:userData originalData:result];
                        return;
                    }
                }
                NSArray *allKeys = [dict allKeys];
                NSMutableArray *retArray = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
                for (NSString *key in allKeys) {
                    UserInfoResponse *user = [[UserInfoResponse alloc]initWithDict:[dict objectForKey:key] withRequestType:requestType];
                    [retArray addObject:user];
                }
                if (delegate_ &&[delegate_ respondsToSelector:@selector(webService:requestType:didFinish:userData:originalData:)]) {
                    [delegate_ webService:self requestType:requestType didFinish:retArray userData:userData originalData:result];
                }
            }
            else if (requestType == kRequestTypeGetDiskList ||
                     requestType == kRequestTypeGetRecentUploadList||
                     requestType == kRequestTypeSearchNs||
                     requestType == kRequestTypeGetNameSpaceInfo ||
                     requestType == kRequestTypeGetBlockFileList||
                     requestType == kRequestTypeQSearchNS||
                     requestType == kRequestTypeGetInfonsList)
            {
                response = [self parseResourceList:data withType:requestType];
                if (delegate_ && [delegate_ respondsToSelector:@selector(webService:requestType:didFinish:userData:originalData:)]) {
                    [delegate_ webService:self requestType:requestType didFinish:response userData:userData originalData:result];
                }
            }
            else if (requestType == kRequestTypeGetFavoriteList)
            {
                if (delegate_ && [delegate_ respondsToSelector:@selector(webService:requestType:didFinish:userData:originalData:)]) {
                    response = [self parseCollectResourceList:data withType:requestType];
                    [delegate_ webService:self requestType:requestType didFinish:response userData:userData originalData:result];
                }
            }
            else if (requestType == kRequestTypeGetEventFileList)
            {
                if (delegate_ && [delegate_ respondsToSelector:@selector(webService:requestType:didFinish:userData:originalData:)]) {
                    response = [self analyticEventListWithDict:data withRequestType:requestType];
                    [delegate_ webService:self requestType:requestType didFinish:response userData:userData originalData:result];
                }
            }
            else if (requestType == kRequestTypeGetEventInfo)
            {
                response = [BaseResponse infoWithDict:data withRequestType:requestType];
                if (delegate_ && [delegate_ respondsToSelector:@selector(webService:requestType:didFinish:userData:originalData:)]) {
                    [delegate_ webService:self requestType:requestType didFinish:response userData:userData originalData:result];
                }
            }
            else if (requestType == kRequestTypeGetFeedsList||
                     requestType == kRequestTypeGetCommentList||
                     requestType == kRequestTypeGetUsermsgList||
                     requestType == kRequestTypeGetEventClassList)
            {
                NSArray *array = [self analyticWithDict:data withRequestType:requestType];
                if(delegate_ && [delegate_ respondsToSelector:@selector(webService:requestType:didFinish:userData:originalData:)])
                    [delegate_ webService:self requestType:requestType didFinish:([array count]>0?array:nil) userData:userData originalData:result];
            }
            else if (requestType == kRequestTypeQSearchinfo ||
                     requestType == kRequestTypeSearchInfo  )
            {
                if (delegate_ && [delegate_ respondsToSelector:@selector(webService:requestType:didFinish:userData:originalData:)]) {
                    [delegate_ webService:self requestType:requestType didFinish:[self parseInfoList:data withType:requestType] userData:userData originalData:result];
                }
            }
            else if (requestType == kRequestTypeGetInfoInfo)
            {
                response = [BaseResponse infoWithDict:[data objectForKey:@"infoinfo"] withRequestType:requestType];
                if (delegate_ && [delegate_ respondsToSelector:@selector(webService:requestType:didFinish:userData:originalData:)]) {
                    [delegate_ webService:self requestType:requestType didFinish:response userData:userData originalData:result];
                }
            }
            else if (requestType == kRequestTypeGetInfoList)
            {
                if (delegate_ && [delegate_ respondsToSelector:@selector(webService:requestType:didFinish:userData:originalData:)]) {
                    [delegate_ webService:self requestType:requestType didFinish:[self parseInfo:data withType:requestType] userData:userData originalData:result];
                }
            }
            else if (requestType == kRequestTypeGetNSList)
            {
                if (delegate_ && [delegate_ respondsToSelector:@selector(webService:requestType:didFinish:userData:originalData:)]) {
                    [delegate_ webService:self requestType:requestType didFinish:[self parseNS:data withType:requestType] userData:userData originalData:result];
                }
            }
            else if (requestType == kRequestTypeGetMyMsgList)
            {
                
                if (delegate_ && [delegate_ respondsToSelector:@selector(webService:requestType:didFinish:userData:originalData:)]) {
                    [delegate_ webService:self requestType:requestType didFinish:[self parseMsgList:dic withType:kRequestTypeGetMyMsgList] userData:userData originalData:result];
                }
            }
            else
            {
                if (delegate_ && [delegate_ respondsToSelector:@selector(webService:requestType:didFinish:userData:originalData:)]) {
                    [delegate_ webService:self requestType:requestType didFinish:data userData:userData originalData:result];
                }
            }
        }
        else if([data isKindOfClass:[NSArray class]])
        {
            if (requestType == kRequestTypeGetAppCategory ||
                requestType == kRequestTypeGetTopCategory ||
                requestType == kRequestTypeGetChildrenBlock ||
                requestType == kRequestTypeGetBlockUserList ||
                requestType == kRequestTypeGetScheduleList ||
                requestType == kRequestTypeGetHotWordsList||
                requestType == kRequestTypeGetPrizeList ||
                requestType == kRequestTypePrize||
                requestType == kRequestTypeSearchUser||
                requestType == kRequestTypeGetHotUserList||
                requestType == kRequestTypeGetPersonageList||
                requestType == kRequestTypeGetEventList||
                requestType == kRequestTypeGetEventUserList||
                requestType == kRequestTypeGetJoinedEventList||
                requestType == kRequestTypeGetNoteList||
                requestType == kRequestTypeGetEventWinnerList||
                requestType == kRequestTypeGetPicDataList||
                requestType == kRequestTypeGetCollectInfoList) {
                NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
                for (id obj in data) {
                    if ([obj isKindOfClass:[NSDictionary class]]) {
                        BaseResponse *temp = [BaseResponse infoWithDict:obj withRequestType:requestType];
                        [array addObject:temp];
                    }
                }
                if(delegate_ && [delegate_ respondsToSelector:@selector(webService:requestType:didFinish:userData:originalData:)])
                    [delegate_ webService:self requestType:requestType didFinish:([array count]>0?array:nil) userData:userData originalData: result];
            }
            else
            {
                NSArray *array = [NSArray arrayWithArray:data];
                if(delegate_ && [delegate_ respondsToSelector:@selector(webService:requestType:didFinish:userData:originalData:)])
                    [delegate_ webService:self requestType:requestType didFinish:([array count]>0?array:nil) userData:userData originalData:result];
            }
        }
        else if([data isKindOfClass:[NSString class]])
        {
            if (delegate_ && [delegate_ respondsToSelector:@selector(webService:requestType:didFinish:userData:originalData:)]) {
                [delegate_ webService:self requestType:requestType didFinish:data userData:userData originalData:result];
            }
        }
        else
        {
            if (delegate_ && [delegate_ respondsToSelector:@selector(webService:requestType:didFinish:userData:originalData:)]) {
                [delegate_ webService:self requestType:requestType didFinish:status userData:userData originalData:result];
            }
        }
    }
    
}

#pragma mark - Analytic dict
-(NSMutableArray*)analyticDiskFileWithDict:(NSDictionary*)dict withRequestType:(RequestType)type
{
    NSMutableArray *AnalyticArray=[[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    if ([dict isKindOfClass:[NSDictionary class]]) {
        id fileArray            = [dict objectForKey:@"nslist"];
        id userDictArray        = [dict objectForKey:@"userinfolist"];
        id commentDictArray     = [dict objectForKey:@"commentlist"];
        NSString *picbaseurl    = [dict objectForKey:@"picbaseurl"];
        if ([fileArray isKindOfClass:[NSArray class]]) {
            for (int i=0; i<[fileArray count]; i++) {
                DiskFileListResponse *diskFile = [[DiskFileListResponse alloc] init];
                NSDictionary    *dic = [fileArray objectAtIndex:i];
                NSResponse *nameSpace = nil;
                if (dic!=nil) {
                    nameSpace = [[NSResponse alloc]initWithDict:dic withRequestType:type];
                    
                }else{
                    nameSpace = [[NSResponse alloc]init];
                }
                NSDictionary *diskuserDictArrayInfo = nil;
                NSMutableArray *comminfoArray = [[NSMutableArray alloc] init];
                NSMutableArray *comminfouserArray = [[NSMutableArray alloc] init];
                
                if ([commentDictArray isKindOfClass:[NSDictionary class]]) {
                    for (int k=0; k<[nameSpace.cmtids count]; k++) {
                        CommentResponse *commentinfo = [[CommentResponse alloc] initWithDict:[commentDictArray objectForKey:[NSString stringWithFormat:@"%@",[[nameSpace.cmtids objectAtIndex:k] objectForKey:@"$id"]]]withRequestType:type];
                        [comminfoArray addObject:commentinfo];
                        [commentinfo release];
                    }
                }
                
                if ([userDictArray isKindOfClass:[NSDictionary class]]) {
                    diskuserDictArrayInfo = [userDictArray objectForKey:nameSpace.uid];
                    for (int j=0; j<[comminfoArray count]; j++) {
                        CommentResponse *comm = (CommentResponse *)[comminfoArray objectAtIndex:j];
                        if ([userDictArray isKindOfClass:[NSDictionary class]]) {
                            UserInfoResponse *userinfo = [[UserInfoResponse alloc] initWithDict:[userDictArray objectForKey:comm.auid] withRequestType:type];
                            [comminfouserArray addObject:userinfo];
                            [userinfo release];
                        }
                    }
                }
                UserInfoResponse *diskuserinfo = [[UserInfoResponse alloc] initWithDict:diskuserDictArrayInfo withRequestType:type];
                diskFile.nameSpaceInfo = nameSpace==nil?[nameSpace init]:nameSpace;
                diskFile.userInfo = diskuserinfo==nil?[diskuserinfo init]:diskuserinfo;
                diskFile.commentArray = comminfoArray==nil?[comminfoArray init]:comminfoArray;
                diskFile.userInfoArray = comminfouserArray==nil?[comminfouserArray init]:comminfouserArray;
                diskFile.picbaseurl = picbaseurl==nil?[picbaseurl init]:picbaseurl;
                [AnalyticArray addObject:diskFile];
                [diskFile release];
                [comminfoArray release];
                [diskuserinfo release];
                [comminfouserArray release];
                [nameSpace release];
            }
        }
        else
            FVLog(@"数据有误");
        return AnalyticArray;
    }
    return AnalyticArray;
}

-(NSMutableArray *)analyticFavouriteWithDict:(NSDictionary *)dict withRequestType:(RequestType)type
{
    NSMutableArray *AnalyticArray=[[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    if ([dict isKindOfClass:[NSDictionary class]]) {
        id favoriteArray = [dict objectForKey:@"favoritelist"];
        id fileDictArray = [dict objectForKey:@"filelist"];
        id userDictArray = [dict objectForKey:@"userinfolist"];
        id commentDictArray = [dict objectForKey:@"commentlist"];
        NSString *picbaseurl = [dict objectForKey:@"picbaseurl"];
        if ([favoriteArray isKindOfClass:[NSArray class]]) {
            for (int i=0; i<[favoriteArray count]; i++) {
                FavouriteListResponse *favourite = [[FavouriteListResponse alloc] init];
                FavouriteResponse *favinfo = [[FavouriteResponse alloc] initWithDict:[favoriteArray objectAtIndex:i]withRequestType:type];
                NSResponse *file = nil;
                if ([fileDictArray isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *fileDict = [fileDictArray objectForKey:favinfo.nsid];
                    if ([fileDict isKindOfClass:[NSDictionary class]]) {
                        file = [[NSResponse alloc] initWithDict:fileDict withRequestType:type];
                    }
                }
                NSMutableArray *comminfoArray = [[NSMutableArray alloc] init];
                NSMutableArray *comminfouserArray = [[NSMutableArray alloc] init];
                if ([commentDictArray isKindOfClass:[NSDictionary class]]) {
                    for (int k=0; k<[file.cmtids count]; k++) {
                        CommentResponse *commentinfo = [[CommentResponse alloc] initWithDict:[commentDictArray objectForKey:[NSString stringWithFormat:@"%@",[[file.cmtids objectAtIndex:k] objectForKey:@"$id"]]]withRequestType:type];
                        [comminfoArray addObject:commentinfo];
                        [commentinfo release];
                    }
                }
                if ([userDictArray isKindOfClass:[NSDictionary class]]) {
                    for (int j=0; j<[comminfoArray count]; j++) {
                        CommentResponse *comm = (CommentResponse *)[comminfoArray objectAtIndex:j];
                        if ([userDictArray isKindOfClass:[NSDictionary class]]) {
                            UserInfoResponse *userinfo = [[UserInfoResponse alloc] initWithDict:[userDictArray objectForKey:comm.auid] withRequestType:type];
                            [comminfouserArray addObject:userinfo];
                            [userinfo release];
                        }
                    }
                }
                UserInfoResponse *diskuserinfo = [[UserInfoResponse alloc] initWithDict:[userDictArray objectForKey:file.uid] withRequestType:type];
                favourite.favorite = favinfo==nil?[favinfo init]:favinfo;
                favourite.nameSpace = file==nil?[file init]:file;
                favourite.userInfo = diskuserinfo==nil?[diskuserinfo init]:diskuserinfo;
                favourite.commentArray = comminfoArray==nil?[comminfoArray init]:comminfoArray;
                favourite.commentUser = comminfouserArray==nil?[comminfouserArray init]:comminfouserArray;
                favourite.picbaseurl = picbaseurl==nil?[picbaseurl init]:picbaseurl;
                [AnalyticArray addObject:favourite];
                [favinfo release];
                [file release];
                [diskuserinfo release];
                [comminfoArray release];
                [comminfouserArray release];
                [favourite release];
            }
        }else{
            FVLog(@"数据有误");
            return AnalyticArray;
        }
    }
    return AnalyticArray;
}

-(NSMutableArray *)analyticEventListWithDict:(NSDictionary *)dict withRequestType:(RequestType)type
{
    NSMutableArray *AnalyticArray=[[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    if ([dict isKindOfClass:[NSDictionary class]]) {
        id eventfilelist = [dict objectForKey:@"eventfilelist"];
        id fileDictArray = [dict objectForKey:@"nslist"];
        id userDictArray = [dict objectForKey:@"userinfolist"];
        id commentDictArray = [dict objectForKey:@"commentlist"];
        NSString *picbaseurl = [dict objectForKey:@"picbaseurl"];
        
        if ([eventfilelist isKindOfClass:[NSArray class]]) {
            for (int i=0; i<[eventfilelist count]; i++) {
                EventFileListResponse *public = [[EventFileListResponse alloc] init];
                
                EventFileResponse *eventinfo = [[EventFileResponse alloc] initWithDict:[eventfilelist objectAtIndex:i] withRequestType:type];
                
                NSResponse *file = [[NSResponse alloc] initWithDict:[fileDictArray objectForKey:eventinfo.nsid] withRequestType:type];
                
                NSMutableArray *comminfoArray = [[NSMutableArray alloc] init];
                NSMutableArray *comminfouserArray = [[NSMutableArray alloc] init];
                
                if ([commentDictArray isKindOfClass:[NSDictionary class]]) {
                    for (int k=0; k<[file.cmtids count]; k++) {
                        CommentResponse *commentinfo = [[CommentResponse alloc] initWithDict:[commentDictArray objectForKey:[NSString stringWithFormat:@"%@",[[file.cmtids objectAtIndex:k] objectForKey:@"$id"]]] withRequestType:type];
                        [comminfoArray addObject:commentinfo];
                        [commentinfo release];
                    }
                }
                
                if ([userDictArray isKindOfClass:[NSDictionary class]]) {
                    for (int j=0; j<[comminfoArray count]; j++) {
                        CommentResponse *comm = (CommentResponse *)[comminfoArray objectAtIndex:j];
                        if ([userDictArray isKindOfClass:[NSDictionary class]]) {
                            UserInfoResponse *userinfo = [[UserInfoResponse alloc] initWithDict:[userDictArray objectForKey:comm.auid]withRequestType:type];
                            [comminfouserArray addObject:userinfo];
                            [userinfo release];
                        }
                    }
                    
                }
                
                UserInfoResponse *diskuserinfo = [[UserInfoResponse alloc] initWithDict:[userDictArray objectForKey:file.uid]withRequestType:type];
                
                public.eventFile = eventinfo==nil?[eventinfo init]:eventinfo;
                public.nameSpaceInfo = file==nil?[file init]:file;
                public.userInfo = diskuserinfo==nil?[diskuserinfo init]:diskuserinfo;
                public.commentArray = comminfoArray==nil?[comminfoArray init]:comminfoArray;
                public.userInfoArray = comminfouserArray==nil?[comminfouserArray init]:comminfouserArray;
                public.picbaseurl = picbaseurl==nil?[picbaseurl init]:picbaseurl;
                
                [AnalyticArray addObject:public];
                
                [eventinfo release];
                [file release];
                [diskuserinfo release];
                [comminfoArray release];
                [comminfouserArray release];
                [public release];
            }
        }else{
            NSLog(@"数据有误");
            return AnalyticArray;
        }
    }
    return AnalyticArray;
}

-(NSArray*)analyticWithDict:(NSDictionary *)dict withRequestType:(RequestType)type
{
    NSDictionary *userinfolist = [dict objectForKey:@"userinfolist"];
    NSArray *commentlist = [dict objectForKey:@"commentlist"];
    NSMutableArray *msglist = [dict objectForKey:@"msglist"];
    NSArray *feedlist = [dict objectForKey:@"feedlist"];
    NSArray *eventclasslist = [dict objectForKey:@"eventclasslist"];
    NSArray *eventlist = [dict objectForKey:@"eventlist"];
    
    if (type == kRequestTypeGetFeedsList) {
        NSMutableArray *feedArray = [[NSMutableArray alloc] initWithCapacity:1];
        if ([feedlist isKindOfClass:[NSArray class]]) {
            for (int i=0; i<[feedlist count]; i++) {
                FeedResponse *feedinfo = [[FeedResponse alloc] initWithDict:[feedlist objectAtIndex:i] withRequestType:type];
                if ([userinfolist isKindOfClass:[NSDictionary class]]){
                    NSDictionary *cmtuser = [userinfolist objectForKey:feedinfo.uid];
                    UserInfoResponse *uinfo = [[UserInfoResponse alloc] initWithDict:cmtuser withRequestType:type];;
                    feedinfo.userInfo = uinfo;
                    [uinfo release];
                }
                [feedArray addObject:feedinfo];
                [feedinfo release];
            }
        }
        return [feedArray autorelease];
    }
    else if (type == kRequestTypeGetCommentList)
    {
        NSMutableArray *cmtArray = [[NSMutableArray alloc]initWithCapacity:1];
        if ([commentlist isKindOfClass:[NSArray class]]) {
            for (int i=0; i<[commentlist count]; i++) {
                CommentResponse *cmtinfo = [[CommentResponse alloc] initWithDict:[commentlist objectAtIndex:i] withRequestType:type];
                if ([userinfolist isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *cmtuser = [userinfolist objectForKey:cmtinfo.auid];
                    UserInfoResponse *uinfo = [[UserInfoResponse alloc] initWithDict:cmtuser withRequestType:type];
                    cmtinfo.userInfo = uinfo;
                    [uinfo release];
                }
                [cmtArray addObject:cmtinfo];
                [cmtinfo release];
            }
        }
        return [cmtArray autorelease];
    }
    else if (type == kRequestTypeGetUsermsgList)
    {
        NSMutableArray *messArray = [[NSMutableArray alloc] initWithCapacity:1];
        if ([msglist isKindOfClass:[NSArray class]]) {
            for (int i=0; i<[msglist count]; i++) {
                MessageResponse *mesinfo = [[MessageResponse alloc] initWithDict:[msglist objectAtIndex:i] withRequestType:type];
                if ([userinfolist isKindOfClass:[NSDictionary class]]) {
                    UserInfoResponse *uinfo = [[UserInfoResponse alloc] initWithDict:[userinfolist objectForKey:mesinfo.uid] withRequestType:type];
                    mesinfo.userInfo = uinfo;
                    [uinfo release];
                }
                [messArray addObject:mesinfo];
                [mesinfo release];
            }
        }
        return [messArray autorelease];
    }
    else if(type == kRequestTypeGetEventClassList)
    {
        NSMutableArray *eventClassArray = [[[NSMutableArray alloc] init]autorelease];
        for (int i=0; i<[eventclasslist count]; i++) {
            NSMutableDictionary *eventclasslistinfo = [[NSMutableDictionary alloc] initWithDictionary:[eventclasslist objectAtIndex:i]];
            [eventclasslistinfo setObject:eventlist forKey:@"eventlist"];
            EventClassResponse *eventCinfo = [[EventClassResponse alloc] initWithDict:eventclasslistinfo withRequestType:type];
            [eventClassArray addObject:eventCinfo];
            [eventCinfo release];
            [eventclasslistinfo release];
        }
        return eventClassArray;
    }
    else
        return nil;
}

- (NSMutableArray *)parseResourceList:(NSDictionary *)dic withType:(RequestType)type
{
    NSMutableArray *resourceListResult = [[NSMutableArray alloc] init];
    
    NSDictionary *commentsDic = [dic objectForKey:@"commentlist"];
    NSArray *resourceList = [dic objectForKey:@"nslist"];
    NSDictionary *userinfosDic = [dic objectForKey:@"userinfolist"];
    
    
    for (NSDictionary *resourceDic in resourceList)
    {
        if ([resourceDic isKindOfClass:[NSNull class]]) {
            continue;
        }
        ResourceInfo *resource = [[ResourceInfo alloc] initWithDic:resourceDic];
        
        //解析评论列表
        if ([commentsDic count] > 0)
        {
            NSMutableArray *commentsList = [[NSMutableArray alloc] init];
            NSArray *commentIdList = [resourceDic objectForKey:@"cmtids"]; //服务器返回的json中的评论列表
            if ([commentIdList count] > 0)
            {
                for (NSDictionary *commentId in commentIdList)
                {
                    CommentResponse *commentInfo = [[CommentResponse alloc] initWithDict:[commentsDic objectForKey:[commentId objectForKey:@"$id"]]withRequestType:type];
                    [commentsList addObject:commentInfo];
                    [commentInfo release];
                }
                resource.commentions = commentsList;
                [commentsList release];
            }
            else
                [commentsList release];
        }
        
        
        //资源用户
        if ([userinfosDic count] > 0)
        {
            UserInfoResponse *userInfo = [[UserInfoResponse alloc] initWithDict:[userinfosDic objectForKey:resource.resourceUid]withRequestType:type];
            resource.userinfo = userInfo;
            [userInfo release];
        }
        
        
        [resourceListResult addObject:resource];
        [resource release];
    }
    
    return [resourceListResult autorelease];
}

//解析收藏资源列表
- (NSMutableArray *)parseCollectResourceList:(NSDictionary *)dic withType:(RequestType)type
{
    if ([dic count] > 0)
    {
        NSMutableArray *collectResourceList = [[[NSMutableArray alloc] init]autorelease];
        NSArray *collectList = [dic objectForKey:@"favoritelist"];
        NSDictionary *resourceDicList = [dic objectForKey:@"nslist"];
        NSDictionary *userinfosDic = [dic objectForKey:@"userinfolist"];
        NSDictionary *infoList = [dic objectForKey:@"infolist"];
        if ([collectList count] > 0)
        {
            for (NSDictionary *dic in collectList)
            {
                NSString *nsid = [dic objectForKey:@"favid"];
                NSDictionary *infoDic = nil;
                if ([infoList count] > 0)
                {
                    infoDic = [infoList objectForKey:nsid];
                }
                InfoListResponse *info=nil;
                if (infoDic!=nil) {
                    info = [[[InfoListResponse alloc] initWithDictionary:infoDic]autorelease];
                    if ([userinfosDic count] > 0)
                    {
                        UserInfoResponse *userInfo = [[UserInfoResponse alloc] initWithDict:[userinfosDic objectForKey:[NSString stringWithFormat:@"%d",info.uid]]withRequestType:0];
                        info.userinfo = userInfo;
                        [userInfo release];
                    }
                    NSArray *ns = [infoDic objectForKey:@"nsids"];
                    NSMutableArray *nsList = [[NSMutableArray alloc] init];
                    if ([resourceDicList count] > 0)
                    {
                        for (NSString *nsid in ns)
                        {
                            ResourceInfo *res = [[ResourceInfo alloc] initWithDic:[resourceDicList objectForKey:nsid]];
                            [nsList addObject:res];
                            [res release];
                        }
                        info.resourceArray = nsList;
                        [nsList release];
                    }
                    else
                        [nsList release];
                    [collectResourceList addObject:info];
                }
            }
            return collectResourceList;
        }
    }
    return nil;
}

- (NSMutableDictionary *)parseInfo:(NSDictionary *)dic withType:(RequestType)type
{
    NSMutableDictionary *returnDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    NSDictionary *commentsDic = [dic objectForKey:@"commentlist"];
    NSDictionary *resourceDic = [dic objectForKey:@"infolist"];
    NSDictionary *userinfosDic = [dic objectForKey:@"userinfolist"];
    
    NSArray *allKeys = [resourceDic allKeys];
    for (NSString *key in allKeys) {
        NSDictionary *infoDic = [resourceDic objectForKey:key];
        InfoListResponse *resource = [[InfoListResponse alloc] initWithDictionary:infoDic];
        //解析评论列表
        if (![commentsDic isKindOfClass:[NSNull class]] && [commentsDic count] > 0)
        {
            NSMutableArray *commentsList = [[NSMutableArray alloc] init];
            NSArray *commentIdList = [resourceDic objectForKey:@"cmtids"]; //服务器返回的json中的评论列表
            if ([commentIdList count] > 0)
            {
                for (NSDictionary *commentId in commentIdList)
                {
                    CommentResponse *commentInfo = [[CommentResponse alloc] initWithDict:[commentsDic objectForKey:[commentId objectForKey:@"$id"]]withRequestType:type];
                    [commentsList addObject:commentInfo];
                    [commentInfo release];
                }
                resource.commentions = commentsList;
                [commentsList release];
            }
            else
                [commentsList release];
        }
        
        //资源用户
        if (![userinfosDic isKindOfClass:[NSNull class]] && [userinfosDic count] > 0)
        {
//            NSLog(@"%@",[userinfosDic objectForKey:[NSString stringWithFormat:@"%d",resource.uid]]);
            UserInfoResponse *userInfo = [[UserInfoResponse alloc] initWithDict:[userinfosDic objectForKey:[NSString stringWithFormat:@"%d",resource.uid]]withRequestType:type];
            resource.userinfo = userInfo;
            [userInfo release];
        }
        
        [returnDic setObject:resource forKey:key];
        [resource release];
    }
    return [returnDic autorelease];
}

- (NSMutableDictionary *)parseNS:(NSDictionary *)dic withType:(RequestType)type
{
    NSMutableDictionary *returnDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    NSDictionary *commentsDic = [dic objectForKey:@"commentlist"];
    NSDictionary *resourceDic = [dic objectForKey:@"nslist"];
    NSDictionary *userinfosDic = [dic objectForKey:@"userinfolist"];
    
    NSArray *allKeys = [resourceDic allKeys];
    for (NSString *key in allKeys) {
        NSDictionary *infoDic = [resourceDic objectForKey:key];
        if ([infoDic isKindOfClass:[NSNull class]]) {
            continue;
        }
        ResourceInfo *resource = [[ResourceInfo alloc] initWithDic:infoDic];
        //解析评论列表
        if ([commentsDic count] > 0)
        {
            NSMutableArray *commentsList = [[NSMutableArray alloc] init];
            NSArray *commentIdList = [resourceDic objectForKey:@"cmtids"]; //服务器返回的json中的评论列表
            if ([commentIdList count] > 0)
            {
                for (NSDictionary *commentId in commentIdList)
                {
                    CommentResponse *commentInfo = [[CommentResponse alloc] initWithDict:[commentsDic objectForKey:[commentId objectForKey:@"$id"]]withRequestType:type];
                    [commentsList addObject:commentInfo];
                    [commentInfo release];
                }
                resource.commentions = commentsList;
                [commentsList release];
            }
            else
                [commentsList release];
        }
        
        
        //资源用户
        if ([userinfosDic count] > 0)
        {
            UserInfoResponse *userInfo = [[UserInfoResponse alloc] initWithDict:[userinfosDic objectForKey:resource.resourceUid]withRequestType:type];
            resource.userinfo = userInfo;
            [userInfo release];
        }

        [returnDic setObject:resource forKey:key];
        [resource release];
    }
    return [returnDic autorelease];
}

- (NSMutableArray *)parseInfoList:(NSDictionary *)dic withType:(RequestType)type
{
    NSMutableArray *resourceListResult = [[NSMutableArray alloc] init];
    
    NSDictionary *commentsDic = [dic objectForKey:@"commentlist"];
    NSArray *resourceList = [dic objectForKey:@"infolist"];
    NSDictionary *userinfosDic = [dic objectForKey:@"userinfolist"];
    NSDictionary *nsDic = [dic objectForKey:@"nslist"];
    
    self.picbaseurl = dic[@"picbaseurl"];
    
    for (NSDictionary *resourceDic in resourceList)
    {
        InfoListResponse *resource = [[InfoListResponse alloc] initWithDictionary:resourceDic];
        
        //解析评论列表
        if (![commentsDic isKindOfClass:[NSNull class]] && [commentsDic count] > 0)
        {
            NSMutableArray *commentsList = [[NSMutableArray alloc] init];
            NSArray *commentIdList = [resourceDic objectForKey:@"cmtids"]; //服务器返回的json中的评论列表
            if ([commentIdList count] > 0)
            {
                for (NSDictionary *commentId in commentIdList)
                {
                    CommentResponse *commentInfo = [[CommentResponse alloc] initWithDict:[commentsDic objectForKey:[commentId objectForKey:@"$id"]]withRequestType:type];
                    
                    UserInfoResponse *userInfo = [[UserInfoResponse alloc] initWithDict:[userinfosDic objectForKey:commentInfo.auid] withRequestType:type];
                    commentInfo.userInfo = userInfo;
                    [userInfo release];
                
                    [commentsList addObject:commentInfo];
                    [commentInfo release];
                }
                resource.commentions = commentsList;
                [commentsList release];
            }
            else
                [commentsList release];
        }
        
        if (![nsDic isKindOfClass:[NSNull class]] && [nsDic count] > 0)
        {
            NSMutableArray *nsList = [[NSMutableArray alloc] init];
            NSArray *nsidList = [resourceDic objectForKey:@"nsids"]; //服务器返回的json中的评论列表
            if ([nsidList count] > 0)
            {
                for (NSString *nsid in nsidList)
                {
                    ResourceInfo *res = [[ResourceInfo alloc] initWithDic:[nsDic objectForKey:nsid]];
                    [nsList addObject:res];
                    [res release];
                }
                resource.resourceArray = nsList;
                [nsList release];
            }
            else
                [nsList release];
        }
        
        //资源用户
        if (![userinfosDic isKindOfClass:[NSNull class]] && [userinfosDic count] > 0)
        {
//            NSLog(@"%@",[userinfosDic objectForKey:[NSString stringWithFormat:@"%d",resource.uid]]);
            UserInfoResponse *userInfo = [[UserInfoResponse alloc] initWithDict:[userinfosDic objectForKey:[NSString stringWithFormat:@"%d",resource.uid]]withRequestType:type];
            resource.userinfo = userInfo;
            [userInfo release];
        }
        
        
        [resourceListResult addObject:resource];
        [resource release];
    }
    
    return [resourceListResult autorelease];
}

- (NSMutableArray *)parseMsgList:(NSDictionary *)dic withType:(RequestType)type
{
    NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    NSArray *userInfoList = [[dic objectForKey:@"data"]objectForKey:@"userinfolist"];
    NSDictionary *msgDic = [[dic objectForKey:@"data"]objectForKey:@"msglist"];
    for (NSDictionary *userdict in userInfoList) {
        if (userdict) {
            UserInfoResponse *user = [[UserInfoResponse alloc]initWithDict:userdict withRequestType:kRequestTypeGetMyMsgList];
            NSArray *msdArray = [msgDic objectForKey:[NSString stringWithFormat:@"uid-%@",user.uid]];
            NSMutableArray *msglist = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
            for (NSDictionary *msgdict in msdArray) {
                MessageResponse *msg = [[MessageResponse alloc]initWithDict:msgdict withRequestType:kRequestTypeGetMyMsgList];
                [msglist addObject:msg];
                [msg release];
            }
            MsgListResponse *res = [[MsgListResponse alloc]initWithDict:nil withRequestType:kRequestTypeGetMyMsgList];
            res.user = user;
            res.msgList = msglist;
            [array addObject:res];
            [res release];
        }
    }
    return array;
}


@end
