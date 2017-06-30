//
//  InfoListResponse.h
//
//  Created by 波 胡 on 13-8-26
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoResponse.h"
@interface InfoListResponse : BaseResponse <NSCoding>

typedef enum
{
    kInfoTypeOther = 0,
    kInfoTypeMovie,
    kInfoTypeMusic,
    kInfoTypePicture,
    kInfoTypeDocument,
    kInfoTypeReading,
    kInfoTypeTheme
}kInfoType;


@property (nonatomic, strong) NSString *_id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, assign) double sst;
@property (nonatomic, assign) double pich;
@property (nonatomic, strong) NSString *internalBaseClassIdentifier;
@property (nonatomic, strong) NSString *brief;
@property (nonatomic, assign) double prepushdate;
@property (nonatomic, strong) NSString *action;
@property (nonatomic, assign) double picw;
@property (nonatomic, assign) double predrawdate;
@property (nonatomic, assign) double ct;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSDictionary *pic;
@property (nonatomic, assign) int  uid;
@property (nonatomic, strong) NSDictionary *payurl;
@property (nonatomic, strong) NSString *cpid;
@property (nonatomic, assign) double as;
@property (nonatomic, assign) double ut;
@property (nonatomic, assign) double ms;
@property (nonatomic, strong) NSString *fee;
@property (nonatomic, strong) NSString *pid;
@property (nonatomic, strong) NSArray *nsids;
@property (nonatomic, strong) NSArray *cids;
@property (nonatomic, strong) NSString *actionid;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *displaymode;
@property (nonatomic, strong) NSString *likedCount;
@property (nonatomic, assign) NSInteger pts;
@property (nonatomic, assign) NSInteger dts;
@property (nonatomic, assign) NSInteger fts;
@property(nonatomic, assign) NSInteger cts;
@property (nonatomic, strong) NSString *publishTime;
@property (strong,nonatomic)  NSArray *commentions; //最前面的几个评论
@property (strong,nonatomic)  NSString  *hasfile;
@property (assign,nonatomic)  NSInteger  voteCount;
@property (assign,nonatomic)  kInfoType  infoType;
@property (strong,nonatomic)  UserInfoResponse  *userinfo;
@property (strong,nonatomic)   NSMutableArray   *resourceArray;
@property (assign,nonatomic)  BOOL      showLikeView;
@property (retain,nonatomic)  NSMutableArray    *likeUserArray;
+ (InfoListResponse *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

- (NSString *)getBiggestImageURLString;
- (NSString *)getSmallestImageURLString;
- (NSString *)getMidImageURlString;

@end
