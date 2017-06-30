//
//  TopCategoryResponse.m
//  QYSDK
//
//  Created by 胡 波 on 13-4-23.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "TopCategoryResponse.h"

@implementation TopCategoryResponse
@synthesize bigimage;
@synthesize catid;
@synthesize cid;
@synthesize code;
@synthesize displaymode;
@synthesize flag;
@synthesize getdatamode;
@synthesize getdatascope;
@synthesize idlevel;
@synthesize idtype;
@synthesize imagename;
@synthesize link;
@synthesize predrawdate;
@synthesize prepushdate;
@synthesize pushdate;
@synthesize pushinfoid;
@synthesize pushstatus;
@synthesize smallimage;
@synthesize sort;
@synthesize desc;
@synthesize searchParam;
-(id)initWithDict:(NSDictionary *)dict withRequestType:(RequestType)requestType{
    self = [super initWithDict:dict withRequestType:requestType];
    if (self) {
        self.bigimage = [dict objectForKey:@"bigimage"];
        self.catid = [dict objectForKey:@"catid"];
        self.cid = [dict objectForKey:@"cid"];
        self.code = [dict objectForKey:@"code"];
        self.displaymode = [dict objectForKey:@"displaymode"];
        self.flag = [dict objectForKey:@"flag"];
        self.getdatamode = [dict objectForKey:@"getdatamode"];
        self.getdatascope = [dict objectForKey:@"getdatascope"];
        self.idlevel = [dict objectForKey:@"idlevel"];
        self.idtype = [dict objectForKey:@"idtype"];
        self.imagename = [dict objectForKey:@"imagename"];
        self.link = [dict objectForKey:@"link"];
        self.predrawdate = [dict objectForKey:@"predrawdate"];
        self.prepushdate = [dict objectForKey:@"prepushdate"];
        self.pushdate = [dict objectForKey:@"pushdate"];
        self.pushinfoid = [dict objectForKey:@"pushinfoid"];
        self.pushstatus = [dict objectForKey:@"pushstatus"];
        self.smallimage = [dict objectForKey:@"smallimage"];
        self.sort = [dict objectForKey:@"sort"];
        self.desc = [dict objectForKey:@"desc"];
        self.columnFlag = [self parseFlag:[dict objectForKey:@"flag"]];
        self.showMode = [self parseShowMode:[dict objectForKey:@"showmode"]];
        self.searchParam = [dict objectForKey:@"params"];
    }
    return self;
}

- (kColumnFlag)parseFlag:(NSString *)flags
{
    if ([flags isEqualToString:@"kbxx"])
    {
        return kColumnFlagKBXX;
    }
    else if ([flags isEqualToString:@"hd"])
    {
        return kColumnFlagActivity;
    }
    else if ([flags isEqualToString:@"link"])
    {
        return kColumnFlagLink;
    }
    else if ([flags isEqualToString:@"searchns"])
    {
        return kColumnFlagSeachns;
    }
    else
    {
        return kColumnFlagNone;
    }
    
}
- (kColumnShowType)parseShowMode:(NSString *)showMode
{
    if ([showMode intValue] == 0)
    {
        return kColumnShowInvisible;
    }
    else if([showMode intValue] == 1)
    {
        return kColumnShowVisible;;
    }
    else if([showMode intValue] == 2)
    {
        return kColumnShowSteady;
    }
    else
    {
        return kColumnShowNone;
    }
}

-(void)dealloc{
    
    [bigimage release];
    [catid release];
    [cid release];
    [code release];
    [displaymode release];
    [flag release];
    [getdatamode release];
    [getdatascope release];
    [idlevel release];
    [idtype release];
    [imagename release];
    [link release];
    [predrawdate release];
    [prepushdate release];
    [pushdate release];
    [pushinfoid release];
    [pushstatus release];
    [smallimage release];
    [sort release];
    [searchParam release];
    [super dealloc];
    
}
@end
