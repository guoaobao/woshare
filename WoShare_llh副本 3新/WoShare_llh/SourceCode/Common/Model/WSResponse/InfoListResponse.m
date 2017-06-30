//
//  InfoListResponse.m
//
//  Created by 波 胡 on 13-8-26
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "InfoListResponse.h"


NSString *const kInfoListResponseTitle = @"title";
NSString *const kInfoListResponseTags = @"tags";
NSString *const kInfoListResponseSst = @"sst";
NSString *const kInfoListResponsePich = @"pich";
NSString *const kInfoListResponseId = @"_id";
NSString *const kInfoListResponseBrief = @"brief";
NSString *const kInfoListResponsePrepushdate = @"prepushdate";
NSString *const kInfoListResponseAction = @"action";
NSString *const kInfoListResponsePicw = @"picw";
NSString *const kInfoListResponsePredrawdate = @"predrawdate";
NSString *const kInfoListResponseCt = @"ct";
NSString *const kInfoListResponseType = @"type";
NSString *const kInfoListResponsePic = @"pic";
NSString *const kInfoListResponseUid = @"uid";
NSString *const kInfoListResponsePayurl = @"payurl";
NSString *const kInfoListResponseCpid = @"cpid";
NSString *const kInfoListResponseAs = @"as";
NSString *const kInfoListResponseUt = @"ut";
NSString *const kInfoListResponseMs = @"ms";
NSString *const kInfoListResponseFee = @"fee";
NSString *const kInfoListResponsePid = @"pid";
NSString *const kInfoListResponseNsids = @"nsids";
NSString *const kInfoListResponseCids = @"cids";
NSString *const kInfoListResponseActionid = @"actionid";
NSString *const kInfoListResponseContent = @"content";
NSString *const kInfoListResponseDisplaymode = @"displaymode";


@interface InfoListResponse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation InfoListResponse

@synthesize title = _title;
@synthesize tags = _tags;
@synthesize sst = _sst;
@synthesize pich = _pich;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize brief = _brief;
@synthesize prepushdate = _prepushdate;
@synthesize action = _action;
@synthesize picw = _picw;
@synthesize predrawdate = _predrawdate;
@synthesize ct = _ct;
@synthesize type = _type;
@synthesize pic = _pic;
@synthesize uid = _uid;
@synthesize payurl = _payurl;
@synthesize cpid = _cpid;
@synthesize as = _as;
@synthesize ut = _ut;
@synthesize ms = _ms;
@synthesize fee = _fee;
@synthesize pid = _pid;
@synthesize nsids = _nsids;
@synthesize cids = _cids;
@synthesize actionid = _actionid;
@synthesize content = _content;
@synthesize displaymode = _displaymode;


+ (InfoListResponse *)modelObjectWithDictionary:(NSDictionary *)dict
{
    InfoListResponse *instance = [[InfoListResponse alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self._id = [self objectOrNilForKey:@"_id" fromDictionary:dict];
            self.title = [self objectOrNilForKey:kInfoListResponseTitle fromDictionary:dict];
        self.voteCount = [[self objectOrNilForKey:@"vts" fromDictionary:dict]integerValue];
            self.tags = [self objectOrNilForKey:kInfoListResponseTags fromDictionary:dict];
            self.sst = [[self objectOrNilForKey:kInfoListResponseSst fromDictionary:dict] doubleValue];
            self.pich = [[self objectOrNilForKey:kInfoListResponsePich fromDictionary:dict] doubleValue];
            self.internalBaseClassIdentifier = [self objectOrNilForKey:kInfoListResponseId fromDictionary:dict];
            self.brief = [self objectOrNilForKey:kInfoListResponseBrief fromDictionary:dict];
            self.prepushdate = [[self objectOrNilForKey:kInfoListResponsePrepushdate fromDictionary:dict] doubleValue];
            self.action = [self objectOrNilForKey:kInfoListResponseAction fromDictionary:dict];
            self.picw = [[self objectOrNilForKey:kInfoListResponsePicw fromDictionary:dict] doubleValue];
            self.predrawdate = [[self objectOrNilForKey:kInfoListResponsePredrawdate fromDictionary:dict] doubleValue];
            self.ct = [[self objectOrNilForKey:kInfoListResponseCt fromDictionary:dict] doubleValue];
            self.type = [self objectOrNilForKey:kInfoListResponseType fromDictionary:dict];
            self.pic = [self objectOrNilForKey:kInfoListResponsePic fromDictionary:dict];
            self.uid = [[self objectOrNilForKey:kInfoListResponseUid fromDictionary:dict]integerValue];
            self.payurl = [self objectOrNilForKey:kInfoListResponsePayurl fromDictionary:dict];
            self.cpid = [self objectOrNilForKey:kInfoListResponseCpid fromDictionary:dict];
            self.as = [[self objectOrNilForKey:kInfoListResponseAs fromDictionary:dict] doubleValue];
            self.ut = [[self objectOrNilForKey:kInfoListResponseUt fromDictionary:dict] doubleValue];
            self.ms = [[self objectOrNilForKey:kInfoListResponseMs fromDictionary:dict] doubleValue];
            self.fee = [self objectOrNilForKey:kInfoListResponseFee fromDictionary:dict];
            self.pid = [self objectOrNilForKey:kInfoListResponsePid fromDictionary:dict];
            self.nsids = [self objectOrNilForKey:kInfoListResponseNsids fromDictionary:dict];
            self.cids = [self objectOrNilForKey:kInfoListResponseCids fromDictionary:dict];
            self.actionid = [self objectOrNilForKey:kInfoListResponseActionid fromDictionary:dict];
            self.content = [self objectOrNilForKey:kInfoListResponseContent fromDictionary:dict];
            self.displaymode = [self objectOrNilForKey:kInfoListResponseDisplaymode fromDictionary:dict];
        self.hasfile = [self objectOrNilForKey:@"hasfile" fromDictionary:dict];
        self.pts = [[dict objectForKey:@"pts"]integerValue];
        self.dts = [[self objectOrNilForKey:@"dts" fromDictionary:dict]integerValue];
        self.fts = [[self objectOrNilForKey:@"fts" fromDictionary:dict]integerValue];
        self.cts = [[self objectOrNilForKey:@"cts" fromDictionary:dict]integerValue];
        if (_pts == 0)
        {
            self.likedCount = @"0";
        }
        else
        {
            self.likedCount = [NSString stringWithFormat:@"%d",_pts];
        }
        self.publishTime = [NSString stringWithDate:[NSDate dateWithTimeIntervalSince1970:[[dict objectForKey:@"sst"] floatValue]] formater:@"yyyy-MM-dd"];
        self.infoType =[[self objectOrNilForKey:@"ft" fromDictionary:dict]integerValue];
//        self.infoType = 3;
        if ([self.brief length]==0&&[self.content length]!=0) {
            self.brief = self.content;
        }
        else if ([self.brief length]!=0&&[self.content length]==0)
        {
            self.content = self.brief;
        }
    }
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.title forKey:kInfoListResponseTitle];
NSMutableArray *tempArrayForTags = [NSMutableArray array];
    for (NSObject *subArrayObject in self.tags) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTags addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTags addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTags] forKey:@"kInfoListResponseTags"];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sst] forKey:kInfoListResponseSst];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pich] forKey:kInfoListResponsePich];
    [mutableDict setValue:self.internalBaseClassIdentifier forKey:kInfoListResponseId];
    [mutableDict setValue:self.brief forKey:kInfoListResponseBrief];
    [mutableDict setValue:[NSNumber numberWithDouble:self.prepushdate] forKey:kInfoListResponsePrepushdate];
    [mutableDict setValue:self.action forKey:kInfoListResponseAction];
    [mutableDict setValue:[NSNumber numberWithDouble:self.picw] forKey:kInfoListResponsePicw];
    [mutableDict setValue:[NSNumber numberWithDouble:self.predrawdate] forKey:kInfoListResponsePredrawdate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.ct] forKey:kInfoListResponseCt];
    [mutableDict setValue:self.type forKey:kInfoListResponseType];
    [mutableDict setValue:[NSNumber numberWithInt:self.uid] forKey:kInfoListResponseUid];
    [mutableDict setValue:self.cpid forKey:kInfoListResponseCpid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.as] forKey:kInfoListResponseAs];
    [mutableDict setValue:[NSNumber numberWithDouble:self.ut] forKey:kInfoListResponseUt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.ms] forKey:kInfoListResponseMs];
    [mutableDict setValue:self.fee forKey:kInfoListResponseFee];
    [mutableDict setValue:self.pid forKey:kInfoListResponsePid];
NSMutableArray *tempArrayForNsids = [NSMutableArray array];
    for (NSObject *subArrayObject in self.nsids) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForNsids addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForNsids addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForNsids] forKey:@"kInfoListResponseNsids"];
NSMutableArray *tempArrayForCids = [NSMutableArray array];
    for (NSObject *subArrayObject in self.cids) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForCids addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForCids addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForCids] forKey:@"kInfoListResponseCids"];
    [mutableDict setValue:self.actionid forKey:kInfoListResponseActionid];
    [mutableDict setValue:self.content forKey:kInfoListResponseContent];
    [mutableDict setValue:self.displaymode forKey:kInfoListResponseDisplaymode];

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


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.title = [aDecoder decodeObjectForKey:kInfoListResponseTitle];
    self.tags = [aDecoder decodeObjectForKey:kInfoListResponseTags];
    self.sst = [aDecoder decodeDoubleForKey:kInfoListResponseSst];
    self.pich = [aDecoder decodeDoubleForKey:kInfoListResponsePich];
    self.internalBaseClassIdentifier = [aDecoder decodeObjectForKey:kInfoListResponseId];
    self.brief = [aDecoder decodeObjectForKey:kInfoListResponseBrief];
    self.prepushdate = [aDecoder decodeDoubleForKey:kInfoListResponsePrepushdate];
    self.action = [aDecoder decodeObjectForKey:kInfoListResponseAction];
    self.picw = [aDecoder decodeDoubleForKey:kInfoListResponsePicw];
    self.predrawdate = [aDecoder decodeDoubleForKey:kInfoListResponsePredrawdate];
    self.ct = [aDecoder decodeDoubleForKey:kInfoListResponseCt];
    self.type = [aDecoder decodeObjectForKey:kInfoListResponseType];
    self.pic = [aDecoder decodeObjectForKey:kInfoListResponsePic];
//    self.uid = [aDecoder decodeObjectForKey:kInfoListResponseUid];
    self.payurl = [aDecoder decodeObjectForKey:kInfoListResponsePayurl];
    self.cpid = [aDecoder decodeObjectForKey:kInfoListResponseCpid];
    self.as = [aDecoder decodeDoubleForKey:kInfoListResponseAs];
    self.ut = [aDecoder decodeDoubleForKey:kInfoListResponseUt];
    self.ms = [aDecoder decodeDoubleForKey:kInfoListResponseMs];
    self.fee = [aDecoder decodeObjectForKey:kInfoListResponseFee];
    self.pid = [aDecoder decodeObjectForKey:kInfoListResponsePid];
    self.nsids = [aDecoder decodeObjectForKey:kInfoListResponseNsids];
    self.cids = [aDecoder decodeObjectForKey:kInfoListResponseCids];
    self.actionid = [aDecoder decodeObjectForKey:kInfoListResponseActionid];
    self.content = [aDecoder decodeObjectForKey:kInfoListResponseContent];
    self.displaymode = [aDecoder decodeObjectForKey:kInfoListResponseDisplaymode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_title forKey:kInfoListResponseTitle];
    [aCoder encodeObject:_tags forKey:kInfoListResponseTags];
    [aCoder encodeDouble:_sst forKey:kInfoListResponseSst];
    [aCoder encodeDouble:_pich forKey:kInfoListResponsePich];
    [aCoder encodeObject:_internalBaseClassIdentifier forKey:kInfoListResponseId];
    [aCoder encodeObject:_brief forKey:kInfoListResponseBrief];
    [aCoder encodeDouble:_prepushdate forKey:kInfoListResponsePrepushdate];
    [aCoder encodeObject:_action forKey:kInfoListResponseAction];
    [aCoder encodeDouble:_picw forKey:kInfoListResponsePicw];
    [aCoder encodeDouble:_predrawdate forKey:kInfoListResponsePredrawdate];
    [aCoder encodeDouble:_ct forKey:kInfoListResponseCt];
    [aCoder encodeObject:_type forKey:kInfoListResponseType];
    [aCoder encodeObject:_pic forKey:kInfoListResponsePic];
//    [aCoder encodeObject:_uid forKey:kInfoListResponseUid];
    [aCoder encodeObject:_payurl forKey:kInfoListResponsePayurl];
    [aCoder encodeObject:_cpid forKey:kInfoListResponseCpid];
    [aCoder encodeDouble:_as forKey:kInfoListResponseAs];
    [aCoder encodeDouble:_ut forKey:kInfoListResponseUt];
    [aCoder encodeDouble:_ms forKey:kInfoListResponseMs];
    [aCoder encodeObject:_fee forKey:kInfoListResponseFee];
    [aCoder encodeObject:_pid forKey:kInfoListResponsePid];
    [aCoder encodeObject:_nsids forKey:kInfoListResponseNsids];
    [aCoder encodeObject:_cids forKey:kInfoListResponseCids];
    [aCoder encodeObject:_actionid forKey:kInfoListResponseActionid];
    [aCoder encodeObject:_content forKey:kInfoListResponseContent];
    [aCoder encodeObject:_displaymode forKey:kInfoListResponseDisplaymode];
}

- (NSString *)getBiggestImageURLString
{
    if ([self.pic count] >= 4)
    {
        return [self.pic objectForKey:@"1"];
    }
    return nil;
}
- (NSString *)getMidImageURlString
{
    if ([self.pic count] >= 4)
    {
        return [self.pic objectForKey:@"2"];
    }
    return  nil;
}

- (NSString *)getSmallestImageURLString
{
    if ([self.pic count] >= 4)
    {
        return [self.pic objectForKey:@"3"];
    }
    return  nil;
}


@end
