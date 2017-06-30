//
//  UploadData.m
//  HappyShare
//
//  Created by Lin Pan on 13-4-28.
//  Copyright (c) 2013年 Lin Pan. All rights reserved.
//

#import "UploadData.h"

@implementation UploadData

- (id)initWithFileData:(NSData *)data fileURL:(NSURL *)url fileName:(NSString *)aFileName
{
    self = [super init];
    if (self)
    {
        self.fileName = aFileName;
        self.fileData = data;
        self.videoURL = url;
    }
    return self;
}


- (void)dealloc
{
    [_fileData release];
    [_fileName release];
    [_videoURL release];
    [_targetEvent release];
    [super dealloc];
}

@end
