//
//  GeeUploadData.h
//  HappyShare
//
//  Created by eingbol on 13-5-8.
//  Copyright (c) 2013年 Lin Pan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeeUploadCommon.h"
#import "GeeUploadBaseParam.h"

@interface IGeeUploadData : NSObject

@property (nonatomic,retain)GeeUploadBaseParam* param;
@property int tid;
@property GeeTaskStatus status;
@property int errorNum;
@property double per;
@property (nonatomic,retain)GeeUploadResult* lastResult;

-(NSDictionary*)toDict;
-(id)initWithDict:(NSDictionary*)dict;

@end

@interface IOSProgressCallbackData : NSObject
@property long total;
@property long upload;
@property double per;
@property (nonatomic,retain)IGeeUploadData* data;
@end

@protocol GeeUploadDelegate <NSObject>

-(void)progressCallback:(IOSProgressCallbackData*)obj;
-(void)uploadCompleteCallback:(GeeUploadResult*)gr obj:(IGeeUploadData*)obj;

@end

@interface GeeUploadData : IGeeUploadData
{
    void* _gu;
    BOOL _isStop;
    long _totalSize;
    long _baseSize;
}

-(GeeUploadResult*)operation:(NSString*)url parentName:(NSString*)name;
-(void)stop;
-(int)calSize;
-(void)progressFuncCallback:(IOSProgressCallbackData*)data;

@property (nonatomic,assign)id<GeeUploadDelegate> delegate;

@end