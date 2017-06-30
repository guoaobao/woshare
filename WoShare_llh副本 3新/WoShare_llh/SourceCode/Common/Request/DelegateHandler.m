//
//  DelegateHandler.m
//  QYSDK
//
//  Created by 胡 波 on 13-4-8.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "DelegateHandler.h"

@implementation DelegateHandler
@synthesize delegate=delegate_;
@synthesize shouldAdd=shouldAdd_;

-(id)initWithDelegate:(id)delegate shouldAdd:(BOOL)shouldAdd
{
    if((self=[super init]))
    {
        delegate_=[delegate retain];
        shouldAdd_=shouldAdd;
    }
    return self;
}

-(void)dealloc
{
    [delegate_ release];
    [super dealloc];
}

@end
