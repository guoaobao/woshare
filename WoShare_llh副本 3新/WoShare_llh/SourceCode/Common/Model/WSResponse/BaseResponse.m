//
//  BaseResponse.m
//  QYSDK
//
//  Created by 胡 波 on 13-4-23.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "BaseResponse.h"
#import "NSResponse.h"
#import "CommentResponse.h"
#import "UserInfoResponse.h"
#import "FavouriteResponse.h"
#import "EventFileResponse.h"
#import "DiskResponse.h"
#import "EventResponse.h"
#import "MessageResponse.h"
#import "ScheduleResponse.h"
#import "GuestResponse.h"
#import "TopCategoryResponse.h"
#import "ChildrenCategoryResponse.h"
#import "HotWordsResponse.h"
#import "PersonResponse.h"
#import "EventWinnerResponse.h"
#import "SNSUserResponse.h"
#import "CategoryResponse.h"
#import "InfoListResponse.h"
@implementation BaseResponse
@synthesize requestType=requestType_;
-(id)initWithDict:(NSDictionary *)dict withRequestType:(RequestType)requestType
{
    self = [super init];
    if (self) {
        requestType_ = requestType;
        _creatdDate = [NSDate date];
    }
    return self;
}

+(id)infoWithDict:(NSDictionary *)dict withRequestType:(RequestType)requestType
{
    if (requestType == kRequestTypeGetSpaceStatInfo)
        return [[[DiskResponse alloc]initWithDict:dict withRequestType:requestType]autorelease];
    else if (requestType == kRequestTypeGetAppCategory||
             requestType == kRequestTypeGetEventList||
             requestType == kRequestTypeGetEventInfo||
             requestType == kRequestTypeGetJoinedEventList)
        return [[[EventResponse alloc]initWithDict:dict withRequestType:requestType]autorelease];
    
    else if (requestType == kRequestTypeGetTopCategory ||
             requestType == kRequestTypeGetPicDataList)
        return [[[CategoryResponse alloc]initWithDictionary:dict]autorelease];
    
    else if (requestType == kRequestTypeGetChildrenBlock)
        return [[[ChildrenCategoryResponse alloc]initWithDict:dict withRequestType:requestType]autorelease];
    
    else if (requestType == kRequestTypeGetBlockUserList ||
             requestType == kRequestTypeSearchUser||
             requestType == kRequestTypeGetHotUserList||
             requestType == kRequestTypeGetEventUserList||
             requestType == kRequestTypeGetLinkInviteList||
             requestType == kRequestTypeGetLinkSearchList||
             requestType == kRequestTypeGetCollectInfoList)
        return [[[UserInfoResponse alloc]initWithDict:dict withRequestType:requestType]autorelease];
    
    else if (requestType == kRequestTypeGetScheduleList)
        return [[[ScheduleResponse alloc]initWithDict:dict withRequestType:requestType]autorelease];
    
    else if (requestType == kRequestTypeGetHotWordsList)
        return [[[HotWordsResponse alloc]initWithDict:dict withRequestType:requestType]autorelease];
    
    else if (requestType == kRequestTypeGetPrizeList){}
    
    else if (requestType == kRequestTypePrize){}
    
    else if (requestType == kRequestTypeGetPersonageList ||
             requestType == kRequestTypeGetNoteList)
        return [[[PersonResponse alloc]initWithDict:dict withRequestType:requestType]autorelease];
    
    else if (requestType == kRequestTypeGetEventWinnerList)
        return [[[EventWinnerResponse alloc]initWithDict:dict withRequestType:requestType]autorelease];
    
    else if (requestType == kRequestTypeGetSNSInviteList)
        return [[[SNSUserResponse alloc]initWithDict:dict withRequestType:requestType]autorelease];
    
    else if (requestType == kRequestTypeGetInfoInfo)
        return [[[InfoListResponse alloc]initWithDictionary:dict]autorelease];
    return nil;
}

- (void)dealloc
{
    [super dealloc];
}
#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
