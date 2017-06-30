//
//  NSResponse.m
//  QYSDK
//
//  Created by 胡 波 on 13-4-23.
//  Copyright (c) 2013年 胡 波. All rights reserved.
//

#import "NSResponse.h"

@implementation NSResponse
@synthesize ss,ssr,sst,suid,as,at,cids,tags,mark,pid,prop,org,_id,isdir,fc,fid,fsize,ft,nm,ext,dc,dlc,cltp,ct,uid,ut,luid,title,brief,pic,cts,dts,fts,pts,tts,cmtids,width,height,ms,vts;
- (void)dealloc
{
    
    [suid release];
    [cids release];
    [tags release];
    [mark release];
    [pid release];
    [org release];
    [_id release];
    [fid release];
    [nm release];
    [ext release];
    [cltp release];
    [uid release];
    [luid release];
    [title release];
    [brief release];
    [pic release];
    [cmtids release];
    [vts release];
    [super dealloc];
}
-(id)initWithDict:(NSDictionary *)dict withRequestType:(RequestType)requestType
{
    self = [super initWithDict:dict withRequestType:requestType];
    if (self)
    {
        self._id    = [dict objectForKey:@"_id"];
        
        NSString *reviewStatus = [dict objectForKey:@"as"];
        if ([reviewStatus intValue] > 0)
        {
            self.as = kReviewOK;
        }
        else if([reviewStatus intValue] == 0)
        {
            self.as = kReviewWaiting;
        }
        else if([reviewStatus intValue] < 0)
        {
            self.as = kReviewNo;
        }
        self.vts    = [dict objectForKey:@"vts"];
        self.at     = [[dict objectForKey:@"at"]doubleValue];
        self.cids   = [dict objectForKey:@"cids"];
        self.cltp   = [dict objectForKey:@"cltp"];
        self.ct     = [[dict objectForKey:@"ct"]doubleValue];
        self.dc     = [[dict objectForKey:@"dc"]doubleValue];
        self.dlc    = [[dict objectForKey:@"dlc"]doubleValue];
        self.ext    = [dict objectForKey:@"ext"];
        self.fc     = [[dict objectForKey:@"fc"]doubleValue];
        self.fid    = [dict objectForKey:@"fid"];
        self.fsize  = [[dict objectForKey:@"fsize"]doubleValue];
        self.isdir  = [[dict objectForKey:@"isdir"]boolValue];
        self.luid   = [dict objectForKey:@"luid"];
        self.suid   = [dict objectForKey:@"suid"];
        self.mark   = [dict objectForKey:@"mark"];
        self.nm     = [dict objectForKey:@"nm"];
        self.org    = [dict objectForKey:@"org"];
        self.pid    = [dict objectForKey:@"pid"];
        self.prop   = [[dict objectForKey:@"prop"]doubleValue];
        self.ss     = [[dict objectForKey:@"ss"]doubleValue];
        self.sst    = [[dict objectForKey:@"sst"]doubleValue];
        self.ssr    = [[dict objectForKey:@"ssr"]doubleValue];
        self.suid   = [dict objectForKey:@"suid"];
        self.tags   = [dict objectForKey:@"tags"];
        self.title  = [dict objectForKey:@"title"];
        self.uid    = [dict objectForKey:@"uid"];
        self.brief  = [[dict objectForKey:@"brief"] length]>0?[dict objectForKey:@"brief"]:kDefaultResourceBrief;
        self.cts    = [[dict objectForKey:@"cts"]doubleValue];
        self.dts    = [[dict objectForKey:@"dts"]doubleValue];
        self.fts    = [[dict objectForKey:@"fts"]doubleValue];
        self.pts    = [[dict objectForKey:@"pts"]doubleValue];
        self.tts    = [[dict objectForKey:@"tts"]doubleValue];
        self.cmtids = [dict objectForKey:@"cmtids"];
        self.height = [[dict objectForKey:@"height"]doubleValue];
        self.width  = [[dict objectForKey:@"width"]doubleValue];
        self.ms     = [[dict objectForKey:@"ms"]doubleValue];
        
        if (![[dict objectForKey:@"pic"] isKindOfClass:[NSNull class]]) {
            self.pic = [self getPicArr:[dict objectForKey:@"pic"]];
        }
        else
        {
            NSMutableArray *temp = [[NSMutableArray alloc]initWithCapacity:0];
            self.pic = temp;
            [temp release];
        }
        
        NSString *type = [dict objectForKey:@"ft"];
        switch ([type intValue])
        {
            case 1:
                self.ft = kResourceVideo;
                break;
            case 2:
                self.ft = kResourceVoice;
                break;
            case 3:
                self.ft = kResourcePicture;
                break;
            case 4:
                self.ft = kResourceDocument;
                break;
            default:
                self.ft = kResourceUnknow;
                break;
        }

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
            NSString *pict = [dic objectForKey:[NSString stringWithFormat:@"%d",i]];
            [picArr addObject:pict];
        }
    }
    return picArr;
}

- (NSString *)getBiggestImageURLString
{
    if ([self.pic count] == 4)
    {
        return [self.pic objectAtIndex:0];
    }
    return nil;
}
- (NSString *)getMidImageURlString
{
    if ([self.pic count] == 4)
    {
        return [self.pic objectAtIndex:3];
    }
    return  nil;
}

- (NSString *)getSmallestImageURLString
{
    if ([self.pic count] == 4)
    {
        return [self.pic objectAtIndex:2];
    }
    return  nil;
}

@end
