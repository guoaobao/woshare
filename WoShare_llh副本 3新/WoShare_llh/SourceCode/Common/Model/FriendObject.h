//
//  FriendObject.h
//  HappyShareSE
//
//  Created by 胡波 on 13-12-12.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendObject : NSObject
@property (nonatomic,copy)NSString *headURL;
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,copy)NSString *userID;
@property (nonatomic,assign)BOOL    selected;
@end
