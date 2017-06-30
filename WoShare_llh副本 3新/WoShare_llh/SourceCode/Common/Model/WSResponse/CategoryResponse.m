//
//  CategoryResponse.m
//
//  Created by 波 胡 on 13-8-21
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CategoryResponse.h"


NSString *const kCategoryResponseBiHeight = @"bi_height";
NSString *const kCategoryResponseBigimage = @"bigimage";
NSString *const kCategoryResponseDisplaymode = @"displaymode";
NSString *const kCategoryResponseCatid = @"catid";
NSString *const kCategoryResponseIdtype = @"idtype";
NSString *const kCategoryResponseIdlevel = @"idlevel";
NSString *const kCategoryResponseFlag = @"flag";
NSString *const kCategoryResponseGetcatemode = @"getcatemode";
NSString *const kCategoryResponsePushstatus = @"pushstatus";
NSString *const kCategoryResponseSort = @"sort";
NSString *const kCategoryResponseParams = @"params";
NSString *const kCategoryResponseImagename = @"imagename";
NSString *const kCategoryResponsePushinfoid = @"pushinfoid";
NSString *const kCategoryResponseSiWidth = @"si_width";
NSString *const kCategoryResponseSiHeight = @"si_height";
NSString *const kCategoryResponseCoverimage = @"coverimage";
NSString *const kCategoryResponseCode = @"code";
NSString *const kCategoryResponseLink = @"link";
NSString *const kCategoryResponseCiWidth = @"ci_width";
NSString *const kCategoryResponsePcid = @"pcid";
NSString *const kCategoryResponsePushdate = @"pushdate";
NSString *const kCategoryResponseSmallimage = @"smallimage";
NSString *const kCategoryResponsePrepushdate = @"prepushdate";
NSString *const kCategoryResponseCid = @"cid";
NSString *const kCategoryResponseShowmode = @"showmode";
NSString *const kCategoryResponseShowstart = @"showstart";
NSString *const kCategoryResponsePredrawdate = @"predrawdate";
NSString *const kCategoryResponseShowend = @"showend";
NSString *const kCategoryResponseDesc = @"desc";
NSString *const kCategoryResponseBiWidth = @"bi_width";
NSString *const kCategoryResponseGetdatascope = @"getdatascope";
NSString *const kCategoryResponseCiHeight = @"ci_height";
NSString *const kCategoryResponseGetdatamode = @"getdatamode";
NSString *const kCategoryResponseGetinfomode = @"getinfomode";
NSString *const kCategoryResponseExtend = @"extend";


@interface CategoryResponse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CategoryResponse

@synthesize biHeight = _biHeight;
@synthesize bigimage = _bigimage;
@synthesize displaymode = _displaymode;
@synthesize catid = _catid;
@synthesize idtype = _idtype;
@synthesize idlevel = _idlevel;
@synthesize flag = _flag;
@synthesize getcatemode = _getcatemode;
@synthesize pushstatus = _pushstatus;
@synthesize sort = _sort;
@synthesize params = _params;
@synthesize imagename = _imagename;
@synthesize pushinfoid = _pushinfoid;
@synthesize siWidth = _siWidth;
@synthesize siHeight = _siHeight;
@synthesize coverimage = _coverimage;
@synthesize code = _code;
@synthesize link = _link;
@synthesize ciWidth = _ciWidth;
@synthesize pcid = _pcid;
@synthesize pushdate = _pushdate;
@synthesize smallimage = _smallimage;
@synthesize prepushdate = _prepushdate;
@synthesize cid = _cid;
@synthesize showmode = _showmode;
@synthesize showstart = _showstart;
@synthesize predrawdate = _predrawdate;
@synthesize showend = _showend;
@synthesize desc = _desc;
@synthesize biWidth = _biWidth;
@synthesize getdatascope = _getdatascope;
@synthesize ciHeight = _ciHeight;
@synthesize getdatamode = _getdatamode;
@synthesize getinfomode = _getinfomode;
@synthesize extend = _extend;


+ (CategoryResponse *)modelObjectWithDictionary:(NSDictionary *)dict
{
    CategoryResponse *instance = [[CategoryResponse alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.biHeight = [self objectOrNilForKey:kCategoryResponseBiHeight fromDictionary:dict];
            self.bigimage = [self objectOrNilForKey:kCategoryResponseBigimage fromDictionary:dict];
            self.displaymode = [self objectOrNilForKey:kCategoryResponseDisplaymode fromDictionary:dict];
            self.catid = [self objectOrNilForKey:kCategoryResponseCatid fromDictionary:dict];
            self.idtype = [self objectOrNilForKey:kCategoryResponseIdtype fromDictionary:dict];
            self.idlevel = [self objectOrNilForKey:kCategoryResponseIdlevel fromDictionary:dict];
            self.flag = [self objectOrNilForKey:kCategoryResponseFlag fromDictionary:dict];
            self.getcatemode = [self objectOrNilForKey:kCategoryResponseGetcatemode fromDictionary:dict];
            self.pushstatus = [self objectOrNilForKey:kCategoryResponsePushstatus fromDictionary:dict];
            self.sort = [self objectOrNilForKey:kCategoryResponseSort fromDictionary:dict];
            self.params = [self objectOrNilForKey:kCategoryResponseParams fromDictionary:dict];
            self.imagename = [self objectOrNilForKey:kCategoryResponseImagename fromDictionary:dict];
            self.pushinfoid = [self objectOrNilForKey:kCategoryResponsePushinfoid fromDictionary:dict];
            self.siWidth = [self objectOrNilForKey:kCategoryResponseSiWidth fromDictionary:dict];
            self.siHeight = [self objectOrNilForKey:kCategoryResponseSiHeight fromDictionary:dict];
            self.coverimage = [self objectOrNilForKey:kCategoryResponseCoverimage fromDictionary:dict];
            self.code = [self objectOrNilForKey:kCategoryResponseCode fromDictionary:dict];
            self.link = [self objectOrNilForKey:kCategoryResponseLink fromDictionary:dict];
            self.ciWidth = [self objectOrNilForKey:kCategoryResponseCiWidth fromDictionary:dict];
            self.pcid = [self objectOrNilForKey:kCategoryResponsePcid fromDictionary:dict];
            self.pushdate = [self objectOrNilForKey:kCategoryResponsePushdate fromDictionary:dict];
            self.smallimage = [self objectOrNilForKey:kCategoryResponseSmallimage fromDictionary:dict];
            self.prepushdate = [self objectOrNilForKey:kCategoryResponsePrepushdate fromDictionary:dict];
            self.cid = [self objectOrNilForKey:kCategoryResponseCid fromDictionary:dict];
            self.showmode = [self objectOrNilForKey:kCategoryResponseShowmode fromDictionary:dict];
            self.showstart = [self objectOrNilForKey:kCategoryResponseShowstart fromDictionary:dict];
            self.predrawdate = [self objectOrNilForKey:kCategoryResponsePredrawdate fromDictionary:dict];
            self.showend = [self objectOrNilForKey:kCategoryResponseShowend fromDictionary:dict];
            self.desc = [self objectOrNilForKey:kCategoryResponseDesc fromDictionary:dict];
            self.biWidth = [self objectOrNilForKey:kCategoryResponseBiWidth fromDictionary:dict];
            self.getdatascope = [self objectOrNilForKey:kCategoryResponseGetdatascope fromDictionary:dict];
            self.ciHeight = [self objectOrNilForKey:kCategoryResponseCiHeight fromDictionary:dict];
            self.getdatamode = [self objectOrNilForKey:kCategoryResponseGetdatamode fromDictionary:dict];
            self.getinfomode = [self objectOrNilForKey:kCategoryResponseGetinfomode fromDictionary:dict];
            self.extend = [self objectOrNilForKey:kCategoryResponseExtend fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.biHeight forKey:kCategoryResponseBiHeight];
    [mutableDict setValue:self.bigimage forKey:kCategoryResponseBigimage];
    [mutableDict setValue:self.displaymode forKey:kCategoryResponseDisplaymode];
    [mutableDict setValue:self.catid forKey:kCategoryResponseCatid];
    [mutableDict setValue:self.idtype forKey:kCategoryResponseIdtype];
    [mutableDict setValue:self.idlevel forKey:kCategoryResponseIdlevel];
    [mutableDict setValue:self.flag forKey:kCategoryResponseFlag];
    [mutableDict setValue:self.getcatemode forKey:kCategoryResponseGetcatemode];
    [mutableDict setValue:self.pushstatus forKey:kCategoryResponsePushstatus];
    [mutableDict setValue:self.sort forKey:kCategoryResponseSort];
    [mutableDict setValue:self.params forKey:kCategoryResponseParams];
    [mutableDict setValue:self.imagename forKey:kCategoryResponseImagename];
    [mutableDict setValue:self.pushinfoid forKey:kCategoryResponsePushinfoid];
    [mutableDict setValue:self.siWidth forKey:kCategoryResponseSiWidth];
    [mutableDict setValue:self.siHeight forKey:kCategoryResponseSiHeight];
    [mutableDict setValue:self.coverimage forKey:kCategoryResponseCoverimage];
    [mutableDict setValue:self.code forKey:kCategoryResponseCode];
    [mutableDict setValue:self.link forKey:kCategoryResponseLink];
    [mutableDict setValue:self.ciWidth forKey:kCategoryResponseCiWidth];
    [mutableDict setValue:self.pcid forKey:kCategoryResponsePcid];
    [mutableDict setValue:self.pushdate forKey:kCategoryResponsePushdate];
    [mutableDict setValue:self.smallimage forKey:kCategoryResponseSmallimage];
    [mutableDict setValue:self.prepushdate forKey:kCategoryResponsePrepushdate];
    [mutableDict setValue:self.cid forKey:kCategoryResponseCid];
    [mutableDict setValue:self.showmode forKey:kCategoryResponseShowmode];
    [mutableDict setValue:self.showstart forKey:kCategoryResponseShowstart];
    [mutableDict setValue:self.predrawdate forKey:kCategoryResponsePredrawdate];
    [mutableDict setValue:self.showend forKey:kCategoryResponseShowend];
    [mutableDict setValue:self.desc forKey:kCategoryResponseDesc];
    [mutableDict setValue:self.biWidth forKey:kCategoryResponseBiWidth];
    [mutableDict setValue:self.getdatascope forKey:kCategoryResponseGetdatascope];
    [mutableDict setValue:self.ciHeight forKey:kCategoryResponseCiHeight];
    [mutableDict setValue:self.getdatamode forKey:kCategoryResponseGetdatamode];
    [mutableDict setValue:self.getinfomode forKey:kCategoryResponseGetinfomode];
    [mutableDict setValue:self.extend forKey:kCategoryResponseExtend];

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

    self.biHeight = [aDecoder decodeObjectForKey:kCategoryResponseBiHeight];
    self.bigimage = [aDecoder decodeObjectForKey:kCategoryResponseBigimage];
    self.displaymode = [aDecoder decodeObjectForKey:kCategoryResponseDisplaymode];
    self.catid = [aDecoder decodeObjectForKey:kCategoryResponseCatid];
    self.idtype = [aDecoder decodeObjectForKey:kCategoryResponseIdtype];
    self.idlevel = [aDecoder decodeObjectForKey:kCategoryResponseIdlevel];
    self.flag = [aDecoder decodeObjectForKey:kCategoryResponseFlag];
    self.getcatemode = [aDecoder decodeObjectForKey:kCategoryResponseGetcatemode];
    self.pushstatus = [aDecoder decodeObjectForKey:kCategoryResponsePushstatus];
    self.sort = [aDecoder decodeObjectForKey:kCategoryResponseSort];
    self.params = [aDecoder decodeObjectForKey:kCategoryResponseParams];
    self.imagename = [aDecoder decodeObjectForKey:kCategoryResponseImagename];
    self.pushinfoid = [aDecoder decodeObjectForKey:kCategoryResponsePushinfoid];
    self.siWidth = [aDecoder decodeObjectForKey:kCategoryResponseSiWidth];
    self.siHeight = [aDecoder decodeObjectForKey:kCategoryResponseSiHeight];
    self.coverimage = [aDecoder decodeObjectForKey:kCategoryResponseCoverimage];
    self.code = [aDecoder decodeObjectForKey:kCategoryResponseCode];
    self.link = [aDecoder decodeObjectForKey:kCategoryResponseLink];
    self.ciWidth = [aDecoder decodeObjectForKey:kCategoryResponseCiWidth];
    self.pcid = [aDecoder decodeObjectForKey:kCategoryResponsePcid];
    self.pushdate = [aDecoder decodeObjectForKey:kCategoryResponsePushdate];
    self.smallimage = [aDecoder decodeObjectForKey:kCategoryResponseSmallimage];
    self.prepushdate = [aDecoder decodeObjectForKey:kCategoryResponsePrepushdate];
    self.cid = [aDecoder decodeObjectForKey:kCategoryResponseCid];
    self.showmode = [aDecoder decodeObjectForKey:kCategoryResponseShowmode];
    self.showstart = [aDecoder decodeObjectForKey:kCategoryResponseShowstart];
    self.predrawdate = [aDecoder decodeObjectForKey:kCategoryResponsePredrawdate];
    self.showend = [aDecoder decodeObjectForKey:kCategoryResponseShowend];
    self.desc = [aDecoder decodeObjectForKey:kCategoryResponseDesc];
    self.biWidth = [aDecoder decodeObjectForKey:kCategoryResponseBiWidth];
    self.getdatascope = [aDecoder decodeObjectForKey:kCategoryResponseGetdatascope];
    self.ciHeight = [aDecoder decodeObjectForKey:kCategoryResponseCiHeight];
    self.getdatamode = [aDecoder decodeObjectForKey:kCategoryResponseGetdatamode];
    self.getinfomode = [aDecoder decodeObjectForKey:kCategoryResponseGetinfomode];
    self.extend = [aDecoder decodeObjectForKey:kCategoryResponseExtend];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_biHeight forKey:kCategoryResponseBiHeight];
    [aCoder encodeObject:_bigimage forKey:kCategoryResponseBigimage];
    [aCoder encodeObject:_displaymode forKey:kCategoryResponseDisplaymode];
    [aCoder encodeObject:_catid forKey:kCategoryResponseCatid];
    [aCoder encodeObject:_idtype forKey:kCategoryResponseIdtype];
    [aCoder encodeObject:_idlevel forKey:kCategoryResponseIdlevel];
    [aCoder encodeObject:_flag forKey:kCategoryResponseFlag];
    [aCoder encodeObject:_getcatemode forKey:kCategoryResponseGetcatemode];
    [aCoder encodeObject:_pushstatus forKey:kCategoryResponsePushstatus];
    [aCoder encodeObject:_sort forKey:kCategoryResponseSort];
    [aCoder encodeObject:_params forKey:kCategoryResponseParams];
    [aCoder encodeObject:_imagename forKey:kCategoryResponseImagename];
    [aCoder encodeObject:_pushinfoid forKey:kCategoryResponsePushinfoid];
    [aCoder encodeObject:_siWidth forKey:kCategoryResponseSiWidth];
    [aCoder encodeObject:_siHeight forKey:kCategoryResponseSiHeight];
    [aCoder encodeObject:_coverimage forKey:kCategoryResponseCoverimage];
    [aCoder encodeObject:_code forKey:kCategoryResponseCode];
    [aCoder encodeObject:_link forKey:kCategoryResponseLink];
    [aCoder encodeObject:_ciWidth forKey:kCategoryResponseCiWidth];
    [aCoder encodeObject:_pcid forKey:kCategoryResponsePcid];
    [aCoder encodeObject:_pushdate forKey:kCategoryResponsePushdate];
    [aCoder encodeObject:_smallimage forKey:kCategoryResponseSmallimage];
    [aCoder encodeObject:_prepushdate forKey:kCategoryResponsePrepushdate];
    [aCoder encodeObject:_cid forKey:kCategoryResponseCid];
    [aCoder encodeObject:_showmode forKey:kCategoryResponseShowmode];
    [aCoder encodeObject:_showstart forKey:kCategoryResponseShowstart];
    [aCoder encodeObject:_predrawdate forKey:kCategoryResponsePredrawdate];
    [aCoder encodeObject:_showend forKey:kCategoryResponseShowend];
    [aCoder encodeObject:_desc forKey:kCategoryResponseDesc];
    [aCoder encodeObject:_biWidth forKey:kCategoryResponseBiWidth];
    [aCoder encodeObject:_getdatascope forKey:kCategoryResponseGetdatascope];
    [aCoder encodeObject:_ciHeight forKey:kCategoryResponseCiHeight];
    [aCoder encodeObject:_getdatamode forKey:kCategoryResponseGetdatamode];
    [aCoder encodeObject:_getinfomode forKey:kCategoryResponseGetinfomode];
    [aCoder encodeObject:_extend forKey:kCategoryResponseExtend];
}


@end
