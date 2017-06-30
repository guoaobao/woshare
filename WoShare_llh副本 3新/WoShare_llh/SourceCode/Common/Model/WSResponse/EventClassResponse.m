//
//  EventClassResponse.m
//  QYSDK
//
//  Created by 胡 波 on 13-5-31.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "EventClassResponse.h"
#import "EventResponse.h"
@implementation EventClassResponse
@synthesize flag;
@synthesize classid;
@synthesize classname;
@synthesize detail;
@synthesize displayorder;
@synthesize mobpic;
@synthesize mobpic2;
@synthesize mobpic3;
@synthesize pcpic;
@synthesize poster;
@synthesize template_;
@synthesize classType;
@synthesize eventlist;
@synthesize display;

-(id)initWithDict:(NSDictionary *)dict withRequestType:(RequestType)requestType{
    self = [super initWithDict:dict withRequestType:requestType];
    if (self) {
        self.flag = [dict objectForKey:@"flag"];
        self.classid = [dict objectForKey:@"classid"];
        self.classname = [dict objectForKey:@"classname"];
        self.detail = [dict objectForKey:@"detail"];
        self.displayorder = [dict objectForKey:@"displayorder"];
        self.mobpic = [dict objectForKey:@"mobpic"];
        self.mobpic2 = [dict objectForKey:@"mobpic2"];
        self.mobpic3 = [dict objectForKey:@"mobpic3"];
        self.pcpic = [dict objectForKey:@"pcpic"];
        self.poster = [dict objectForKey:@"poster"];
        self.template_ = [dict objectForKey:@"template"];
        self.classType = [self GetclassType:[dict objectForKey:@"eventlist"]];
        self.eventlist = [self GetclassideventArray:[dict objectForKey:@"eventlist"]];
        self.display = [dict objectForKey:@"display"];
    }
    return self;
}

-(NSString *)GetclassType:(NSArray *)eventlistArray{
    for (int i=0; i<[eventlistArray count]; i++) {
        EventResponse *event = [[EventResponse alloc] initWithDict:[eventlistArray objectAtIndex:i]withRequestType:self.requestType];
        if ([event.classid isEqualToString:self.classid]) {
            [event release];
            return @"1";
        }
        else
            [event release];
    }
    return @"0";
}

-(NSArray *)GetclassideventArray:(NSArray *)eventlistArray{
    NSMutableArray *classideventArray = [[[NSMutableArray alloc] init] autorelease];
    for (int i=0; i<[eventlistArray count]; i++) {
        EventResponse *event = [[EventResponse alloc] initWithDict:[eventlistArray objectAtIndex:i]withRequestType:self.requestType];
        if ([event.classid isEqualToString:self.classid]) {
            [classideventArray addObject:event];
        }
        [event release];
    }
    return classideventArray;
}

-(void)dealloc{
    
    [flag release];
    [classid release];
    [classname release];
    [detail release];
    [displayorder release];
    [mobpic release];
    [mobpic2 release];
    [mobpic3 release];
    [pcpic release];
    [poster release];
    [template_ release];
    [classType release];
    [eventlist release];
    [display release];
    [super dealloc];
}
@end
