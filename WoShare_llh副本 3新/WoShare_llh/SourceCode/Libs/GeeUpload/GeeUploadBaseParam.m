//
//  GeeUploadBaseParam.m
//  QYSDK
//
//  Created by eingbol on 13-4-26.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "GeeUploadBaseParam.h"

#ifndef IFNIL
#define IFNIL(ZZ)  ((ZZ==nil) ? @"" : ZZ)
#endif

@implementation IGeeExtraObject

-(NSDictionary*) toDict
{
    return Nil;
}

-(id)initWithDict:(NSDictionary*)dict
{
    return Nil;
}

@end

@implementation GeeUploadFileInfo

@synthesize filename;
@synthesize image;
@synthesize videourl;

@synthesize path;
@synthesize status;
@synthesize nsid;

-(void)dealloc
{
    [filename release];
    [image release];
    [videourl release];
    [path release];
    [nsid release];
    [super dealloc];
}

-(NSDictionary*) toDict
{
    return [NSDictionary dictionaryWithObjectsAndKeys:IFNIL(self.filename),@"fn",IFNIL(self.path),@"path",IFNIL([NSNumber numberWithInt:self.status]),@"status", IFNIL(self.nsid),@"nsid",nil];
}

-(id)initWithDict:(NSDictionary*)dict
{
    self = [self init];
    if(self)
    {
        self.filename = [dict objectForKey:@"fn"];
        self.path = [dict objectForKey:@"path"];
        NSNumber* statusNum = [dict objectForKey:@"status"];
        self.status = [statusNum boolValue];
        self.nsid = [dict objectForKey:@"nsid"];
    }
    return self;
}

@end

@implementation GeeUploadBaseParam

@synthesize uid;
@synthesize brief;
@synthesize title;
@synthesize fileinfos;
@synthesize pid;

-(void)dealloc
{
    [uid release];
    [brief release];
    [title release];
    [fileinfos release];
    [pid release];
    [super dealloc];
}

-(NSDictionary*) toDict
{
    return nil;
}

-(NSDictionary*) toUploadDict
{
    return nil;
}

-(id)initWithDict:(NSDictionary*)dict
{
    return [self init];
}

@end
