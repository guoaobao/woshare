//
//  CategoryResponse.h
//
//  Created by 波 胡 on 13-8-21
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseResponse.h"
#import "InfoListResponse.h"

@interface CategoryResponse : BaseResponse <NSCoding>

@property (nonatomic, strong) NSString *biHeight;
@property (nonatomic, strong) NSString *bigimage;
@property (nonatomic, strong) NSString *displaymode;
@property (nonatomic, strong) NSString *catid;
@property (nonatomic, strong) NSString *idtype;
@property (nonatomic, strong) NSString *idlevel;
@property (nonatomic, strong) NSString *flag;
@property (nonatomic, strong) NSString *getcatemode;
@property (nonatomic, strong) NSString *pushstatus;
@property (nonatomic, strong) NSString *sort;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, strong) NSString *imagename;
@property (nonatomic, strong) NSString *pushinfoid;
@property (nonatomic, strong) NSString *siWidth;
@property (nonatomic, strong) NSString *siHeight;
@property (nonatomic, strong) NSString *coverimage;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *ciWidth;
@property (nonatomic, strong) NSString *pcid;
@property (nonatomic, strong) NSString *pushdate;
@property (nonatomic, strong) NSString *smallimage;
@property (nonatomic, assign) id prepushdate;
@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *showmode;
@property (nonatomic, strong) NSString *showstart;
@property (nonatomic, assign) id predrawdate;
@property (nonatomic, strong) NSString *showend;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *biWidth;
@property (nonatomic, strong) NSString *getdatascope;
@property (nonatomic, strong) NSString *ciHeight;
@property (nonatomic, strong) NSString *getdatamode;
@property (nonatomic, strong) NSString *getinfomode;
@property (nonatomic, strong) NSString *extend;
@property (nonatomic, assign) BOOL  isGetInfo;
@property (nonatomic, strong) InfoListResponse  *info;
+ (CategoryResponse *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
