//
//  HotWordsResponse.m
//  QYSDK
//
//  Created by 胡 波 on 13-5-14.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "HotWordsResponse.h"

@implementation HotWordsResponse
@synthesize appid;
@synthesize recommend;
@synthesize status;
@synthesize type;
@synthesize wordid;
@synthesize wordname;


-(id)initWithDict:(NSDictionary *)dict withRequestType:(RequestType)requestType{
    
    if (self = [super initWithDict:dict withRequestType:requestType]) {
        self.appid = [dict objectForKey:@"appid"];
        self.recommend = [dict objectForKey:@"recommend"];
        self.status = [dict objectForKey:@"status"];
        self.type = [dict objectForKey:@"type"];
        self.wordid = [dict objectForKey:@"wordid"];
        self.wordname = [dict objectForKey:@"wordname"];
    }
    
    return self;
}

-(void)dealloc{
    [appid release];
    [recommend release];
    [status release];
    [type release];
    [wordid release];
    [wordname release];
    [super dealloc];
}

@end
