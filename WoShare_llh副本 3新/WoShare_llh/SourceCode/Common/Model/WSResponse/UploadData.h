//
//  UploadData.h
//  HappyShare
//
//  Created by Lin Pan on 13-4-28.
//  Copyright (c) 2013年 Lin Pan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EventResponse.h"
@interface UploadData : NSObject

@property (retain,nonatomic) NSData     *fileData;
@property (retain,nonatomic) NSString   *fileName;
@property (retain,nonatomic) NSURL      *videoURL;
@property (retain,nonatomic) UIImage    *coverImage;
@property (retain,nonatomic) EventResponse *targetEvent;

@property (retain,nonatomic) NSString   *oldTitle;
@property (retain,nonatomic) NSString   *infoid;
- (id)initWithFileData:(NSData *)data fileURL:(NSURL *)url fileName:(NSString *)aFileName;
@end
