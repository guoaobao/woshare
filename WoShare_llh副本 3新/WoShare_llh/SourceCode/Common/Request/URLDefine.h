//
//  URLDefine.h
//  QYSDK
//
//  Created by 胡 波 on 13-4-19.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#ifndef QYSDK_URLDefine_h
#define QYSDK_URLDefine_h
#import "DataSource.h"

#define version [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define sourced [[[NSBundle mainBundle] infoDictionary] objectForKey:@"Source"]
#define systemversion [[UIDevice currentDevice] systemVersion]
#define devID [[DataSource sharedDataSource]getDeviceID]

#define AppParams [NSString stringWithFormat:@"clienttype=iphone&source=%@&version=%@&deviceid=%@&",sourced,FVBundleVersion(),devID]

#define BaseAppURL [NSString stringWithFormat:@"http://happy.hn165.com/interface-new/index.php?%@",AppParams]

#define NewBaseAppURL   @"http://www.hn165.com/index.php?g=interface&"

//disk
//获取上传地址
#define GetUploadURL            @"m=disk&a=getuploadurl&v="
//上传成功
#define CompleteUpLoadURL       @"m=disk&a=completeupload&v="
//获得网盘列表
#define GetDiskListURL          @"m=disk&a=getdisklist&v="
//获取最近上传列表
#define GetRecentUploadListURL  @"m=disk&a=getrecentfilelist&v="
//获取或者搜索资源列表
#define SearchNsURL             @"m=disk&a=searchns&v="
//创建普通文件夹
#define CreateFolderURL         @"m=disk&a=createfolder&v="
//移动文件
#define MoveFileURL             @"m=disk&a=movefile&v="
//重命名文件
#define RenameFileURL           @"m=disk&a=renamefile&v="
//删除文件
#define DelFileURL              @"m=disk&a=deletefile&v="
//转存文件
#define RestoreFileURL          @"m=disk&a=restorefile&v="
//获得文件下载地址
#define GetDownloadURL          @"m=disk&a=getdownurl&v="
//获取用户数据
#define GetNameSpaceInfoURL     @"m=disk&a=getnamespaceinfo&v="
//设置文件信息
#define SetFolderInfoURL        @"m=disk&a=setfolderinfo&v="
//喜欢资源
#define LikensURL               @"m=disk&a=likens&v="
//资源点击数
#define ClicknsURL               @"m=disk&a=clickns&v="
//获取用户空间统计信息
#define GetSpaceStatInfoURL     @"m=disk&a=getspacestatinfo&v="
//设置文件信息
#define SetFileInfoURL          @"m=disk&a=setfileinfo&v="
//日志接口
#define SetPageVisitLogURL      @"m=stat&a=setpagevisitlog&v="



//app
//获取应用栏目列表
#define GetAppCategoryURL       @"m=app&a=getappcategory&v="
//获取首页的应用栏目列表
#define GetTopCategoryURL       @"m=app&a=gettopcategory&v="
//获取子板块栏目列表
#define GetChildrenBlockURL     @"m=app&a=getchildrenblock&v="
//获取板块下文件列表
#define GetBlockFileListURL     @"m=app&a=getblockfilelist&v="
//获取版块下用户列表
#define GetBlockUserListURL     @"m=app&a=getblockuserlist&v="
//获取热词列表
#define GetHotWordsListURL      @"m=app&a=gethotwordslist&v="
//获取获取电视台排播表
#define GetSchedulelistURL      @"m=app&a=getschedulelist&v="
//获取抽奖列表
#define GetPrizeListURL         @"m=app&a=getprizelist&v="
//抽奖
#define PrizeURL                @"m=app&a=prize&v="

#define GetSuperEyeListURL      @"m=app&a=getsupereyelist&v="

#define GetPicDataListURL       @"m=app&a=getpicdatalist&v="

#define GetNSList               @"m=disk&a=getnslist&v="

#define GetInfoList             @"m=infos&a=getinfolist&v="

//user
//注册接口
#define RegisterURL             @"m=users&a=register&v="
//登录接口
#define LoginURL                @"m=users&a=login&usertype=account"
//登出接口
#define LogoutURL               @"m=users&a=logout&v="
//修改密码
#define ModifyPasswordURL       @"m=users&a=modifypassword&v="
//修改昵称
#define ModifyUserNameURL       @"m=users&a=modifyusername&v="
//修改头像
#define ModifyAvatarURL         @"m=users&a=modifyavatar&v="
//修改用户背景
#define ModifyBackgroundURL     @"m=users&a=modifybackground&v="
//搜人
#define SearchUserURL           @"m=users&a=searchuserinfo&v="
//搜热点人物
#define GetHotUserListURL       @"m=users&a=gethotuserlist&v="
//获取名人堂数据
#define GetPersonAgeListURL     @"m=users&a=getpersonagelist&v="
//绑定手机
#define BindMobileURL           @"m=users&a=bindmobile&v="
//解除手机绑定
#define UnbindMobileURL         @"m=users&a=unbindmobile&v="
//自动登录
#define AutoLoginURL            @"m=users&a=loginbytoken&v="
//手机号自动登陆
#define MobileNumberLoginURL    @"m=users&a=getunicommobile&usertype=3g"
//获取兴趣列表
#define GetHobbyURL             @"m=users&a=getinterestlist&v="
//重置密码
#define ModifyPasswordForgotURL @"m=users&a=modifypassword2"
//检查手机号自动登陆
#define CheckUnicomMobileURL    @"m=users&a=checkunicommobile&v="
//找回密码
#define FindUserPassWord        @"m=users&a=resetpassword&v="

//note
//关注或取消关注用户
#define NoteURL                 @"m=users&a=note&v="
//获取关注列表
#define GetNoteListURL          @"m=users&a=getnotelist&v="
//获取我关注的用户
#define GetNoteUidsURL          @"m=users&a=getnoteuids&v="
//发送私信



//favourite
//获取收藏列表
#define GetFavoriteListURL      @"m=favorite&a=getfavoritelist&v="
//添加收藏分类
#define AddClassURL             @"m=favorite&a=addclass&v="
//添加收藏
#define AddFavoriteURL          @"m=fav&a=addfavorite&v="
//删除收藏
#define DelFavoriteURL          @"m=fav&a=delfavorite&v="

//comment
//获取评论列表
#define GetCommentListURL       @"m=comments&a=getcommentlist&v="
//添加评论
#define AddCommentURL           @"m=comments&a=addcomment&v="
//删除评论
#define DelCommentURL           @"m=comments&a=delcomment&v="

//event
//获取主题活动列表
#define GetEventListURL         @"m=events&a=geteventlist&v="
//获取主题活动详细信息
#define GetEventInfoURL         @"m=events&a=geteventinfo&v="
//获取主题
#define GetEventFileListURL     @"m=events&a=geteventfilelist&v="
//获取活动用户列表
#define GetEventUserListURL     @"m=events&a=geteventuserlist&v="
//获取当前文件是否参加活动 
#define GetJoinedEventListURL   @"m=events&a=getjoinedeventlist&v="
//活动文件投票
#define VoteURL                 @"m=events&a=vote&v="
//申请嘉宾
#define ApplyGuestsURL          @"m=events&a=applyguests&v="
//获取活动分类列表
#define GetEventClassListURL    @"m=events&a=geteventclasslist&v="
//获取活动中奖名单
#define GetEventWinnerListURL   @"m=events&a=geteventwinnerlist&v="


//message
//获取用户消息列表
#define GetUsermsglistURL       @"m=messages&a=getusermsglist&v="
//已读用户消息
#define CompleteReadURL         @"m=messages&a=completeread&v="
//删除用户消息
#define DeleteUsermsgURL        @"m=messages&a=deleteusermsg&v="
//设置是否关闭推送消息
#define SetReceivemsgURL        @"m=messages&a=setreceivemsg&v="
//发送私信
#define SendmsgURL              @"m=messages&a=sendmsg&v="
//获取用户动态列表
#define GetFeedsListURL         @"m=messages&a=getfeedslist&v="
//已读用户动态
#define CompleteReadFeedsURL    @"m=messages&a=completereadfeeds&v="
//删除用户动态
#define DeleteFeedsURL          @"m=messages&a=deletefeeds&v="


//link
//获取上传备份地址
#define GetBackupURL            @"m=link&a=getbackupurl&v="
//备份成功回调
#define CompleteBackupURL       @"m=link&a=completebackup&v="
//获取恢复地址
#define GetResumeURL            @"m=link&a=getresumeurl&v="
//获取通讯录邀请列表
#define GetLinkInviteListURL    @"m=link&a=getinvitelist&v="
//获取通讯录寻找列表
#define GetLinkSearchListURL    @"m=link&a=getsearchlist&v="


//system
//获取配置信息
#define GetConfigURL            @"m=system&a=getconfig&v="
//获取渠道接口
#define GetSourceInfoURL        @"m=system&a=getsourceinfo&v="
//上传错误信息
#define SetErrorInfoURL         @"m=system&a=seterrorinfo&v="
//用户反馈
#define FeedBackURL             @"m=system&a=feedback&v="
//举报功能
#define ReportURL               @"m=system&a=report&v="
//分享成功
#define CompleteShareURL        @"m=system&a=completeshare&v="
//验证码
#define SendCaptchaURL          @"m=system&a=sendcaptcha&v="
//email
#define SendCaptchaEmailURL     @"m=system&a=sendcaptchabyemail&v="
//检验验证码
#define CheckCaptchaURL         @"m=system&a=checkcaptcha&v="
//设置设备token
#define SetDeviceTokenURL       @"m=system&a=setdevicetoken&v="
//发送短信
#define SendSmsURL              @"m=system&a=sendsms&v="

//sns
//获取SNS邀请列表
#define GetSNSInviteListURL     @"m=sns&a=getinvitelist&v="
//获取SNS寻找列表
#define GetSNSSearchListURL     @"m=sns&a=getsearchlist&v="

//获取sina授权信息，通过uid
#define GetSinaAuthInfoByUidURL @"m=users&a=getsinaauthinfobyuid&v="
//绑定sina授权信息，通过uid
#define BindSinaUserByUidURL    @"m=users&a=bindsinauserbyuid&v="
//获取sina授权信息
#define GetSinaAuthInfoURL      @"m=users&a=getsinaauthinfo&usertype=sina&v="
//根据账号绑定第三方账号登录sina
#define BindSinaUserURL         @"m=users&a=bindsinauser&v="
//Sina账号绑定老账号登陆
#define BindSinaOldUserURL      @"m=users&a=bindsinaolduser&v="
//Sina账号绑定新账号登陆
#define BindSinaNewUserURL      @"m=users&a=bindsinanewuser&v="
//取消Sina账号绑定
#define UnbindSinaUserURL       @"m=users&a=unbindsinauser&v="

//获取QQ授权信息，通过uid
#define GetQQAuthInfoByUidURL   @"m=users&a=getqqauthinfobyuid&v="
//绑定QQ授权信息，通过uid
#define BindQQUserByUidURL      @"m=users&a=bindqquserbyuid&v="
//获取QQ授权信息
#define GetQQAuthInfoURL        @"m=users&a=getqqauthinfo&v="
//根据账号绑定第三方账号登录qq
#define BindQQUserURL           @"m=users&a=bindqquser&v="
//QQ账号绑定老账号登陆
#define BindQQOldUserURL        @"m=users&a=bindqqolduser&v="
//QQ账号绑定新账号登陆
#define BindQQNewUserURL        @"m=users&a=bindqqnewuser&v="
//取消QQ账号绑定
#define UnbindQQUserURL         @"m=users&a=unbindqquser&v="

//获取Tencent授权信息，通过uid
#define GetTencentAuthInfoByUidURL   @"m=users&a=gettencentauthinfobyuid&v="
//绑定Tencent授权信息，通过uid
#define BindTencentUserByUidURL      @"m=users&a=bindtencentuserbyuid&v="
//获取Tencent授权信息
#define GetTencentAuthInfoURL        @"m=users&a=gettencentauthinfo&v="
//根据账号绑定第三方账号登录Tencent
#define BindTencentUserURL           @"m=users&a=bindtencentuser&v="
//Tencent账号绑定老账号登陆
#define BindTencentOldUserURL        @"m=users&a=bindtencentolduser&v="
//Tencent账号绑定新账号登陆
#define BindTencentNewUserURL        @"m=users&a=bindtencentnewuser&v="
//取消Tencent账号绑定
#define UnbindTencentUserURL         @"m=users&a=unbindtencentuser&v="

//common
//获取文件列表，通过版块ID
#define QSearchNSURL            @"m=info&a=qsearchns&v="

#define QSearchinfoURL          @"m=info&a=qsearchinfo&v="

//完成邀请
#define CompleteInviteURL       @"m=sns&a=completeinvite&v="

#define GetInfoInfoURL          @"m=infos&a=getinfoinfo&v="

#define GetInfonsListURL        @"m=infos&a=getinfonslist&v="

#define SearchInfoURL           @"m=infos&a=searchinfo&v="

#define LikeInfoURL             @"m=info&a=likeinfo&v="

#define ClickInfoURL            @"m=infos&a=clickinfo&v="

#define AddInfoURL              @"m=info&a=addinfo&v="

#define DeleteInfoURL           @"m=infos&a=deleteinfo&v="

#define GetProductListURL       @"m=other&a=getproductlist&v="

#define OrderProductURL         @"m=other&a=orderproduct&v="

#define JoinEventURL            @"m=other&a=joinevent&v="

#define GetLikeInfoListURL      @"m=infos&a=getlikeinfolist&v="

#define GetCreditURL            @"m=credit&a=getcredit&v="

#define GetmymsglistURL         @"m=messages&a=getmymsglist&v="

#define GetFavoriteUserListURL         @"m=favorite&a=getfavoriteuserlist&v="
#endif

