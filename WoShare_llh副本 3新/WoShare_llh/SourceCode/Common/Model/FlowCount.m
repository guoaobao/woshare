//
//  FlowCount.m
//  QYSDK
//
//  Created by 胡 波 on 13-5-2.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "FlowCount.h"
#import "RequestManager.h"
#include <ifaddrs.h>
#include <sys/socket.h>
#include <net/if.h>
#import "FVKit.h"
@implementation FlowCount
@synthesize countString=countString_;

- (id)init
{
    self = [super init];
    if (self) {
        countString_ = [[NSString alloc]init];
        currentCount_ = 0;
        lastCount_ = [self getGprs3GFlowIOBytes];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidForeground)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [countString_ release];
    [super dealloc];
}

-(NSString*)countString
{
    
    if (countString_) {
        [countString_ release];
        countString_ = nil;
    }
    long long int temp;
    if ([RequestManager sharedManager].currentReachabilityStatus == ReachableViaWWAN) {
        temp = [self getGprs3GFlowIOBytes];
    }
    else
        return nil;
    currentCount_ = currentCount_ + temp - lastCount_;
    countString_ = [[self bytesToAvaiUnit:currentCount_]retain];
    lastCount_ = temp;
    return countString_;
}

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:countString_ forKey:@"countString"];
    [aCoder encodeInt32:currentCount_ forKey:@"currentcount"];

}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if((self=[super init]))
    {
        countString_=[[aDecoder decodeObjectForKey:@"countString"]retain];
        currentCount_ = [aDecoder decodeInt32ForKey:@"currentcount"];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidForeground)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
    }
    return self;
}

-(void)applicationDidForeground
{
    lastCount_ = [self getGprs3GFlowIOBytes];
}

-(int)getGprs3GFlowIOBytes
{
    struct ifaddrs *ifa_list= 0, *ifa;
    if (getifaddrs(&ifa_list)== -1)
    {
        return 0;
    }
    
    uint32_t iBytes =0;
    uint32_t oBytes =0;
    
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next)
    {
        if (AF_LINK!= ifa->ifa_addr->sa_family)
            continue;
        
        if (!(ifa->ifa_flags& IFF_UP) &&!(ifa->ifa_flags& IFF_RUNNING))
            continue;
        
        if (ifa->ifa_data== 0)
            continue;
        
        if (!strcmp(ifa->ifa_name,"pdp_ip0"))
        {
            struct if_data *if_data = (struct if_data*)ifa->ifa_data;
            
            iBytes += if_data->ifi_ibytes;
            oBytes += if_data->ifi_obytes;
            FVLog(@"%s :iBytes is %d, oBytes is %d",ifa->ifa_name, iBytes, oBytes);
        }
    }
    freeifaddrs(ifa_list);
    
    return iBytes + oBytes;
}

- (long long int)getInterfaceBytes
{
    struct ifaddrs *ifa_list = 0, *ifa;
    if (getifaddrs(&ifa_list) == -1)
    {
        return 0;
    }
    
    uint32_t iBytes = 0;
    uint32_t oBytes = 0;
    
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next)
    {
        if (AF_LINK != ifa->ifa_addr->sa_family)
            continue;
        
        if (!(ifa->ifa_flags & IFF_UP) && !(ifa->ifa_flags & IFF_RUNNING))
            continue;
        
        if (ifa->ifa_data == 0)
            continue;
        
        /* Not a loopback device. */
        if (strncmp(ifa->ifa_name, "lo", 2))
        {
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            
            iBytes += if_data->ifi_ibytes;
            oBytes += if_data->ifi_obytes;
            
            //            NSLog(@"%s :iBytes is %d, oBytes is %d",
            //                  ifa->ifa_name, iBytes, oBytes);
        }
    }
    freeifaddrs(ifa_list);
    
    return iBytes+oBytes;
}

-(NSString*)bytesToAvaiUnit:(int)bytes
{
    if(bytes < 1024)     // B
    {
        return [NSString stringWithFormat:@"%dB", bytes];
    }
    else if(bytes >= 1024 && bytes < 1024 * 1024) // KB
    {
        return [NSString stringWithFormat:@"%.1fKB", (double)bytes / 1024];
    }
    else if(bytes >= 1024 * 1024 && bytes < 1024 * 1024 * 1024)   // MB
    {
        return [NSString stringWithFormat:@"%.2fMB", (double)bytes / (1024 * 1024)];
    }
    else    // GB
    {
        return [NSString stringWithFormat:@"%.3fGB", (double)bytes / (1024 * 1024 * 1024)];
    }
}

@end
