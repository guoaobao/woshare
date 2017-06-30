//
//  NSResponse.h
//  QYSDK
//
//  Created by 胡 波 on 13-4-23.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "BaseResponse.h"
#import "ResourceInfo.h"
#define kDefaultResourceBrief   @"暂无简介"

@interface NSResponse : BaseResponse
@property (nonatomic, retain) NSString *_id;
@property (nonatomic, retain) NSString *pid;
@property (nonatomic, assign) BOOL     isdir;
@property (nonatomic, retain) NSString *fid;
@property (nonatomic, retain) NSString *nm;
@property (nonatomic, retain) NSString *ext;
@property (nonatomic, assign) kResourceType   ft;  //文件类型 1:视频2:音频3:图片4:文档
@property (nonatomic, assign) double   fc;
@property (nonatomic, assign) double   dc;
@property (nonatomic, assign) double   fsize;
@property (nonatomic, assign) double   ct;
@property (nonatomic, assign) double   ut;
@property (nonatomic, assign) double   dlc;
@property (nonatomic, retain) NSString *uid;
@property (nonatomic, retain) NSString *suid;
@property (nonatomic, retain) NSString *luid;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *cltp;
@property (nonatomic, assign) double   ss;
@property (nonatomic, assign) double   sst;
@property (nonatomic, assign) double   ssr;
@property (nonatomic, assign) kReviewStatus   as;
@property (nonatomic, assign) double   at;
@property (nonatomic, retain) NSArray  *cids;
@property (nonatomic, retain) NSArray  *tags;
@property (nonatomic, retain) NSString *mark;
@property (nonatomic, assign) double   prop;
@property (nonatomic, retain) NSString *org;
@property (nonatomic, retain) NSString *brief;
@property (nonatomic, retain) NSArray *pic;
@property (nonatomic, assign) double   cts;
@property (nonatomic, assign) double   dts;
@property (nonatomic, assign) double   fts;
@property (nonatomic, assign) double   pts;
@property (nonatomic, assign) double   tts;
@property (nonatomic, retain) NSArray  *cmtids;
@property (nonatomic, assign) double   width;
@property (nonatomic, assign) double   height;
@property (nonatomic, assign) double   ms;
@property (nonatomic, retain) NSString *vts;
- (NSString *)getBiggestImageURLString;
- (NSString *)getSmallestImageURLString;
- (NSString *)getMidImageURlString;
@end

