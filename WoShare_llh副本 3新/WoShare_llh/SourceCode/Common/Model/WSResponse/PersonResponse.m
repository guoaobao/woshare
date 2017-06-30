//
//  PersonResponse.m
//  QYSDK
//
//  Created by 胡 波 on 13-5-14.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "PersonResponse.h"

@implementation PersonResponse
//@synthesize avatar;
//@synthesize comment;
//@synthesize credit;
//@synthesize delstatus;
//@synthesize direction;
//@synthesize experience;
//@synthesize fansnum;
//@synthesize favoritenum;
//@synthesize grouptitle;
//@synthesize notename;
//@synthesize notenum;
//@synthesize noteuid;
//@synthesize spacepic;
//@synthesize uid;
//@synthesize username;
//@synthesize lastbrief;
//@synthesize disksize;
//@synthesize diskusesize;
//@synthesize sharenum;
//@synthesize lastnsid;
//@synthesize mood;

-(id)initWithDict:(NSDictionary *)dict withRequestType:(RequestType)requestType{
    self = [super initWithDict:dict withRequestType:requestType];
    if (self) {
//        self.avatar = [dict objectForKey:@"avatar"];
//        self.comment = [dict objectForKey:@"comment"];
//        self.credit = [dict objectForKey:@"credit"];
//        self.delstatus = [dict objectForKey:@"delstatus"];
//        self.direction = [dict objectForKey:@"direction"];
//        self.experience = [dict objectForKey:@"experience"];
//        self.fansnum = [dict objectForKey:@"fansnum"];
//        self.favoritenum = [dict objectForKey:@"favoritenum"];
//        self.grouptitle = [dict objectForKey:@"grouptitle"];
//        self.notename = [dict objectForKey:@"notename"];
//        self.notenum = [dict objectForKey:@"notenum"];
//        self.noteuid = [dict objectForKey:@"noteuid"];
//        self.spacepic = [dict objectForKey:@"spacepic"];
//        self.uid = [dict objectForKey:@"uid"];
//        self.username = [dict objectForKey:@"username"];
//        self.lastbrief = [dict objectForKey:@"lastbrief"];
//        self.disksize = [dict objectForKey:@"disksize"];
//        self.diskusesize = [dict objectForKey:@"diskusesize"];
//        self.sharenum = [dict objectForKey:@"sharenum"];
//        self.lastnsid = [dict objectForKey:@"lastnsid"];
//        self.mood = [dict objectForKey:@"mood"];
        NSString *direction = [dict objectForKey:@"direction"];
        if ([direction intValue] == 3)
        {
            self.relateTpye = kRelatedFriend;
        }
        self.notedUserName = [dict objectForKey:@"notename"];
        self.noteUid = [NSString stringWithFormat:@"%@", [dict objectForKey:@"noteuid"]];

    }
    return self;
}

-(void)dealloc{
    
//    [avatar release];
//    [comment release];
//    [credit release];
//    [delstatus release];
//    [direction release];
//    [experience release];
//    [fansnum release];
//    [favoritenum release];
//    [grouptitle release];
//    [notename release];
//    [notenum release];
//    [noteuid release];
//    [spacepic release];
//    [uid release];
//    [username release];
//    [lastbrief release];
//    [disksize release];
//    [diskusesize release];
//    [sharenum release];
//    [lastnsid release];
//    [mood release];
[_noteUid release];
[_notedUserName release];
    [super dealloc];
}

@end
