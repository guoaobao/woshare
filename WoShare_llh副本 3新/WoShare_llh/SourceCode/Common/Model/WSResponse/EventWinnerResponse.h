//
//  EventWinnerResponse.h
//
//  Created by 波 胡 on 13-6-3
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "UserInfoResponse.h"


@interface EventWinnerResponse : UserInfoResponse

@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSString *eventid;
@property (nonatomic, retain) NSString *internalBaseClassIdentifier;
@property (nonatomic, retain) NSString *prize;
@property (nonatomic, retain) NSString *level;
@property (nonatomic, retain) NSString *dateline;
@property (nonatomic, retain) NSString *avatar;
@property (nonatomic, retain) NSString *award;
- (NSDictionary *)dictionaryRepresentation;

@end
