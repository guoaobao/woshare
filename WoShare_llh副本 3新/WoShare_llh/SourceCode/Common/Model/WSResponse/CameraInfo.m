//
//  CameraInfo.m
//  HappyShare
//
//  Created by Lin Pan on 13-4-25.
//  Copyright (c) 2013年 Lin Pan. All rights reserved.
//

#import "CameraInfo.h"

@implementation CameraInfo

- (id)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}
- (void)dealloc
{
    [_cameraURL release];
    [_cameraName release];
    [_type release];
    [super dealloc];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"cameraName: %@,\ncameraURL:%@,\ncityName:%@\ndevicePassword:%@,\ndeviceUsername:%@,\ndeviceType:%@\nport:%@\nserverIp:%@\ndeviceStatus:%@",_cameraName,_cameraURL,_cityName,_devicePassword,_deviceUsername,_deviceType,_port,_serverIp,_deviceStatus];
}
@end
