//
//  EventResponse.h
//  QYSDK
//
//  Created by 胡 波 on 13-4-23.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "BaseResponse.h"

@interface EventFileResponse : BaseResponse
@property(nonatomic, assign) double   _id;
@property(nonatomic, retain) NSString *nsid;
@property(nonatomic, retain) NSString *title;
@property(nonatomic, assign) double   type;
@property(nonatomic, assign) double   eventid;
@property(nonatomic, assign) double   votenum;
@property(nonatomic, assign) double   uid;
@property(nonatomic, retain) NSString *username;
@property(nonatomic, assign) double   dateline;
@property(nonatomic, assign) double   as;
@property(nonatomic, assign) double   sort;
@property(nonatomic, assign) double   ms;
@end
