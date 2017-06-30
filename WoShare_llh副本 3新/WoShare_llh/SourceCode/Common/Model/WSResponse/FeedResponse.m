//
//  FeedResponse.m
//  QYSDK
//
//  Created by 胡 波 on 13-5-14.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "FeedResponse.h"

@implementation FeedResponse
@synthesize _id;
@synthesize actid;
@synthesize content;
@synthesize ct;
@synthesize nsid;
@synthesize read;
@synthesize tuid;
@synthesize tunm;
@synthesize type;
@synthesize uid;
@synthesize unm;
@synthesize ut;
@synthesize thumburl;
@synthesize userInfo;

-(id) initWithDict:(NSDictionary *)dict withRequestType:(RequestType)requestType{
    self = [super initWithDict:dict withRequestType:requestType];
    if (self) {
        self._id = [dict objectForKey:@"_id"];
        self.actid = [dict objectForKey:@"actid"];
        self.content = [dict objectForKey:@"content"];
        self.ct = [dict objectForKey:@"ct"];
        self.nsid = [dict objectForKey:@"nsid"];
        self.read = [dict objectForKey:@"read"];
        self.tuid = [dict objectForKey:@"tuid"];
        self.tunm = [dict objectForKey:@"tunm"];
        self.type = [dict objectForKey:@"type"];
        self.uid = [dict objectForKey:@"uid"];
        self.unm = [dict objectForKey:@"unm"];
        self.ut = [dict objectForKey:@"ut"];
        self.thumburl = [dict objectForKey:@"thumburl"];
        self.isDeleted = [[dict objectForKey:@"deleted"]integerValue]==1?YES:NO;
        self.title = [dict objectForKey:@"title"];
        if ([self.type isEqualToString:@"sharens"]) {
            self.tagType = kTagImageTypeShare;
        }else if ([self.type isEqualToString:@"likens"]){
            self.tagType = kTagImageTypeLike;
        }else if ([self.type isEqualToString:@"favorite"]){
            self.tagType = kTagImageTypeCollect;
        }else if ([self.type isEqualToString:@"comment"]){
            self.tagType = kTagImageTypeTalk;
        }else if ([self.type isEqualToString:@"note"]){
            self.tagType = kTagImageTypeFollower;
        }
        else if ([self.type isEqualToString:@"vote"]){
            self.tagType = kTagImageTypeVote;
        }
        if ([[dict objectForKey:@"idtype"] isEqualToString:@"info"]) {
            self.isResource = NO;
        }
        else
        {
            self.isResource = YES;
        }
        
    }
    return self;
}

-(void)dealloc{
    
    [_id release];
    [actid release];
    [content release];
    [ct release];
    [nsid release];
    [read release];
    [tuid release];
    [tunm release];
    [type release];
    [uid release];
    [unm release];
    [ut release];
    [thumburl release];
    [userInfo release];
    [super dealloc];
}

@end
