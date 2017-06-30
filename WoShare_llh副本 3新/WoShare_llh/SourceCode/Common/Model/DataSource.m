//
//  DataSource.m
//  QYSDK
//
//  Created by 胡 波 on 13-4-8.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "DataSource.h"
#import "FVKit.h"
#import "Reachability.h"
#import "OpenUDID.h"


#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
@implementation DataSource
@synthesize appSetting=appSetting_;
@synthesize account=account_;
@synthesize flowCount = flowCount_;
static DataSource *_sharedDataSourceInstance=nil;

+(DataSource*)sharedDataSource
{
    @synchronized(self)
    {
        if(_sharedDataSourceInstance==nil)
        {
            _sharedDataSourceInstance=[[self alloc] init];
        }
        return _sharedDataSourceInstance;
    }
    return nil;
}

+(void)releaseInstance
{
    if(_sharedDataSourceInstance)
    {
        [_sharedDataSourceInstance release];
        _sharedDataSourceInstance=nil;
    }
}

+(id)alloc
{
    NSAssert(_sharedDataSourceInstance==nil,@"Attempted to allocate a second instance of a singleton.");
    return [super alloc];
}

-(id)init
{
    if (self = [super init]) {
        NSString *localFile=FVGetPathWithType(kFVPathTypeDataSourceFile, nil);
        if([[NSFileManager defaultManager] fileExistsAtPath:localFile])
        {
            NSDictionary *dic=[NSKeyedUnarchiver unarchiveObjectWithFile:localFile];
            appSetting_=[[dic objectForKey:@"AppSetting"] retain];
            account_ = [[dic objectForKey:@"account"]retain];
            flowCount_ = [[dic objectForKey:@"flowcount"]retain];
        }
        if (account_==nil) {
            account_ = [[LocalAccount alloc]init];
        }
        if (appSetting_==nil) {
            appSetting_ = [[AppSetting alloc]init];
        }
        if (flowCount_ == nil) {
            flowCount_ = [[FlowCount alloc]init];
        }
        [self getDeviceID];
    }
    return self;
}

- (void)dealloc
{
    [account_ release];
    [appSetting_ release];
    [flowCount_ release];
    [super dealloc];
}

#pragma mark - Device ID
-(NSString*)getDeviceID
{
//    int                     mib[6];
//	size_t                  len;
//	char                    *buf;
//	unsigned char           *ptr;
//	struct if_msghdr        *ifm;
//	struct sockaddr_dl      *sdl;
//	
//	mib[0] = CTL_NET;
//	mib[1] = AF_ROUTE;
//	mib[2] = 0;
//	mib[3] = AF_LINK;
//	mib[4] = NET_RT_IFLIST;
//	
//	if ((mib[5] = if_nametoindex("en0")) == 0) {
//		printf("Error: if_nametoindex error/n");
//		return NULL;
//	}
//	
//	if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
//		printf("Error: sysctl, take 1/n");
//		return NULL;
//	}
//	
//	if ((buf = malloc(len)) == NULL) {
//		printf("Could not allocate memory. error!/n");
//		return NULL;
//	}
//	
//	if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
//		printf("Error: sysctl, take 2");
//        free(buf);
//		return NULL;
//	}
//	ifm = (struct if_msghdr *)buf;
//	sdl = (struct sockaddr_dl *)(ifm + 1);
//	ptr = (unsigned char *)LLADDR(sdl);
//	NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
//	free(buf);
//	return [self hexWithString:[outstring uppercaseString]];
    return [OpenUDID value];
}

-(NSString *)hexWithString:(NSString *)astring;
{
    return [NSString stringWithFormat:@"%@",[NSString stringwithMd5Encode:astring]];
}


@end
