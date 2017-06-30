//
//  GeeUploadParam.h
//  QYSDK
//
//  Created by eingbol on 13-4-26.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "GeeUploadBaseParam.h"

@interface GeeUploadParam : GeeUploadBaseParam

@property (nonatomic,retain) NSString* eventid;
@property (nonatomic,retain) NSString* eventtitle;
@property (nonatomic,retain) NSString* cids;
@property (nonatomic,retain) NSString* cidname;
@property  BOOL sinaShare;

@end
