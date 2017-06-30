//
//  EventResponse.h
//  QYSDK
//
//  Created by 胡 波 on 13-4-23.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "BaseResponse.h"
typedef enum
{
    kEventStatusAll = 0,   //所有活动
    kEventStatusWaiting = 1, //未开始的活动
    kEventStatusOnline = 3, //在线的活动
    kEventStatusFinish = 4  //结束的活动
}kEventStatus;

typedef enum
{
    kEventTypeAll = 0,      //所有活动
    kEventTypePic = 1,      //拍照上传
    kEventTypeOther = 2,    //其他活动
    kEventTypeURL = 3       //未开始的活动
}kEventType;

@interface EventResponse : BaseResponse

@property (nonatomic, strong) NSString *membernum;
@property (nonatomic, strong) NSString *topicid;
@property (nonatomic, strong) NSString *grade;
@property (nonatomic, strong) NSString *maxvote;
@property (nonatomic, strong) NSString *eventid;
@property (nonatomic, strong) NSString *remote;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *allowinvite;
@property (nonatomic, strong) NSString *eventtype;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *wlurl;
@property (nonatomic, strong) NSString *viewnum;
@property (nonatomic, strong) NSString *limitnum;
@property (nonatomic, strong) NSString *reward;
@property (nonatomic, strong) NSString *allowpost;
@property (nonatomic, strong) NSString *cmtcachetime;
@property (nonatomic, strong) NSString *sinablog;
@property (nonatomic, strong) NSString *usercachetime;
@property (nonatomic, strong) NSString *dateline;
@property (nonatomic, strong) NSString *recommendtime;
@property (nonatomic, strong) NSString *userlastcache;
@property (nonatomic, strong) NSString *filecachetime;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *filelastcache;
@property (nonatomic, strong) NSString *endtime;
@property (nonatomic, strong) NSString *sort;
@property (nonatomic, strong) NSString *award;
@property (nonatomic, strong) NSString *thumb;
@property (nonatomic, strong) NSString *deadline;
@property (nonatomic, strong) NSString *poster;
@property (nonatomic, strong) NSString *allowpic;
@property (nonatomic, strong) NSArray *eventfiles;
@property (nonatomic, strong) NSString *ments;
@property (nonatomic, strong) NSString *cids;
@property (nonatomic, strong) NSString *showmode;
@property (nonatomic, strong) NSArray *hotcomment;
@property (nonatomic, strong) NSString *starttime;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *cmtlastcache;
@property (nonatomic, strong) NSString *classid;
@property (nonatomic, strong) NSArray *hotuser;
@property (nonatomic, strong) NSString *verify;
@property (nonatomic, assign) kEventStatus eventstatus;
@property (nonatomic, strong) NSString *follownum;
@property (nonatomic, strong) NSString *pcposter;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *hot;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSString *allowfellow;
@property (nonatomic, strong) NSString *resourcenum;
@property (nonatomic, strong) NSString *updatetime;
@property (nonatomic, assign) kEventType type;
- (NSDictionary *)dictionaryRepresentation;

@end


//@interface EventResponse : BaseResponse
//@property(nonatomic, assign) kEventStatus eventStatus;
//@property(nonatomic, copy) NSString *wlurl;
//@property(nonatomic, copy) NSString *eventtype;
//@property(nonatomic, copy) NSString *ments;
//@property(nonatomic, copy) NSString *title;
//@property(nonatomic, copy) NSString *detail;
//@property(nonatomic, copy) NSString *reward;
//@property(nonatomic, copy) NSString *poster;
//@property(nonatomic, copy) NSString *pcposter;
//@property(nonatomic, copy) NSString *deadline;
//@property(nonatomic, copy) NSString *starttime;
//@property(nonatomic, copy) NSString *endtime;
//@property(nonatomic, copy) NSString *membernum;
//@property(nonatomic, copy) NSString *resourcenum;
//@property(nonatomic, copy) NSString *uid;
//@property(nonatomic, copy) NSString *username;
//@property(nonatomic, copy) NSString *dateline;
//@property(nonatomic, copy) NSString *sort;
//@property(nonatomic, copy) NSString *sinablog;
//@property(nonatomic, copy) NSString *classid;
//@property(nonatomic, copy) NSString *eventid;
//
//@end
