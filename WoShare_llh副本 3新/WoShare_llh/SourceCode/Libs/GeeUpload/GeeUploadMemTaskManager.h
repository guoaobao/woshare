//
//  GeeUploadMemTaskManager.h
//  HappyShare
//
//  Created by eingbol on 13-5-9.
//  Copyright (c) 2013年 Lin Pan. All rights reserved.
//

#import "GeeUploadBaseTaskManager.h"

@interface GeeUploadMemTaskManager : GeeUploadBaseTaskManager
{
    NSMutableArray* _taskList;
    int _index;
}

-(id)initWithUID:(NSString*)userId;
-(id)initWithUID:(NSString*)userId isRemoveCompleteTask:(BOOL)isRemove;
-(id)initWithUID:(NSString*)userId isRemoveCompleteTask:(BOOL)isRemoveComp isRemoveErrorTask:(BOOL)isRemoveError;

@end
