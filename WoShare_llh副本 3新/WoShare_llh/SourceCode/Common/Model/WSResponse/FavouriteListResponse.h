//
//  FavouriteListResponse.h
//  QYSDK
//
//  Created by 胡 波 on 13-5-14.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "BaseResponse.h"
#import "FavouriteResponse.h"
#import "NSResponse.h"
#import "UserInfoResponse.h"
@interface FavouriteListResponse : BaseResponse
@property (nonatomic, retain) FavouriteResponse     *favorite;
@property (nonatomic, retain) NSResponse            *nameSpace;
@property (nonatomic, retain) UserInfoResponse      *userInfo;
@property (nonatomic, retain) NSMutableArray        *commentUser;
@property (nonatomic, retain) NSMutableArray        *commentArray;
@property (nonatomic, copy)   NSString              *picbaseurl;
@end
