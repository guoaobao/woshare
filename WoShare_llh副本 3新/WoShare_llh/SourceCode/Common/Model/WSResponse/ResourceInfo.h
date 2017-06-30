//
//  ResourceInfo.h
//  HappyShare
//
//  Created by Lin Pan on 13-4-11.
//  Copyright (c) 2013年 Lin Pan. All rights reserved.
//
//  资源信息

#import <Foundation/Foundation.h>
#import "UserInfoResponse.h"
#define kDefaultResourceBrief   @"暂无简介"

typedef enum {
    kResourceVideo = 1,
    kResourceVoice,
    kResourcePicture,
    kResourceDocument,
    kResourceUnknow
}kResourceType;

typedef enum
{
    kReviewWaiting,
    kReviewOK,
    kReviewNo
}kReviewStatus;  //资源审核状态

@interface ResourceInfo : BaseResponse


@property(copy,nonatomic) NSString *resourceId;
@property(copy,nonatomic) NSString *name;     //文件本身名字
@property(copy,nonatomic) NSString *publishTime; //发布时间
@property(copy,nonatomic) NSString *ext;      //扩展名
@property(assign,nonatomic) kResourceType type;  // 1、视频  2、音频 3、图片 4、文档
@property(copy,nonatomic) NSString *size;
@property(copy,nonatomic) NSString *fsize;
@property(copy,nonatomic) NSString *resourceUid;  //资源拥有者id
@property(copy,nonatomic) NSString *title;    //上传时用户所起的名字
@property(copy,nonatomic) NSString *shareStatus;//分享状态 0私密 1公开
@property(copy,nonatomic) NSString *shareTime;
@property(assign,nonatomic) kReviewStatus reviweStatus; //审核状态
@property(copy,nonatomic) NSString *reviewTime;   //审核时间
@property(copy,nonatomic) NSString *reviewDesc;   //
@property(copy,nonatomic) NSString *brief;        //简介
@property(copy,nonatomic) NSString *likedCount;   //被喜欢的次数
@property(copy,nonatomic) NSString *collectCount;   //被收藏的次数
@property(copy,nonatomic) NSString *voteCount;//投票数
@property(retain,nonatomic) NSArray *thumbs;      //4张尺寸不同的缩略图
@property(retain,nonatomic) NSArray *commentions; //最前面的几个评论
@property(retain,nonatomic) NSString *fid;
@property(retain,nonatomic) NSString *originalUrl;
@property(retain,nonatomic) NSString *playUrl;
@property(nonatomic, assign) BOOL     isResource;
//@property(copy,nonatomic) NSString *picBaseUrl;   //缩略图的基本网址
@property(retain,nonatomic)UserInfoResponse *userinfo;


@property(assign,nonatomic)BOOL     isLiked;

- (id)initWithDic:(NSDictionary *)dic;

- (NSString *)getBiggestImageURLString;
- (NSString *)getSmallestImageURLString;
- (NSString *)getMidImageURlString;
@end
