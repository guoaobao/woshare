//
//  UserInfoResponse.m
//  QYSDK
//
//  Created by 胡 波 on 13-4-23.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "UserInfoResponse.h"

@implementation UserInfoResponse
@synthesize adddisksize = _adddisksize;
@synthesize birthprovince = _birthprovince;
@synthesize qqauthinfo = _qqauthinfo;
@synthesize account = _account;
@synthesize sharestatus = _sharestatus;
@synthesize sex = _sex;
@synthesize newpm = _newpm;
@synthesize credit = _credit;
@synthesize username = _username;
@synthesize salt = _salt;
@synthesize edateline = _edateline;
@synthesize password = _password;
@synthesize experience = _experience;
@synthesize birthcity = _birthcity;
@synthesize commstatus = _commstatus;
@synthesize shareillecount = _shareillecount;
@synthesize preconfig = _preconfig;
@synthesize broadbandcheck = _broadbandcheck;
@synthesize flag = _flag;
@synthesize avatar = _avatar;
@synthesize msnrobot = _msnrobot;
@synthesize residecity = _residecity;
@synthesize accountvaliddate = _accountvaliddate;
@synthesize grouptitle = _grouptitle;
@synthesize lastbrief = _lastbrief;
@synthesize freezedate = _freezedate;
@synthesize videopic = _videopic;
@synthesize lastnsid = _lastnsid;
@synthesize price = _price;
@synthesize sinaauthinfo = _sinaauthinfo;
@synthesize token = _token;
@synthesize lastlogintime = _lastlogintime;
@synthesize birthmonth = _birthmonth;
@synthesize regdate = _regdate;
@synthesize spacepic = _spacepic;
@synthesize freezereason = _freezereason;
@synthesize mood = _mood;
@synthesize qq = _qq;
@synthesize msn = _msn;
@synthesize msncstatus = _msncstatus;
@synthesize newnoteresource = _newnoteresource;
@synthesize firstaccounttype = _firstaccounttype;
@synthesize applynum = _applynum;
@synthesize email = _email;
@synthesize sharenum = _sharenum;
@synthesize diskusesize = _diskusesize;
@synthesize newfeed = _newfeed;
@synthesize system = _system;
@synthesize mobilecheck = _mobilecheck;
@synthesize vipgroupid = _vipgroupid;
@synthesize loginnum = _loginnum;
@synthesize fansnum = _fansnum;
@synthesize lastsearch = _lastsearch;
@synthesize birthyear = _birthyear;
@synthesize birthday = _birthday;
@synthesize bdateline = _bdateline;
@synthesize accounttype = _accounttype;
@synthesize sharedate = _sharedate;
@synthesize uid = _uid;
@synthesize blood = _blood;
@synthesize disksize = _disksize;
@synthesize emailcheck = _emailcheck;
@synthesize notenum = _notenum;
@synthesize favoritenum = _favoritenum;
@synthesize lastpost = _lastpost;
@synthesize backconfig = _backconfig;
@synthesize mobile = _mobile;
@synthesize marry = _marry;
@synthesize groupid = _groupid;
@synthesize broadband = _broadband;
@synthesize newcomment = _newcomment;
@synthesize commdate = _commdate;
@synthesize commillecount = _commillecount;
@synthesize resideprovince = _resideprovince;
@synthesize sinaname = _sinaname;
@synthesize sinauid = _sinauid;
@synthesize tjsource = _tjsource;
@synthesize truename = _truename;
-(id)initWithDict:(NSDictionary *)dict withRequestType:(RequestType)requestType
{
    self = [super initWithDict:dict withRequestType:requestType];
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self.adddisksize = [self objectOrNilForKey:@"adddisksize" fromDictionary:dict];
        self.birthprovince = [self objectOrNilForKey:@"birthprovince" fromDictionary:dict];
        self.qqauthinfo = [self objectOrNilForKey:@"qqauthinfo" fromDictionary:dict];
        self.account = [self objectOrNilForKey:@"account" fromDictionary:dict];
        self.sharestatus = [self objectOrNilForKey:@"sharestatus" fromDictionary:dict];
        self.sex = [[self objectOrNilForKey:@"sex" fromDictionary:dict]isKindOfClass:[NSNull class]]?0:[[self objectOrNilForKey:@"sex" fromDictionary:dict]integerValue];
        self.newpm = [self objectOrNilForKey:@"newpm" fromDictionary:dict];
        self.credit = [self objectOrNilForKey:@"credit" fromDictionary:dict];
        self.oldname = [self objectOrNilForKey:@"username" fromDictionary:dict];
        self.username = [self objectOrNilForKey:@"username" fromDictionary:dict];
        self.username = [NSString deletePhoneNumber:self.username];
        self.salt = [self objectOrNilForKey:@"salt" fromDictionary:dict];
        self.edateline = [self objectOrNilForKey:@"edateline" fromDictionary:dict];
        self.password = [self objectOrNilForKey:@"password" fromDictionary:dict];
        self.experience = [self objectOrNilForKey:@"experience" fromDictionary:dict];
        self.birthcity = [self objectOrNilForKey:@"birthcity" fromDictionary:dict];
        self.commstatus = [self objectOrNilForKey:@"commstatus" fromDictionary:dict];
        self.shareillecount = [self objectOrNilForKey:@"shareillecount" fromDictionary:dict];
        self.preconfig = [self objectOrNilForKey:@"preconfig" fromDictionary:dict];
        self.broadbandcheck = [self objectOrNilForKey:@"broadbandcheck" fromDictionary:dict];
        self.flag = [self objectOrNilForKey:@"flag" fromDictionary:dict];
        self.avatar = [[self objectOrNilForKey:@"avatar" fromDictionary:dict]isKindOfClass:[NSNull class]]?@"":[self objectOrNilForKey:@"avatar" fromDictionary:dict];
        self.msnrobot = [self objectOrNilForKey:@"msnrobot" fromDictionary:dict];
        self.residecity = [self objectOrNilForKey:@"residecity" fromDictionary:dict];
        self.accountvaliddate = [self objectOrNilForKey:@"accountvaliddate" fromDictionary:dict];
        self.grouptitle = [self objectOrNilForKey:@"grouptitle" fromDictionary:dict];
        self.lastbrief = [self objectOrNilForKey:@"lastbrief" fromDictionary:dict];
        self.freezedate = [self objectOrNilForKey:@"freezedate" fromDictionary:dict];
        self.videopic = [self objectOrNilForKey:@"videopic" fromDictionary:dict];
        self.lastnsid = [self objectOrNilForKey:@"lastnsid" fromDictionary:dict];
        self.price = [self objectOrNilForKey:@"price" fromDictionary:dict];
        self.sinaauthinfo = [self objectOrNilForKey:@"sinaauthinfo" fromDictionary:dict];
        self.token = [self objectOrNilForKey:@"token" fromDictionary:dict];
        self.lastlogintime = [self objectOrNilForKey:@"lastlogintime" fromDictionary:dict];
        self.birthmonth = [self objectOrNilForKey:@"birthmonth" fromDictionary:dict];
        self.regdate = [self objectOrNilForKey:@"regdate" fromDictionary:dict];
        self.spacepic = [self objectOrNilForKey:@"spacepic" fromDictionary:dict];
        self.freezereason = [self objectOrNilForKey:@"freezereason" fromDictionary:dict];
        self.mood = [self objectOrNilForKey:@"mood" fromDictionary:dict];
        self.qq = [self objectOrNilForKey:@"qq" fromDictionary:dict];
        self.msn = [self objectOrNilForKey:@"msn" fromDictionary:dict];
        self.msncstatus = [self objectOrNilForKey:@"msncstatus" fromDictionary:dict];
        self.newnoteresource = [[dict objectForKey:@"newnoteresource"] doubleValue];
        self.firstaccounttype = [self objectOrNilForKey:@"firstaccounttype" fromDictionary:dict];
        self.applynum = [self objectOrNilForKey:@"applynum" fromDictionary:dict];
        self.email = [self objectOrNilForKey:@"email" fromDictionary:dict];
        self.sharenum = [self objectOrNilForKey:@"sharenum" fromDictionary:dict];
        self.diskusesize = [self objectOrNilForKey:@"diskusesize" fromDictionary:dict];
        self.newfeed = [self objectOrNilForKey:@"newfeed" fromDictionary:dict];
        self.system = [self objectOrNilForKey:@"system" fromDictionary:dict];
        self.mobilecheck = [self objectOrNilForKey:@"mobilecheck" fromDictionary:dict];
        self.vipgroupid = [self objectOrNilForKey:@"vipgroupid" fromDictionary:dict];
        self.loginnum = [self objectOrNilForKey:@"loginnum" fromDictionary:dict];
        self.fansnum = [self objectOrNilForKey:@"fansnum" fromDictionary:dict];
        self.lastsearch = [self objectOrNilForKey:@"lastsearch" fromDictionary:dict];
        self.birthyear = [self objectOrNilForKey:@"birthyear" fromDictionary:dict];
        self.birthday = [self objectOrNilForKey:@"birthday" fromDictionary:dict];
        self.bdateline = [self objectOrNilForKey:@"bdateline" fromDictionary:dict];
        self.accounttype = [self objectOrNilForKey:@"accounttype" fromDictionary:dict];
        self.sharedate = [self objectOrNilForKey:@"sharedate" fromDictionary:dict];
        self.uid = [self objectOrNilForKey:@"uid" fromDictionary:dict];
        self.blood = [self objectOrNilForKey:@"blood" fromDictionary:dict];
        self.disksize = [self objectOrNilForKey:@"disksize" fromDictionary:dict];
        self.emailcheck = [self objectOrNilForKey:@"emailcheck" fromDictionary:dict];
        self.notenum = [self objectOrNilForKey:@"notenum" fromDictionary:dict];
        self.favoritenum = [self objectOrNilForKey:@"favoritenum" fromDictionary:dict];
        self.lastpost = [self objectOrNilForKey:@"lastpost" fromDictionary:dict];
        self.backconfig = [self objectOrNilForKey:@"backconfig" fromDictionary:dict];
        self.mobile = [self objectOrNilForKey:@"mobile" fromDictionary:dict];
        self.marry = [self objectOrNilForKey:@"marry" fromDictionary:dict];
        self.groupid = [self objectOrNilForKey:@"groupid" fromDictionary:dict];
        self.broadband = [self objectOrNilForKey:@"broadband" fromDictionary:dict];
        self.newcomment = [self objectOrNilForKey:@"newcomment" fromDictionary:dict];
        self.commdate = [self objectOrNilForKey:@"commdate" fromDictionary:dict];
        self.commillecount = [self objectOrNilForKey:@"commillecount" fromDictionary:dict];
        self.resideprovince = [self objectOrNilForKey:@"resideprovince" fromDictionary:dict];
        self.truename = [self objectOrNilForKey:@"truename" fromDictionary:dict];
        self.tjsource = [self objectOrNilForKey:@"tjsource" fromDictionary:dict];
        self.sinaname = [self objectOrNilForKey:@"sinaname" fromDictionary:dict];
        self.firstpassword = [self objectOrNilForKey:@"firstpassword" fromDictionary:dict];
        if ([self.sinaauthinfo count] > 0)
        {
            self.sinauid = [self.sinaauthinfo objectForKey:@"thirduid"];
            self.sinaToken = [self.sinaauthinfo objectForKey:@"token"];
            self.sinaExpiration = [NSDate dateWithTimeIntervalSince1970:[[self.sinaauthinfo objectForKey:@"expiration"] floatValue]];
        }
        self.hobbys = [[dict objectForKey:@"interest"] isKindOfClass:[NSNull class]]?@"":[dict objectForKey:@"interest"] ;
        
        self.qqauthinfo = [self objectOrNilForKey:@"qqauthinfo" fromDictionary:dict];
        if ([self.qqauthinfo count]>0) {
            self.qquid = [self.qqauthinfo objectForKey:@"thirduid"];
            self.qqToken = [self.qqauthinfo objectForKey:@"token"];
            self.qqExpiration = [NSDate dateWithTimeIntervalSince1970:[[self.qqauthinfo objectForKey:@"expiration"] floatValue]];
        }
        
        self.wxauthinfo = [self objectOrNilForKey:@"weixinauthinfo" fromDictionary:dict];
        if ([self.wxauthinfo count]>0) {
            self.wxuid = [self.wxauthinfo objectForKey:@"thirduid"];
            self.wxToken = [self.wxauthinfo objectForKey:@"token"];
            self.wxExpiration = [NSDate dateWithTimeIntervalSince1970:[[self.wxauthinfo objectForKey:@"expiration"] floatValue]];
        }
        
        self.txauthinfo = [self objectOrNilForKey:@"tencentauthinfo" fromDictionary:dict];
        if ([self.txauthinfo count]>0) {
            self.txuid = [self.txauthinfo objectForKey:@"thirduid"];
            self.txToken = [self.txauthinfo objectForKey:@"token"];
            self.txExpiration = [[self.txauthinfo objectForKey:@"expiration"] floatValue];
        }
        self.addcredit = [self objectOrNilForKey:@"addcredit" fromDictionary:dict];
        self.cyclelogindays = [self objectOrNilForKey:@"cyclelogindays" fromDictionary:dict];
        self.usertype = [self objectOrNilForKey:@"usertype" fromDictionary:dict];
    }
    return self;
}

- (NSString *)getUserHobby
{
    if (![self.hobbys isKindOfClass:[NSNull class]]) {
        if ([self.hobbys length]  > 0)
        {
            NSString *hobbyStr = nil;
            NSArray *hobbyIdArr = [self.hobbys componentsSeparatedByString:@","];
            NSMutableArray *hobbyNameArr = [[NSMutableArray alloc] init];
            for (NSString *str in hobbyIdArr)
            {
                NSString *hobbyName = [[Config shareInstance].hobbyDic objectForKey:str];
                if (hobbyName!=nil) {
                    [hobbyNameArr addObject:hobbyName];
                }
            }
            hobbyStr = [hobbyNameArr componentsJoinedByString:@","];
            [hobbyNameArr release];
            
            return hobbyStr;
        }
    }
    return  nil;
}

- (void)addHobby:(NSString *)hobbyId
{
    if ([self.hobbys isKindOfClass:[NSNull class]]) {
        return;
    }
    if ([self.hobbys length]  > 0)
    {
        self.hobbys = [self.hobbys stringByAppendingFormat:@",%@",hobbyId];
    }
    else
    {
        self.hobbys = [NSString stringWithFormat:@"%@",hobbyId];
    }
}
- (void)delHobby:(NSString *)hobbyId
{
    if ([self.hobbys isKindOfClass:[NSNull class]]) {
        return;
    }
    if ([self.hobbys length]  > 0)
    {
        NSArray *hobbyIdArr = [self.hobbys componentsSeparatedByString:@","];
        NSMutableArray *hobbyMutableArr = [NSMutableArray arrayWithArray:hobbyIdArr];
        [hobbyMutableArr removeObject:hobbyId];
        self.hobbys = [hobbyMutableArr componentsJoinedByString:@","];
    }
}


- (void)dealloc
{
    [_adddisksize release];
//    [_birthprovince release];
    [_qqauthinfo release];
    [_account release];
    [_sharestatus release];
//    [_sex release];
    [_newpm release];
    [_credit release];
    [_username release];
    [_salt release];
    [_edateline release];
    [_password release];
    [_experience release];
//    [_birthcity release];
    [_commstatus release];
    [_shareillecount release];
    [_preconfig release];
    [_broadbandcheck release];
    [_flag release];
    [_avatar release];
//    [_msnrobot release];
//    [_residecity release];
//    [_accountvaliddate release];
    [_grouptitle release];
    [_lastbrief release];
//    [_freezedate release];
//    [_videopic release];
    [_lastnsid release];
    [_price release];
    [_sinaauthinfo release];
    [_token release];
    [_lastlogintime release];
//    [_birthmonth release];
    [_regdate release];
    [_spacepic release];
    [_freezereason release];
    [_mood release];
//    [_qq release];
//    [_msn release];
//    [_msncstatus release];
//    [_firstaccounttype release];
    [_applynum release];
    [_email release];
    [_sharenum release];
    [_diskusesize release];
    [_newfeed release];
    [_system release];
    [_mobilecheck release];
    [_vipgroupid release];
    [_loginnum release];
    [_fansnum release];
    [_lastsearch release];
//    [_birthyear release];
//    [_birthday release];
    [_bdateline release];
    [_accounttype release];
//    [_sharedate release];
    [_uid release];
//    [_blood release];
    [_disksize release];
    [_emailcheck release];
    [_notenum release];
    [_favoritenum release];
    [_lastpost release];
    [_backconfig release];
    [_mobile release];
//    [_marry release];
    [_groupid release];
    [_broadband release];
    [_newcomment release];
//    [_commdate release];
    [_commillecount release];
//    [_resideprovince release];
    [_sinauid release];
    [_sinaname release];
    [_tjsource release];
    [_truename release];
    [_sinaToken release];
    [_sinaExpiration release];
    [_firstpassword release];
    [_fansCount release];
    [_favoriteCount release];
    [_publishCount release];
    [_noteCount release];
    [super dealloc];
}


@end
