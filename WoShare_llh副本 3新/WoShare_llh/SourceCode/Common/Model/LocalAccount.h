//
//  LocalAccount.h
//  QYSDK
//
//  Created by 胡 波 on 13-4-9.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalAccount : NSObject <NSCoding>
{
    NSString            *username_;
    NSString            *password_;
    NSString            *token_;
}
@property (nonatomic,retain)NSString    *username;
@property (nonatomic,retain)NSString    *password;
@property (nonatomic,retain)NSString    *token;
@end
