//
//  ChildrenCategoryResponse.h
//  QYSDK
//
//  Created by 胡 波 on 13-4-24.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "BaseResponse.h"

@interface ChildrenCategoryResponse : BaseResponse
@property(retain,nonatomic)NSString *pid;
@property(retain,nonatomic)NSString *catid;
@property(retain,nonatomic)NSString *catname;
@property(retain,nonatomic)NSString *catcode;
@property(retain,nonatomic)NSString *description;
@property(retain,nonatomic)NSString *sort;
@property(retain,nonatomic)NSString *usestatus;
@end
