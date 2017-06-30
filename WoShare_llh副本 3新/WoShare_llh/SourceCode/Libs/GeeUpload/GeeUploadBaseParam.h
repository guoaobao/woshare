//
//  GeeUploadBaseParam.h
//  QYSDK
//
//  Created by eingbol on 13-4-26.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GeeUploadCommon.h"

@interface IGeeExtraObject : NSObject

//继承两个方法必须重写
-(NSDictionary*) toDict;
-(id)initWithDict:(NSDictionary*)dict;

@end

@interface GeeUploadFileInfo : NSObject

@property (nonatomic,retain) NSString* filename;
@property (nonatomic,retain) UIImage*  image;
@property (nonatomic,retain) NSURL* videourl;

//内部使用，不需要赋值
@property (nonatomic,retain) NSString* path;
@property GeeTaskStatus status;
@property (nonatomic,retain) NSString* nsid;
//

-(NSDictionary*) toDict;
-(id)initWithDict:(NSDictionary*)dict;

@end

@interface GeeUploadBaseParam : NSObject

@property (nonatomic,retain) NSString* uid;
@property (nonatomic,retain) NSString* brief;
@property (nonatomic,retain) NSMutableArray* fileinfos;
@property (nonatomic,retain) NSString* title;
@property (nonatomic,retain) NSString* pid;//optional,if not set pid ,will use uploadParentFolderName
@property (nonatomic,retain) IGeeExtraObject* extraObject;//用于存储扩展对象，但是必须继承IGeeExtraObject，并实现两个方法，这样才能实现数据序列化

-(NSDictionary*) toDict;
-(NSDictionary*) toUploadDict;
-(id)initWithDict:(NSDictionary*)dict;

@end
