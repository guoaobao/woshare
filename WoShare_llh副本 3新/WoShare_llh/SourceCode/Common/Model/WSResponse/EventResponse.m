//
//  EventResponse.m
//
//  Created by 波 胡 on 13-11-1
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EventResponse.h"


NSString *const kEventResponseMembernum = @"membernum";
NSString *const kEventResponseTopicid = @"topicid";
NSString *const kEventResponseGrade = @"grade";
NSString *const kEventResponseMaxvote = @"maxvote";
NSString *const kEventResponseEventid = @"eventid";
NSString *const kEventResponseRemote = @"remote";
NSString *const kEventResponseProvince = @"province";
NSString *const kEventResponseUsername = @"username";
NSString *const kEventResponseAllowinvite = @"allowinvite";
NSString *const kEventResponseEventtype = @"eventtype";
NSString *const kEventResponseTitle = @"title";
NSString *const kEventResponseWlurl = @"wlurl";
NSString *const kEventResponseViewnum = @"viewnum";
NSString *const kEventResponseLimitnum = @"limitnum";
NSString *const kEventResponseReward = @"reward";
NSString *const kEventResponseAllowpost = @"allowpost";
NSString *const kEventResponseCmtcachetime = @"cmtcachetime";
NSString *const kEventResponseSinablog = @"sinablog";
NSString *const kEventResponseUsercachetime = @"usercachetime";
NSString *const kEventResponseDateline = @"dateline";
NSString *const kEventResponseRecommendtime = @"recommendtime";
NSString *const kEventResponseUserlastcache = @"userlastcache";
NSString *const kEventResponseFilecachetime = @"filecachetime";
NSString *const kEventResponseLocation = @"location";
NSString *const kEventResponseFilelastcache = @"filelastcache";
NSString *const kEventResponseEndtime = @"endtime";
NSString *const kEventResponseSort = @"sort";
NSString *const kEventResponseAward = @"award";
NSString *const kEventResponseThumb = @"thumb";
NSString *const kEventResponseDeadline = @"deadline";
NSString *const kEventResponsePoster = @"poster";
NSString *const kEventResponseAllowpic = @"allowpic";
NSString *const kEventResponseEventfiles = @"eventfiles";
NSString *const kEventResponseMents = @"ments";
NSString *const kEventResponseCids = @"cids";
NSString *const kEventResponseShowmode = @"showmode";
NSString *const kEventResponseHotcomment = @"hotcomment";
NSString *const kEventResponseStarttime = @"starttime";
NSString *const kEventResponseUid = @"uid";
NSString *const kEventResponseCmtlastcache = @"cmtlastcache";
NSString *const kEventResponseClassid = @"classid";
NSString *const kEventResponseHotuser = @"hotuser";
NSString *const kEventResponseVerify = @"verify";
NSString *const kEventResponseEventstatus = @"eventstatus";
NSString *const kEventResponseFollownum = @"follownum";
NSString *const kEventResponsePcposter = @"pcposter";
NSString *const kEventResponseCity = @"city";
NSString *const kEventResponseHot = @"hot";
NSString *const kEventResponseDetail = @"detail";
NSString *const kEventResponseAllowfellow = @"allowfellow";
NSString *const kEventResponseResourcenum = @"resourcenum";
NSString *const kEventResponseUpdatetime = @"updatetime";


@interface EventResponse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation EventResponse

@synthesize membernum = _membernum;
@synthesize topicid = _topicid;
@synthesize grade = _grade;
@synthesize maxvote = _maxvote;
@synthesize eventid = _eventid;
@synthesize remote = _remote;
@synthesize province = _province;
@synthesize username = _username;
@synthesize allowinvite = _allowinvite;
@synthesize eventtype = _eventtype;
@synthesize title = _title;
@synthesize wlurl = _wlurl;
@synthesize viewnum = _viewnum;
@synthesize limitnum = _limitnum;
@synthesize reward = _reward;
@synthesize allowpost = _allowpost;
@synthesize cmtcachetime = _cmtcachetime;
@synthesize sinablog = _sinablog;
@synthesize usercachetime = _usercachetime;
@synthesize dateline = _dateline;
@synthesize recommendtime = _recommendtime;
@synthesize userlastcache = _userlastcache;
@synthesize filecachetime = _filecachetime;
@synthesize location = _location;
@synthesize filelastcache = _filelastcache;
@synthesize endtime = _endtime;
@synthesize sort = _sort;
@synthesize award = _award;
@synthesize thumb = _thumb;
@synthesize deadline = _deadline;
@synthesize poster = _poster;
@synthesize allowpic = _allowpic;
@synthesize eventfiles = _eventfiles;
@synthesize ments = _ments;
@synthesize cids = _cids;
@synthesize showmode = _showmode;
@synthesize hotcomment = _hotcomment;
@synthesize starttime = _starttime;
@synthesize uid = _uid;
@synthesize cmtlastcache = _cmtlastcache;
@synthesize classid = _classid;
@synthesize hotuser = _hotuser;
@synthesize verify = _verify;
@synthesize eventstatus = _eventstatus;
@synthesize follownum = _follownum;
@synthesize pcposter = _pcposter;
@synthesize city = _city;
@synthesize hot = _hot;
@synthesize detail = _detail;
@synthesize allowfellow = _allowfellow;
@synthesize resourcenum = _resourcenum;
@synthesize updatetime = _updatetime;

-(id)initWithDict:(NSDictionary *)dict withRequestType:(RequestType)requestType
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.membernum = [self objectOrNilForKey:kEventResponseMembernum fromDictionary:dict];
        self.topicid = [self objectOrNilForKey:kEventResponseTopicid fromDictionary:dict];
        self.grade = [self objectOrNilForKey:kEventResponseGrade fromDictionary:dict];
        self.maxvote = [self objectOrNilForKey:kEventResponseMaxvote fromDictionary:dict];
        self.eventid = [self objectOrNilForKey:kEventResponseEventid fromDictionary:dict];
        self.remote = [self objectOrNilForKey:kEventResponseRemote fromDictionary:dict];
        self.province = [self objectOrNilForKey:kEventResponseProvince fromDictionary:dict];
        self.username = [self objectOrNilForKey:kEventResponseUsername fromDictionary:dict];
        self.allowinvite = [self objectOrNilForKey:kEventResponseAllowinvite fromDictionary:dict];
        
        self.title = [self objectOrNilForKey:kEventResponseTitle fromDictionary:dict];
        self.wlurl = [self objectOrNilForKey:kEventResponseWlurl fromDictionary:dict];
        self.viewnum = [self objectOrNilForKey:kEventResponseViewnum fromDictionary:dict];
        self.limitnum = [self objectOrNilForKey:kEventResponseLimitnum fromDictionary:dict];
        self.reward = [self objectOrNilForKey:kEventResponseReward fromDictionary:dict];
        self.allowpost = [self objectOrNilForKey:kEventResponseAllowpost fromDictionary:dict];
        self.cmtcachetime = [self objectOrNilForKey:kEventResponseCmtcachetime fromDictionary:dict];
        self.sinablog = [self objectOrNilForKey:kEventResponseSinablog fromDictionary:dict];
        self.usercachetime = [self objectOrNilForKey:kEventResponseUsercachetime fromDictionary:dict];
        self.dateline = [self objectOrNilForKey:kEventResponseDateline fromDictionary:dict];
        self.recommendtime = [self objectOrNilForKey:kEventResponseRecommendtime fromDictionary:dict];
        self.userlastcache = [self objectOrNilForKey:kEventResponseUserlastcache fromDictionary:dict];
        self.filecachetime = [self objectOrNilForKey:kEventResponseFilecachetime fromDictionary:dict];
        self.location = [self objectOrNilForKey:kEventResponseLocation fromDictionary:dict];
        self.filelastcache = [self objectOrNilForKey:kEventResponseFilelastcache fromDictionary:dict];
        self.endtime = [self objectOrNilForKey:kEventResponseEndtime fromDictionary:dict];
        self.sort = [self objectOrNilForKey:kEventResponseSort fromDictionary:dict];
        self.award = [self objectOrNilForKey:kEventResponseAward fromDictionary:dict];
        self.thumb = [self objectOrNilForKey:kEventResponseThumb fromDictionary:dict];
        self.deadline = [self objectOrNilForKey:kEventResponseDeadline fromDictionary:dict];
        self.poster = [self objectOrNilForKey:kEventResponsePoster fromDictionary:dict];
        self.allowpic = [self objectOrNilForKey:kEventResponseAllowpic fromDictionary:dict];
        self.eventfiles = [self objectOrNilForKey:kEventResponseEventfiles fromDictionary:dict];
        self.ments = [self objectOrNilForKey:kEventResponseMents fromDictionary:dict];
        self.cids = [self objectOrNilForKey:kEventResponseCids fromDictionary:dict];
        self.showmode = [self objectOrNilForKey:kEventResponseShowmode fromDictionary:dict];
        self.hotcomment = [self objectOrNilForKey:kEventResponseHotcomment fromDictionary:dict];
        self.starttime = [self objectOrNilForKey:kEventResponseStarttime fromDictionary:dict];
        self.uid = [self objectOrNilForKey:kEventResponseUid fromDictionary:dict];
        self.cmtlastcache = [self objectOrNilForKey:kEventResponseCmtlastcache fromDictionary:dict];
        self.classid = [self objectOrNilForKey:kEventResponseClassid fromDictionary:dict];
        self.hotuser = [self objectOrNilForKey:kEventResponseHotuser fromDictionary:dict];
        self.verify = [self objectOrNilForKey:kEventResponseVerify fromDictionary:dict];
        
        self.follownum = [self objectOrNilForKey:kEventResponseFollownum fromDictionary:dict];
        self.pcposter = [self objectOrNilForKey:kEventResponsePcposter fromDictionary:dict];
        self.city = [self objectOrNilForKey:kEventResponseCity fromDictionary:dict];
        self.hot = [self objectOrNilForKey:kEventResponseHot fromDictionary:dict];
        self.detail = [self objectOrNilForKey:kEventResponseDetail fromDictionary:dict];
        self.allowfellow = [self objectOrNilForKey:kEventResponseAllowfellow fromDictionary:dict];
        self.resourcenum = [self objectOrNilForKey:kEventResponseResourcenum fromDictionary:dict];
        self.updatetime = [self objectOrNilForKey:kEventResponseUpdatetime fromDictionary:dict];
        self.eventstatus = [[self objectOrNilForKey:kEventResponseEventstatus fromDictionary:dict] integerValue];
        switch (_eventstatus)
        {
            case 0:
                self.eventstatus = kEventStatusAll;
                break;
            case 1:
                self.eventstatus = kEventStatusWaiting;
                break;
            case 3:
                self.eventstatus = kEventStatusOnline;
                break;
            case 4:
                self.eventstatus = kEventStatusFinish;
                break;
            default:
                break;
        }
        self.eventtype = [self objectOrNilForKey:kEventResponseEventtype fromDictionary:dict];
        switch ([self.eventtype integerValue])
        {
            case 0:
                self.type = kEventTypeAll;
                break;
            case 1:
                self.type = kEventTypePic;
                break;
            case 2:
                self.type = kEventTypeOther;
                break;
            case 3:
                self.type = kEventTypeURL;
                break;
            default:
                self.type = kEventTypePic;
                break;
        }
    }
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.membernum forKey:kEventResponseMembernum];
    [mutableDict setValue:self.topicid forKey:kEventResponseTopicid];
    [mutableDict setValue:self.grade forKey:kEventResponseGrade];
    [mutableDict setValue:self.maxvote forKey:kEventResponseMaxvote];
    [mutableDict setValue:self.eventid forKey:kEventResponseEventid];
    [mutableDict setValue:self.remote forKey:kEventResponseRemote];
    [mutableDict setValue:self.province forKey:kEventResponseProvince];
    [mutableDict setValue:self.username forKey:kEventResponseUsername];
    [mutableDict setValue:self.allowinvite forKey:kEventResponseAllowinvite];
    [mutableDict setValue:self.eventtype forKey:kEventResponseEventtype];
    [mutableDict setValue:self.title forKey:kEventResponseTitle];
    [mutableDict setValue:self.wlurl forKey:kEventResponseWlurl];
    [mutableDict setValue:self.viewnum forKey:kEventResponseViewnum];
    [mutableDict setValue:self.limitnum forKey:kEventResponseLimitnum];
    [mutableDict setValue:self.reward forKey:kEventResponseReward];
    [mutableDict setValue:self.allowpost forKey:kEventResponseAllowpost];
    [mutableDict setValue:self.cmtcachetime forKey:kEventResponseCmtcachetime];
    [mutableDict setValue:self.sinablog forKey:kEventResponseSinablog];
    [mutableDict setValue:self.usercachetime forKey:kEventResponseUsercachetime];
    [mutableDict setValue:self.dateline forKey:kEventResponseDateline];
    [mutableDict setValue:self.recommendtime forKey:kEventResponseRecommendtime];
    [mutableDict setValue:self.userlastcache forKey:kEventResponseUserlastcache];
    [mutableDict setValue:self.filecachetime forKey:kEventResponseFilecachetime];
    [mutableDict setValue:self.location forKey:kEventResponseLocation];
    [mutableDict setValue:self.filelastcache forKey:kEventResponseFilelastcache];
    [mutableDict setValue:self.endtime forKey:kEventResponseEndtime];
    [mutableDict setValue:self.sort forKey:kEventResponseSort];
    [mutableDict setValue:self.award forKey:kEventResponseAward];
    [mutableDict setValue:self.thumb forKey:kEventResponseThumb];
    [mutableDict setValue:self.deadline forKey:kEventResponseDeadline];
    [mutableDict setValue:self.poster forKey:kEventResponsePoster];
    [mutableDict setValue:self.allowpic forKey:kEventResponseAllowpic];
    NSMutableArray *tempArrayForEventfiles = [NSMutableArray array];
    for (NSObject *subArrayObject in self.eventfiles) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForEventfiles addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForEventfiles addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForEventfiles] forKey:@"kEventResponseEventfiles"];
    [mutableDict setValue:self.ments forKey:kEventResponseMents];
    [mutableDict setValue:self.cids forKey:kEventResponseCids];
    [mutableDict setValue:self.showmode forKey:kEventResponseShowmode];
    NSMutableArray *tempArrayForHotcomment = [NSMutableArray array];
    for (NSObject *subArrayObject in self.hotcomment) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForHotcomment addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForHotcomment addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForHotcomment] forKey:@"kEventResponseHotcomment"];
    [mutableDict setValue:self.starttime forKey:kEventResponseStarttime];
    [mutableDict setValue:self.uid forKey:kEventResponseUid];
    [mutableDict setValue:self.cmtlastcache forKey:kEventResponseCmtlastcache];
    [mutableDict setValue:self.classid forKey:kEventResponseClassid];
    NSMutableArray *tempArrayForHotuser = [NSMutableArray array];
    for (NSObject *subArrayObject in self.hotuser) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForHotuser addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForHotuser addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForHotuser] forKey:@"kEventResponseHotuser"];
    [mutableDict setValue:self.verify forKey:kEventResponseVerify];
    [mutableDict setValue:[NSNumber numberWithDouble:self.eventstatus] forKey:kEventResponseEventstatus];
    [mutableDict setValue:self.follownum forKey:kEventResponseFollownum];
    [mutableDict setValue:self.pcposter forKey:kEventResponsePcposter];
    [mutableDict setValue:self.city forKey:kEventResponseCity];
    [mutableDict setValue:self.hot forKey:kEventResponseHot];
    [mutableDict setValue:self.detail forKey:kEventResponseDetail];
    [mutableDict setValue:self.allowfellow forKey:kEventResponseAllowfellow];
    [mutableDict setValue:self.resourcenum forKey:kEventResponseResourcenum];
    [mutableDict setValue:self.updatetime forKey:kEventResponseUpdatetime];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
