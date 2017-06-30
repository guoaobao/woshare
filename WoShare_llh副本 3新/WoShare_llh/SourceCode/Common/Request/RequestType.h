//
//  RequestType.h
//  QYSDK
//
//  Created by 胡 波 on 13-4-2.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#ifndef QYSDK_RequestType_h
#define QYSDK_RequestType_h


typedef enum
{
    kRequestTypeNone                    =   0,
    //Normal Request 1-99
    kRequestTypeNetworkChanged          =   1,
    //Web Service
    kRequestTypeWSMin                   =   100,
    
    //disk    101~150
    kRequestTypeGetUpload               =   101,//NSDictionary {“serverip”:””,” port”:””,” sessionid”:””}
    kRequestTypeCompleteUpLoad          =   102,//void
    kRequestTypeGetDiskList             =   103,//DiskFileListResponse 
    kRequestTypeGetRecentUploadList     =   104,//DiskFileListResponse
    kRequestTypeSearchNs                =   105,//DiskFileListResponse
    kRequestTypeCreateFolder            =   106,//NSString
    kRequestTypeMoveFile                =   107,//void
    kRequestTypeRenameFile              =   108,//void
    kRequestTypeDelFile                 =   109,//void
    kRequestTypeRestoreFile             =   110,//void
    kRequestTypeGetDownloadURL          =   111,//NSString
    kRequestTypeGetNameSpaceInfo        =   112,//DiskFileListResponse
    kRequestTypeSetFolderInfo           =   113,//void
    kRequestTypeLikens                  =   114,//void
    kRequestTypeClickns                 =   115,//void
    kRequestTypeGetSpaceStatInfo        =   116,//DiskResponse
    kRequestTypeSetFileInfo             =   117,//void
    kRequestTypeGetNSList               =   118,
    
    
    //app   151~200
    kRequestTypeGetAppCategory          =   151,//NSArray
    kRequestTypeGetTopCategory          =   152,//NSArray
    kRequestTypeGetChildrenBlock        =   153,//NSArray
    kRequestTypeGetBlockFileList        =   154,//DiskFileListResponse
    kRequestTypeGetBlockUserList        =   155,//NSArray
    kRequestTypeGetScheduleList         =   156,//NSArray
    kRequestTypeGetHotWordsList         =   157,//NSArray
    kRequestTypeGetPrizeList            =   158,//NSArray
    kRequestTypePrize                   =   159,//NSArray
    kRequestTypeGetSuperEyeList         =   160,
    kRequestTypeGetPicDataList          =   161,
    
    //user    201~250
    kRequestTypeRegister                =   201,//NSString
    kRequestTypeLogin                   =   202,//UserResponse
    kRequestTypeLogout                  =   203,//void
    kRequestTypeModifyPassword          =   204,//void
    kRequestTypeModifyUserName          =   205,//void
    kRequestTypeModifyAvatar            =   206,//NSArray
    kRequestTypeModifyBackground        =   207,//NSString
    kRequestTypeSearchUser              =   208,//NSArray
    kRequestTypeGetHotUserList          =   209,//NSArray
    kRequestTypeGetPersonageList        =   210,//NSArray
    kRequestTypeBindMobile              =   211,//void
    kRequestTypeUnbindMobile            =   212,//void
    kRequestTypeAutoLogin               =   213,//UserResponse
    kRequestTypeLoginByMobile           =   214,//UserResponse
    kRequestTypeGetHobby                =   215,//dic
    kRequestTypeModifyPasswordForgot    =   216,
    kRequestTypeCheckMobile             =   217,
    kRequestTypeFindPassWord            =   218,
    
    //note  251~300
    kRequestTypeNote                    =   251,//void
    kRequestTypeGetNoteList             =   252,//NSArray
    kRequestTypeGetNoteUids             =   253,//NSArray
    
    //favorite    301~350
    kRequestTypeGetFavoriteList         =   301,//FavouriteListResponse
    kRequestTypeAddClass                =   302,//void
    kRequestTypeAddFavorite             =   303,//void
    kRequestTypeDelFavorite             =   304,//void
    
    //comment     351~400
    kRequestTypeGetCommentList          =   351,//{“commentlist”:””,” userinfolist”:””,”newcomment”:””} ??
    kRequestTypeAddComment              =   352,//void
    kRequestTypeDelComment              =   353,//void
    
    //event       401~450
    kRequestTypeGetEventList            =   401,//NSArray
    kRequestTypeGetEventInfo            =   402,//EventInfo
    kRequestTypeGetEventFileList        =   403,//EventFileListResponse
    kRequestTypeGetEventUserList        =   404,//NSArray
    kRequestTypeGetJoinedEventList      =   405,//NSArray
    kRequestTypeVote                    =   406,//void
    kRequestTypeApplyGuests             =   407,//void
    kRequestTypeGetEventClassList       =   408,//NSArray
    kRequestTypeGetEventWinnerList      =   409,//NSArray
    
    //message     451~500
    kRequestTypeGetUsermsgList          =   451,//NSArray
    kRequestTypeCompleteRead            =   452,//void
    kRequestTypeDeleteUsermsg           =   453,//void
    kRequestTypeSetReceivemsg           =   454,//void
    kRequestTypeSendmsg                 =   455,//void
    kRequestTypeGetFeedsList            =   456,//{“feedlist”:””，“userinfolist”:””，”newnum”:””}
    kRequestTypeCompleteReadFeeds       =   457,//void
    kRequestTypeDeleteFeeds             =   458,//void
    kRequestTypeGetMyMsgList            =   459,
    
    //link      501~550
    kRequestTypeGetBackupUrl            =   501,//{“serverip”:””,” port”:””,” sessionid”:””}
    kRequestTypeCompleteBackup          =   502,//void
    kRequestTypeGetResumeUrl            =   503,//{“resumeurl”:””,” bakupnum”:””}
    kRequestTypeGetLinkInviteList       =   504,//NSArray
    kRequestTypeGetLinkSearchList       =   505,//NSArray
    
    //system      551~600
    kRequestTypeGetConfig               =   551,//NSDictionary
    kRequestTypeGetSourceInfo           =   552,//NSString
    kRequestTypeSetErrorInfo            =   553,//void
    kRequestTypeFeedback                =   554,//void
    kRequestTypeReport                  =   555,//void
    kRequestTypeCompleteShare           =   556,//void
    kRequestTypeSendCaptcha             =   557,//void
    kRequestTypeCheckCaptcha            =   558,//NSString
    kRequestTypeSetDeviceToken          =   559,//void
    kRequestTypeSendCaptchaEmail        =   560,
    //sns           601~650
    kRequestTypeGetSNSInviteList        =   601,//NSArray
    kRequestTypeGetSNSSearchList        =   602,//NSArray
    kRequestTypeGetSinaAuthinfoByUid    =   603,//{ 'uid':0,'thirduid':0,'token':'','tsecret':'','expiration':0}
    kRequestTypeBindSinaUserByUid       =   604,//{ 'uid':0,'thirduid':0,'token':'','tsecret':'','expiration':0}
    kRequestTypeGetSinaAuthinfo         =   605,//{ 'uid':0,'thirduid':0,'token':'','tsecret':'','expiration':0}
    kRequestTypeBindSinaUser            =   606,//UserInfoResponse
    kRequestTypeBindSinaOldUser         =   607,//UserInfoResponse
    kRequestTypeBindSinaNewUser         =   608,//UserInfoResponse
    kRequestTypeUnbindSinaUser          =   609,//void
    kRequestTypeGetQQAuthinfoByUid      =   610,//{ 'uid':0,'thirduid':0,'token':'','tsecret':'','expiration':0}
    kRequestTypeBindQQUserByUid         =   611,//{ 'uid':0,'thirduid':0,'token':'','tsecret':'','expiration':0}
    kRequestTypeGetQQAuthinfo           =   612,//{ 'uid':0,'thirduid':0,'token':'','tsecret':'','expiration':0}
    kRequestTypeBindQQUser              =   613,//UserInfoResponse
    kRequestTypeBindQQOldUser           =   614,//UserInfoResponse
    kRequestTypeBindQQNewUser           =   615,//UserInfoResponse
    kRequestTypeUnbindQQUser            =   616,//void
    kRequestTypeGetTencentAuthinfoByUid =   617,//{ 'uid':0,'thirduid':0,'token':'','tsecret':'','expiration':0}
    kRequestTypeBindTencentUserByUid    =   618,//{ 'uid':0,'thirduid':0,'token':'','tsecret':'','expiration':0}
    kRequestTypeGetTencentAuthinfo      =   619,//{ 'uid':0,'thirduid':0,'token':'','tsecret':'','expiration':0}
    kRequestTypeBindTencentUser         =   620,//UserInfoResponse
    kRequestTypeBindTencentOldUser      =   621,//UserInfoResponse
    kRequestTypeBindTencentNewUser      =   622,//UserInfoResponse
    kRequestTypeUnbindTencentUser       =   623,//void
    kRequestTypeCompleteInvite          =   624,//void
    kRequestTypeSendSms                 =   625,

    //common        651~700
    kRequestTypeQSearchNS               =   651,//DiskFileListResponse
    kRequestTypeQSearchinfo             =   652,
    kRequestTypeGetInfoInfo             =   653,
    kRequestTypeGetInfonsList           =   654,
    kRequestTypeSearchInfo              =   655,
    kRequestTypeLikeInfo                =   656,
    kRequestTypeClickInfo               =   657,
    kRequestTypeAddInfo                 =   658,
    kRequestTypeDeleteInfo              =   659,
    kRequestTypeGetInfoList             =   660,
    kRequestTypeGetLikeInfoList         =   661,
    kRequestTypeGetCollectInfoList      =   662,
    kRequestTypeGetPhoneNumber          =   701,
    
    kRequestTypeGetProductList          =   702,
    kRequestTypeOrderProduct            =   703,
    kRequestTypeJoinEvent               =   704,
    kRequestTypeGetCredit               =   705,
    
    
    kRequestTypeSetPageVisitLog         =   801,
    
    kRequestTypeWSMax                   =   899
}RequestType;

typedef enum
{
    kSNSRequestTypeSinaShare            =   100,
    kSNSRequestTypeSinaLogin            =   101,
    kSNSRequestTypeSinaLogout           =   102,
    
    kSNSRequestTypeQQShare              =   200,
    
    kSNSRequestTypeTencentShare         =   300,
    
    kSNSRequestTypeWeChatShare          =   400
}SNSRequestType;

#define IFNIL(ZZ)  ZZ==nil?@"":ZZ

#define kSNSTypeSina    @"sina"
#define kSNSTypeQQ      @"qq"
#define kSNSTypeTencent @"tencent"
#define kSNSTypeWeChat  @"wechat"
#endif
