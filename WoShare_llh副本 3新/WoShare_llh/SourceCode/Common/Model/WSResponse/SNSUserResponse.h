//
//  SNSUserResponse.h
//  F4WoPai
//
//  Created by liuleijie on 13-6-9.
//  Copyright (c) 2013年 zlvod. All rights reserved.
//

#import "BaseResponse.h"

@interface SNSUserResponse : BaseResponse

//新浪
@property(nonatomic, retain) NSString *avatar;
@property(nonatomic, retain) NSString *nickname;
@property(nonatomic, retain) NSString *snsuid;

//通讯录

@property(nonatomic, retain) NSString *uid;
@property(nonatomic, retain) NSString *username;
@property(nonatomic, retain) NSString *mobile;
@property(nonatomic, retain) NSString *mood;
@property(nonatomic, retain) NSString *truename;
@end
