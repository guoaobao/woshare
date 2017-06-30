//
//  FVCommonPath.h
//  FVKit
//
//  Created by 胡 波 on 13-3-27.
//
//

#import <Foundation/Foundation.h>
#import "RequestType.h"
//Get common path method
typedef enum _FVPathType
{
	kFVPathTypeDocument=0,
	kFVPathTypeTmp,
    kFVPathTypeCache,
    
	//Add custom path here
    kFVPathTypeDataSourceFile,
    kFVPathTypePicCache,
    kFVPathTypeJsonRootCache,
    kFVPathTypeConfigCache
}FVPathType;

NSString* FVGetPathWithType(FVPathType pathType, id object);
NSString* FVGetJsonCachePathWithRequestType(RequestType type);