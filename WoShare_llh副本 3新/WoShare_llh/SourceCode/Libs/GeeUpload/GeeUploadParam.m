//
//  GeeUploadParam.m
//  QYSDK
//
//  Created by eingbol on 13-4-26.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "GeeUploadParam.h"

#ifndef IFNIL
#define IFNIL(ZZ)  ((ZZ==nil) ? @"" : ZZ)
#endif

@implementation GeeUploadParam

@synthesize eventid;
@synthesize eventtitle;
@synthesize cids;
@synthesize cidname;
@synthesize sinaShare;


- (id)init
{
    self = [super init];
    if (self) {
        self.sinaShare = NO;
    }
    return self;
}

- (void)dealloc
{
    [eventid release];
    [eventtitle release];
    [cids release];
    [cidname release];
    [super dealloc];
}

-(NSDictionary*) toDict
{
    NSMutableArray* fileinfos = [[NSMutableArray alloc] init];
    for (GeeUploadFileInfo* fileinfo in self.fileinfos) {
        [fileinfos addObject:[fileinfo toDict]];
    }
    return [NSDictionary dictionaryWithObjectsAndKeys:IFNIL(self.uid),@"uid",IFNIL(fileinfos),@"fileinfos",IFNIL(self.brief),@"brief",IFNIL(self.title),@"title",IFNIL(self.pid),@"pid",IFNIL(self.eventid),@"eventid",IFNIL(self.eventtitle),@"eventtitle",IFNIL(self.cids),@"cids",IFNIL(self.cidname),@"cidname",[NSNumber numberWithBool:self.sinaShare],@"sina", nil];
}

-(NSDictionary*) toUploadDict
{
    return [NSDictionary dictionaryWithObjectsAndKeys:IFNIL(self.uid),@"uid",IFNIL(self.brief),@"brief",IFNIL(self.eventid),@"eventid",IFNIL(self.eventtitle),@"eventtitle",IFNIL(self.cids),@"cids",IFNIL(self.cidname),@"cidname",[NSNumber numberWithBool:self.sinaShare],@"sina", nil];
    
}

-(id)initWithDict:(NSDictionary*)dict
{
    self = [self init];
    if(self)
    {
        self.uid = [dict objectForKey:@"uid"];
        self.brief = [dict objectForKey:@"brief"];
        self.title = [dict objectForKey:@"title"];
        self.pid = [dict objectForKey:@"pid"];
        self.eventid = [dict objectForKey:@"eventid"];
        self.eventtitle = [dict objectForKey:@"eventtitle"];
        self.cids = [dict objectForKey:@"cids"];
        self.cidname = [dict objectForKey:@"cidname"];
        NSNumber* sinaNum = [dict objectForKey:@"sina"];
        self.sinaShare = [sinaNum boolValue];
        NSMutableArray* fileinfos = [dict objectForKey:@"fileinfos"];
        for (NSDictionary* fiDict in fileinfos) {
            GeeUploadFileInfo* fileinfo = [[GeeUploadFileInfo alloc] initWithDict:fiDict];
            [self.fileinfos addObject:fileinfo];
            [fileinfo release];
        }
    }
    return self;
}

@end
