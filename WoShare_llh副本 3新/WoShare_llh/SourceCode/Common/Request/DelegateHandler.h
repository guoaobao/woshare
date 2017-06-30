//
//  DelegateHandler.h
//  QYSDK
//
//  Created by 胡 波 on 13-4-8.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DelegateHandler : NSObject {
    
    id          delegate_;
    BOOL        shouldAdd_;
    
}

@property (nonatomic, retain) id    delegate;
@property (nonatomic, assign) BOOL  shouldAdd;

-(id)initWithDelegate:(id)delegate shouldAdd:(BOOL)shouldAdd;

@end
