//
//  FVCommonPath.m
//  FVKit
//
//  Created by 胡 波 on 13-3-27.
//
//

#import "FVCommonPath.h"
NSString* FVGetPathWithType(FVPathType pathType, id object)
{
	switch (pathType)
	{
		case kFVPathTypeDocument:
		{
            NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentDirectory=[paths objectAtIndex:0];
			return documentDirectory;
		}break;
		case kFVPathTypeTmp:
		{
			return NSTemporaryDirectory();
		}break;
        case kFVPathTypeCache:
        {
            NSArray *paths=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            NSString *cacheDirectory=[paths objectAtIndex:0];
            return cacheDirectory;
        }break;
            //Add custom path here
            //..
        case kFVPathTypeDataSourceFile:
        {
            NSString *document=FVGetPathWithType(kFVPathTypeDocument, nil);
            return [document stringByAppendingPathComponent:@"userData.arch"];
        }break;
        case kFVPathTypePicCache:
        {
            NSString    *cache = FVGetPathWithType(kFVPathTypeCache, nil);
            NSString *rootFolder=[cache stringByAppendingPathComponent:@"CacheRoot"];
            if(![[NSFileManager defaultManager] fileExistsAtPath:rootFolder])
                [[NSFileManager defaultManager] createDirectoryAtPath:rootFolder withIntermediateDirectories:YES attributes:nil error:NULL];
            return rootFolder;
        }break;
        case kFVPathTypeJsonRootCache:
        {
            NSString    *cache = FVGetPathWithType(kFVPathTypeCache, nil);
            NSString *rootFolder=[cache stringByAppendingPathComponent:@"JsonRootCache"];
            if(![[NSFileManager defaultManager] fileExistsAtPath:rootFolder])
                [[NSFileManager defaultManager] createDirectoryAtPath:rootFolder withIntermediateDirectories:YES attributes:nil error:NULL];
            return rootFolder;
        }break;
        case kFVPathTypeConfigCache:
        {
            NSString    *cache = FVGetPathWithType(kFVPathTypeJsonRootCache, nil);
            NSString *rootFolder=[cache stringByAppendingPathComponent:@"config"];
            if (![[NSFileManager defaultManager] fileExistsAtPath:rootFolder]) {
                [[NSFileManager defaultManager]createFileAtPath:rootFolder contents:nil attributes:nil];
            }
            return rootFolder;
        }break;
		default:break;
	}
	return nil;
}

NSString* FVGetJsonCachePathWithRequestType(RequestType type)
{
    if (type) {
        NSString    *cache = FVGetPathWithType(kFVPathTypeJsonRootCache, nil);
        NSString    *rootFolder=[cache stringByAppendingPathComponent:[NSString stringWithFormat:@"%d",type]];
        if(![[NSFileManager defaultManager] fileExistsAtPath:rootFolder])
            [[NSFileManager defaultManager] createDirectoryAtPath:rootFolder withIntermediateDirectories:YES attributes:nil error:NULL];
        return rootFolder;
    }
    else
        return nil;
}
