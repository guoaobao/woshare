//
//  FavouriteResponse.h
//  QYSDK
//
//  Created by 胡 波 on 13-4-23.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "BaseResponse.h"

@interface FavouriteResponse : BaseResponse
@property(nonatomic, retain) NSString *_id;
@property(nonatomic, assign) double   ct;
@property(nonatomic, assign) double   dc;
@property(nonatomic, assign) double   fc;
@property(nonatomic, assign) double   fsize;
@property(nonatomic, assign) BOOL     isfd;
@property(nonatomic, retain) NSString *nm;
@property(nonatomic, retain) NSString *nsid;
@property(nonatomic, retain) NSString *pid;
@property(nonatomic, retain) NSString *suid;
@property(nonatomic, retain) NSString *sunm;
@property(nonatomic, assign) double   type;
@property(nonatomic, retain) NSString *uid;
@property(nonatomic, retain) NSString *unm;
@property(nonatomic, assign) double   ut;
@property(nonatomic, assign) BOOL     isResource;
@end
