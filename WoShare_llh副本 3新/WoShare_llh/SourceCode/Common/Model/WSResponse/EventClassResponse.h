//
//  EventClassResponse.h
//  QYSDK
//
//  Created by 胡 波 on 13-5-31.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "BaseResponse.h"

@interface EventClassResponse : BaseResponse
@property(nonatomic,retain)NSString *flag;
@property(nonatomic,retain)NSString *classid;
@property(nonatomic,retain)NSString *classname;
@property(nonatomic,retain)NSString *detail;
@property(nonatomic,retain)NSString *displayorder;
@property(nonatomic,retain)NSString *mobpic;
@property(nonatomic,retain)NSString *mobpic2;
@property(nonatomic,retain)NSString *mobpic3;
@property(nonatomic,retain)NSString *pcpic;
@property(nonatomic,retain)NSString *poster;
@property(nonatomic,retain)NSString *template_;
@property(nonatomic,retain)NSArray *eventlist;
@property(nonatomic,retain)NSString *classType;
@property(nonatomic,retain)NSString *display;
@end
