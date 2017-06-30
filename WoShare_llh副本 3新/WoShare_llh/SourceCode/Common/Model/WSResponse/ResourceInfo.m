//
//  ResourceInfo.m
//  HappyShare
//
//  Created by Lin Pan on 13-4-11.
//  Copyright (c) 2013年 Lin Pan. All rights reserved.
//

#import "ResourceInfo.h"
@implementation ResourceInfo


- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self)
    {
        self.resourceId = [dic objectForKey:@"_id"];
        self.name = [dic objectForKey:@"nm"];
        self.publishTime = [NSString stringWithDate:[NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"sst"] floatValue]] formater:@"yyyy-MM-dd"];
        self.ext = [dic objectForKey:@"ext"];
        self.size = [NSString stringWithSize:[[dic objectForKey:@"fsize"] floatValue]];
        self.resourceUid = [dic objectForKey:@"uid"];
        self.title = [dic objectForKey:@"title"];
        self.shareStatus = [dic objectForKey:@"ss"];
        self.shareTime =  [dic objectForKey:@"st"];
        self.reviewTime = [dic objectForKey:@"at"];
        self.reviewDesc = [dic objectForKey:@"asd"];
        self.fid = [dic objectForKey:@"fid"];
        self.fsize = [dic objectForKey:@"fsize"];
        NSString *reviewStatus = [dic objectForKey:@"as"];
        if ([reviewStatus intValue] > 0)
        {
            self.reviweStatus = kReviewOK;
        }
        else if([reviewStatus intValue] == 0)
        {
            self.reviweStatus = kReviewWaiting;
        }
        else if([reviewStatus intValue] < 0)
        {
            self.reviweStatus = kReviewNo;
        }
        
        if ([[dic objectForKey:@"idtype"]isEqualToString:@"info"]) {
            self.isResource = NO;
        }
        else
        {
            self.isResource = YES;
        }
        NSString *brief = [dic objectForKey:@"brief"];
        self.brief = [brief length] > 0? brief : kDefaultResourceBrief;
        id pts = [dic objectForKey:@"pts"];
        if (pts == nil)
        {
           self.likedCount = @"0";
        }
        else
        {
            self.likedCount = [NSString stringWithFormat:@"%@",pts];
        }
        
        self.collectCount = [NSString stringWithFormat:@"%@",[dic objectForKey:@"fts"]];
        self.voteCount = [NSString stringWithFormat:@"%@",[dic objectForKey:@"vts"]];
        if ([self.voteCount isEqualToString:@"(null)"])
        {
            self.voteCount = @"0";
        }
        if (![[dic objectForKey:@"pic"] isKindOfClass:[NSNull class]]) {
            self.thumbs = [self getPicArr:[dic objectForKey:@"pic"]];
        }
        else
        {
            NSMutableArray *temp = [[NSMutableArray alloc]initWithCapacity:0];
            self.thumbs = temp;
            [temp release];
        }
        NSString *type = [dic objectForKey:@"ft"];
        switch ([type intValue])
        {
            case 1:
                self.type = kResourceVideo;
                break;
            case 2:
                self.type = kResourceVoice;
                break;
            case 3:
                self.type = kResourcePicture;
                break;
            case 4:
                self.type = kResourceDocument;
                break;
            default:
                self.type = kResourceUnknow;
                break;
        }
        self.playUrl = [NSString stringWithFormat:@"%@%@",[Config shareInstance].resourceDownUrl,self.resourceId];
    }
    
    return self;
}

- (NSArray *)getPicArr:(NSDictionary *)dic
{
    NSMutableArray *picArr = [[[NSMutableArray alloc] init] autorelease];

    if (dic&&[dic count] >= 4)
    {
        for (int i = 1; i <=4; ++i)
        {
            NSString *pic = [dic objectForKey:[NSString stringWithFormat:@"%d",i]];
            [picArr addObject:pic];
        }
    }
    return picArr;
}

- (void)dealloc
{
    [_resourceId release];
    [_name release];
    [_publishTime release];
    [_ext release];
    [_size release];
    [_resourceUid release];
    [_title release];
    [_shareStatus release];
    [_shareTime release];
    [_reviewTime release];
    [_brief release];
    [_likedCount release];
    [_collectCount release];
    [_thumbs release];
    [_commentions release];
//    [self.picBaseUrl release];
    [_userinfo release];
    [_voteCount release];
    [_reviewDesc release];
    [_fid release];
    [_fsize release];
    [_originalUrl release];
    [super dealloc];
}


- (NSString *)getBiggestImageURLString
{
    if ([self.thumbs count] == 4)
    {
        NSString *url = [self.thumbs objectAtIndex:0];
        return url;
    }
    return nil;
}
- (NSString *)getMidImageURlString
{
    if ([self.thumbs count] == 4)
    {
        return [self.thumbs objectAtIndex:3];
    }
    return  nil;
}

- (NSString *)getSmallestImageURLString
{
    if ([self.thumbs count] == 4)
    {
        return [self.thumbs objectAtIndex:2];
    }
    return  nil;
}

@end
