//
//  UserInfoResponse.h
//  QYSDK
//
//  Created by 胡 波 on 13-4-23.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "BaseResponse.h"

@interface UserInfoResponse : BaseResponse
@property (nonatomic, retain) NSString *adddisksize;
@property (nonatomic, assign) id birthprovince;
@property (nonatomic, retain) NSString *account;
@property (nonatomic, retain) NSString *sharestatus;
@property (nonatomic, assign) int sex;
@property (nonatomic, retain) NSString *newpm;
@property (nonatomic, retain) NSString *credit;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *salt;
@property (nonatomic, retain) NSString *edateline;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *experience;
@property (nonatomic, assign) id birthcity;
@property (nonatomic, retain) NSString *commstatus;
@property (nonatomic, retain) NSString *shareillecount;
@property (nonatomic, retain) NSString *preconfig;
@property (nonatomic, retain) NSString *broadbandcheck;
@property (nonatomic, retain) NSString *flag;
@property (nonatomic, retain) NSString *avatar;
@property (nonatomic, assign) id msnrobot;
@property (nonatomic, assign) id residecity;
@property (nonatomic, assign) id accountvaliddate;
@property (nonatomic, retain) NSString *grouptitle;
@property (nonatomic, retain) NSString *lastbrief;
@property (nonatomic, assign) id freezedate;
@property (nonatomic, assign) id videopic;
@property (nonatomic, retain) NSString *lastnsid;
@property (nonatomic, retain) NSString *price;

@property (nonatomic, retain) NSString *token;
@property (nonatomic, retain) NSString *lastlogintime;
@property (nonatomic, assign) id birthmonth;
@property (nonatomic, retain) NSString *regdate;
@property (nonatomic, retain) NSString *spacepic;
@property (nonatomic, retain) NSString *freezereason;
@property (nonatomic, retain) NSString *mood;
@property (nonatomic, assign) id qq;
@property (nonatomic, assign) id msn;
@property (nonatomic, assign) id msncstatus;
@property (nonatomic, assign) double newnoteresource;
@property (nonatomic, assign) id firstaccounttype;
@property (nonatomic, retain) NSString *applynum;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *sharenum;
@property (nonatomic, retain) NSString *diskusesize;
@property (nonatomic, retain) NSString *newfeed;
@property (nonatomic, retain) NSString *system;
@property (nonatomic, retain) NSString *mobilecheck;
@property (nonatomic, retain) NSString *vipgroupid;
@property (nonatomic, retain) NSString *loginnum;
@property (nonatomic, retain) NSString *fansnum;
@property (nonatomic, retain) NSString *lastsearch;
@property (nonatomic, assign) id birthyear;
@property (nonatomic, assign) id birthday;
@property (nonatomic, retain) NSString *bdateline;
@property (nonatomic, retain) NSString *accounttype;
@property (nonatomic, assign) id sharedate;
@property (nonatomic, retain) NSString *uid;
@property (nonatomic, assign) id blood;
@property (nonatomic, retain) NSString *disksize;
@property (nonatomic, retain) NSString *emailcheck;
@property (nonatomic, retain) NSString *notenum;
@property (nonatomic, retain) NSString *favoritenum;
@property (nonatomic, retain) NSString *lastpost;
@property (nonatomic, retain) NSString *backconfig;
@property (nonatomic, retain) NSString *mobile;
@property (nonatomic, assign) id marry;
@property (nonatomic, retain) NSString *groupid;
@property (nonatomic, retain) NSString *broadband;
@property (nonatomic, retain) NSString *newcomment;
@property (nonatomic, assign) id commdate;
@property (nonatomic, retain) NSString *commillecount;
@property (nonatomic, assign) id resideprovince;
@property (nonatomic, retain) NSString *truename;
@property (nonatomic, retain) NSString *tjsource;

@property (nonatomic, retain) NSDictionary *sinaauthinfo;
@property (nonatomic, retain) NSString *sinaToken;
@property (nonatomic, retain) NSDate *sinaExpiration;
@property (nonatomic, retain) NSString *sinauid;
@property (nonatomic, retain) NSString *sinaname;

@property (nonatomic, retain) NSDictionary *qqauthinfo;
@property (nonatomic, retain) NSString *qqToken;
@property (nonatomic, retain) NSDate *qqExpiration;
@property (nonatomic, retain) NSString *qquid;
@property (nonatomic, retain) NSString *qqname;

@property (nonatomic, retain) NSDictionary *txauthinfo;
@property (nonatomic, retain) NSString *txToken;
@property (nonatomic, assign) NSTimeInterval txExpiration;
@property (nonatomic, retain) NSString *txuid;
@property (nonatomic, retain) NSString *txname;

@property (nonatomic, retain) NSDictionary *wxauthinfo;
@property (nonatomic, retain) NSString *wxToken;
@property (nonatomic, retain) NSDate *wxExpiration;
@property (nonatomic, retain) NSString *wxuid;
@property (nonatomic, retain) NSString *wxname;
@property (nonatomic, retain) NSString *usertype;

@property (nonatomic, retain) NSString *firstpassword;
@property (nonatomic, retain) NSString *hobbys;

@property(nonatomic, copy) NSString *fansCount;
@property(nonatomic, copy) NSString *favoriteCount;
@property(nonatomic, copy) NSString *publishCount;
@property(nonatomic, copy) NSString *noteCount;

@property(nonatomic, copy) NSString *addcredit;
@property(nonatomic, copy) NSString *cyclelogindays;

@property (nonatomic, assign) BOOL      isNoted;
@property (nonatomic,copy)  NSString    *oldname;
- (NSString *)getUserHobby;
- (void)addHobby:(NSString *)hobbyId;
- (void)delHobby:(NSString *)hobbyId;

@end