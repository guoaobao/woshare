//
//  DiskResponse.h
//  QYSDK
//
//  Created by 胡 波 on 13-4-23.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "BaseResponse.h"

@interface DiskResponse : BaseResponse
@property(nonatomic, retain) NSString *username;
@property(nonatomic, retain) NSString *mood;
@property(nonatomic, assign) double   experience;
@property(nonatomic, assign) double   credit;
@property(nonatomic, assign) double   notenum;
@property(nonatomic, assign) double   fansnum;
@property(nonatomic, retain) NSString *avatar;
@property(nonatomic, retain) NSString *spacepic;
@property(nonatomic, assign) double   favoritenum;
@property(nonatomic, assign) double   diskusesize;
@property(nonatomic, assign) double   disksize;
@property(nonatomic, retain) NSString *grouptitle;
@property(nonatomic, assign) double   sharenum;
@end
