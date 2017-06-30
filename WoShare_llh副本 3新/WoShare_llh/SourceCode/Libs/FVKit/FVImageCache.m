//
//  FVImageCache.m
//  FVKit
//
//  Created by 胡 波 on 13-3-27.
//
//

#import "FVImageCache.h"
#import "FVKit.h"
@implementation FVImageCache

static FVImageCache *sharedImageCacheInstance_=nil;

+(FVImageCache*)sharedImageCache
{
	@synchronized(self)
	{
		if(!sharedImageCacheInstance_)
			sharedImageCacheInstance_=[[self alloc] init];
		return sharedImageCacheInstance_;
	}
	return nil;
}

+(id)alloc
{
	NSAssert(sharedImageCacheInstance_==nil, @"Attempted to allocate a second instance of a singleton.");
	return [super alloc];
}

+(void)purgeSharedImageCache
{
	[sharedImageCacheInstance_ release];
	sharedImageCacheInstance_=nil;
}

-(id)init
{
	if((self=[super init]))
	{
		images=[[NSMutableDictionary alloc] initWithCapacity:10];
        imageCache = [[NSMutableDictionary alloc]initWithCapacity:10];
		dictLock=[[NSLock alloc] init];
        fm = [[NSFileManager alloc]init];
	}
	return self;
}

-(void)dealloc
{
	[images release];
	[dictLock release];
    [fm release];
    [imageCache release];
	[super dealloc];
}

#pragma mark Get Image

-(UIImage*)imageNamed:(NSString*)fileName Cache:(BOOL)shouldCache
{
	if(fileName==nil)
	{
		FVLog(@"FVImageCache: file name should not be nil");
		return nil;
	}
	if (![fileName hasSuffix:@".png"])
	{
		fileName = [NSString stringWithFormat:@"%@.png", fileName];
	}
	
	[dictLock lock];
	
	UIImage *img=[[[images objectForKey:fileName] retain] autorelease];
	if(img==nil)
	{
		NSString *file = [fileName lastPathComponent];
		NSString *imageDirectory = [fileName stringByDeletingLastPathComponent];
		NSString *path=[[NSBundle mainBundle] pathForResource:file
                                                       ofType:nil
                                                  inDirectory:imageDirectory];
		img=[[[UIImage alloc] initWithContentsOfFile:path] autorelease];
		if(shouldCache&&img!=nil)
			[images setObject:img forKey:fileName];
	}
	
	[dictLock unlock];
	return img;
}

-(UIImage*)imageWithFilePath:(NSString*)filePath Cache:(BOOL)shouldCache
{
	if(filePath==nil)
	{
		FVLog(@"FVImageCache: file path should not be nil");
		return nil;
	}
	
	[dictLock lock];
	
	UIImage *img=[[[images objectForKey:filePath] retain] autorelease];
	if(img==nil)
	{
		img=[[[UIImage alloc] initWithContentsOfFile:filePath] autorelease];
		if(shouldCache&&img!=nil)
			[images setObject:img forKey:filePath];
	}
	
	[dictLock unlock];
	return img;
}

-(UIImage*)image2xNamed:(NSString*)fileName Cache:(BOOL)shouldCache
{
    if(fileName==nil)
	{
		FVLog(@"FVImageCache: file name should not be nil");
		return nil;
	}
	if (![fileName hasSuffix:@".png"])
	{
		fileName = [NSString stringWithFormat:@"%@.png", fileName];
	}
	
	[dictLock lock];
	
	UIImage *img=[[[images objectForKey:fileName] retain] autorelease];
	if(img==nil)
	{
		NSString *file = [fileName lastPathComponent];
		NSString *imageDirectory = [fileName stringByDeletingLastPathComponent];
		NSString *path=[[NSBundle mainBundle] pathForResource:file
                                                       ofType:nil
                                                  inDirectory:imageDirectory];
        NSData *data=[[[NSData alloc] initWithContentsOfFile:path] autorelease];
        img=[[[UIImage alloc] initWithData:data] autorelease];
		if(shouldCache&&img!=nil)
			[images setObject:img forKey:fileName];
	}
	
	[dictLock unlock];
	return img;
}

-(UIImage*)imageWithUrl:(NSString *)url Cache:(BOOL)shouldCache
{
    if(url==nil)
	{
		FVLog(@"FVImageCache: url should not be nil");
		return nil;
	}
    FVLog(@"image url is %@",url);
	
	[dictLock lock];
	__block UIImage *img=[images objectForKey:url];
    if (img==nil) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            img = [UIImage imageWithData:imageData];
        });
        if (shouldCache&&img!=nil) {
            [images setObject:img forKey:url];
        }
    }
	[dictLock unlock];
	return [[img retain]autorelease];
}

-(UIImage*)imageWithFid:(NSString*)fid Cache:(BOOL)shouldCache
{
    if(fid==nil)
	{
		FVLog(@"FVImageCache: fid should not be nil");
		return nil;
	}
    FVLog(@"image fid is %@",fid);
	
	[dictLock lock];
    UIImage *img=[[[images objectForKey:fid] retain] autorelease];
    if (img == nil) {
        NSString *rootPath= FVGetPathWithType(kFVPathTypePicCache, nil);
        NSString *path = [rootPath stringByAppendingPathComponent:fid];
        NSData *data=[[[NSData alloc] initWithContentsOfFile:path] autorelease];
        img=[[[UIImage alloc] initWithData:data] autorelease];
        if(shouldCache&&img!=nil)
			[images setObject:img forKey:fid];
    }
	[dictLock unlock];
	return img;

}

/*
-(UIImage*)imageWithUrl:(NSString *)url Cache:(BOOL)shouldCache WriteToFile:(BOOL)shouldWrite
{
    if(url==nil)
	{
		FVLog(@"FVImageCache: url should not be nil");
		return nil;
	}
    FVLog(@"image url is %@",url);
	
	[dictLock lock];
    UIImage *img=[images objectForKey:url];
    if (img==nil) {
        NSString *temp = FVGetPathWithType(kFVPathTypePicCache, nil);
        NSString *path=[temp stringByAppendingPathComponent:url];
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:path];
        if (isExist) {
            img = [UIImage imageWithContentsOfFile:path];
        }
        else
        {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
                UIImage *temp = [[UIImage imageWithData:imageData]retain];
                [imageCache setObject:temp forKey:url];
            });
        }
        img = [imageCache objectForKey:url];
        [imageCache removeObjectForKey:url];
        if (shouldCache&&img!=nil) {
            [images setObject:img forKey:url];
        }
        if (shouldWrite&&img!=nil) {
            NSData *data = UIImageJPEGRepresentation(img, 1);
            if (data == nil) {
                data = UIImagePNGRepresentation(img);
            }
            [data writeToFile:path atomically:YES];
        }
    }
    //[data release];
	[dictLock unlock];
	return [[img retain]autorelease];
}*/

-(void)addImage:(UIImage*)image forKey:(NSString*)key
{
    if(image==nil||key==nil)
        return;
    [dictLock lock];
    
    NSData *data = UIImageJPEGRepresentation(image, 1);
    if (data == nil) {
        data = UIImagePNGRepresentation(image);
    }
    NSString *rootPath= FVGetPathWithType(kFVPathTypePicCache, nil);
    NSString *path = [rootPath stringByAppendingPathComponent:key];
    [data writeToFile:path atomically:YES];
    [images setObject:image forKey:key];
    
    [dictLock unlock];
}

-(void)addImage:(UIImage*)image forFid:(NSString*)key
{
    if(image==nil||key==nil)
        return;
    [dictLock lock];
    
    [images setObject:image forKey:key];
    
    [dictLock unlock];
}


-(UIImage*)imageForKey:(NSString*)key
{
    if(key==nil)
        return nil;
    [dictLock lock];
    
    UIImage *image=[[[images objectForKey:key] retain] autorelease];
    
    [dictLock unlock];
    
    return image;
}

#pragma mark Remove From Cache

-(void)removeUnusedImages
{
	[dictLock lock];
	
	NSArray *allKeys=[images allKeys];
	for(id key in allKeys)
	{
		id value=[images objectForKey:key];
		if([value retainCount]==1)
			[images removeObjectForKey:key];
	}
	
	[dictLock unlock];
}
-(void)removeImageForKey:(NSString*)key
{
	if(key==nil)
		return;
	[dictLock lock];
	[images removeObjectForKey:key];
	[dictLock unlock];
}

-(void)removeAllImages
{
	[dictLock lock];
	[images removeAllObjects];
	[dictLock unlock];
}

-(void)removeImage:(UIImage*)image
{
	if(image==nil)
		return;
	
	[dictLock lock];
	NSArray *keys=[images allKeysForObject:image];
	for(id key in keys)
	{
		[images removeObjectForKey:key];
	}
	[dictLock unlock];
}
@end

