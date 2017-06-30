//
//  TopCategoryResponse.h
//  QYSDK
//
//  Created by 胡 波 on 13-4-23.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "BaseResponse.h"

//栏目flag
typedef enum
{
    kColumnFlagSeachns, //表明需调用searchns接口，别名“栏目”
    kColumnFlagLink,    //是web链接
    kColumnFlagActivity,//活动
    kColumnFlagKBXX,    //看遍潇湘
    kColumnFlagNone
}kColumnFlag;

//栏目的显示方式
typedef enum
{
    kColumnShowInvisible, //不可见的
    kColumnShowVisible,   //可见的
    kColumnShowSteady,    //固定不变
    kColumnShowNone,
}kColumnShowType;

@interface TopCategoryResponse : BaseResponse
@property(retain,nonatomic)NSString *bigimage;
@property(retain,nonatomic)NSString *catid;
@property(retain,nonatomic)NSString *cid;
@property(retain,nonatomic)NSString *code;
@property(retain,nonatomic)NSString *displaymode;
@property(retain,nonatomic)NSString *flag;
@property(retain,nonatomic)NSString *getdatamode;
@property(retain,nonatomic)NSString *getdatascope;
@property(retain,nonatomic)NSString *idlevel;
@property(retain,nonatomic)NSString *idtype;
@property(retain,nonatomic)NSString *imagename;
@property(retain,nonatomic)NSString *link;
@property(retain,nonatomic)NSString *predrawdate;
@property(retain,nonatomic)NSString *prepushdate;
@property(retain,nonatomic)NSString *pushdate;
@property(retain,nonatomic)NSString *pushinfoid;
@property(retain,nonatomic)NSString *pushstatus;
@property(retain,nonatomic)NSString *smallimage;
@property(retain,nonatomic)NSString *sort;
@property(retain,nonatomic)NSString *desc;
@property(retain,nonatomic) NSDictionary *searchParam;
@property(assign,nonatomic)kColumnShowType showMode;
@property(assign,nonatomic)kColumnFlag columnFlag;

@end
