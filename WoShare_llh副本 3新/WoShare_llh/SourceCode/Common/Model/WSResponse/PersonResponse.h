//
//  PersonResponse.h
//  QYSDK
//
//  Created by 胡 波 on 13-5-14.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "UserInfoResponse.h"
typedef enum
{
    kRelatedNote = 1,
    kRelatedFans,
    kRelatedFriend,
}kRelatedType;


@interface PersonResponse : UserInfoResponse
//@property(nonatomic, retain) NSString *avatar;
//@property(nonatomic, retain) NSString *comment;
//@property(nonatomic, retain) NSString *credit;
//@property(nonatomic, retain) NSString *delstatus;
//@property(nonatomic, retain) NSString *direction;
//@property(nonatomic, retain) NSString *experience;
//@property(nonatomic, retain) NSString *fansnum;
//@property(nonatomic, retain) NSString *favoritenum;
//@property(nonatomic, retain) NSString *grouptitle;
//@property(nonatomic, retain) NSString *notename;
//@property(nonatomic, retain) NSString *notenum;
//@property(nonatomic, retain) NSString *noteuid;
//@property(nonatomic, retain) NSString *spacepic;
//@property(nonatomic, retain) NSString *uid;
//@property(nonatomic, retain) NSString *username;
//@property(nonatomic, retain) NSString *lastbrief;
//@property(nonatomic, retain) NSString *disksize;
//@property(nonatomic, retain) NSString *diskusesize;
//@property(nonatomic, retain) NSString *sharenum;
//@property(nonatomic, copy)   NSString *lastnsid;
//@property(nonatomic, copy)   NSString *mood;

@property(assign,nonatomic) kRelatedType relateTpye;
@property(copy,nonatomic) NSString *notedUserName; //被关注的人的名字
@property(copy,nonatomic) NSString *noteUid;  //被关注的人的uid


@end
