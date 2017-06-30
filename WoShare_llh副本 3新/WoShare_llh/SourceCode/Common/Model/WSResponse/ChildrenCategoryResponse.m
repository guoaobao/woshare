//
//  ChildrenCategoryResponse.m
//  QYSDK
//
//  Created by 胡 波 on 13-4-24.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "ChildrenCategoryResponse.h"

@implementation ChildrenCategoryResponse
@synthesize catcode,catid,catname,description,pid,sort,usestatus;
-(id)initWithDict:(NSDictionary *)dict withRequestType:(RequestType)requestType
{
    if (self = [super initWithDict:dict withRequestType:requestType]) {
        self.catname = [dict objectForKey:@"catname"];
        self.catid = [dict objectForKey:@"catid"];
        self.catcode = [dict objectForKey:@"catcode"];
        self.description = [dict objectForKey:@"description"];
        self.pid = [dict objectForKey:@"pid"];
        self.sort = [dict objectForKey:@"sort"];
        self.usestatus = [dict objectForKey:@"usestatus"];
    }
    return self;
}
- (void)dealloc
{
    [catcode release];
    [catid release];
    [catname release];
    [description release];
    [pid release];
    [sort release];
    [usestatus release];
    [super dealloc];
}
@end
