//
//  FVImageCache.h
//  FVKit
//
//  Created by 胡 波 on 13-3-27.
//
//

#import <Foundation/Foundation.h>

@interface FVImageCache : NSObject
{	
	NSMutableDictionary         *images;
    NSMutableDictionary         *imageCache;
	NSLock                      *dictLock;
    NSFileManager               *fm;
}

+(FVImageCache*)sharedImageCache;
+(void)purgeSharedImageCache;

//Use this method to load bundle image, support .png images
-(UIImage*)imageNamed:(NSString*)fileName Cache:(BOOL)shouldCache;
//Use this method to load doucument image, support .png images
-(UIImage*)imageWithFilePath:(NSString*)filePath Cache:(BOOL)shouldCache;

-(UIImage*)image2xNamed:(NSString*)fileName Cache:(BOOL)shouldCache;

//-(UIImage*)imageWithUrl:(NSString*)url Cache:(BOOL)shouldCache WriteToFile:(BOOL)shouldWrite;

-(UIImage*)imageWithFid:(NSString*)fid Cache:(BOOL)shouldCache;

-(void)addImage:(UIImage*)image forKey:(NSString*)key;
-(void)addImage:(UIImage*)image forFid:(NSString*)key;

-(UIImage*)imageForKey:(NSString*)key;
-(void)removeUnusedImages;
-(void)removeImageForKey:(NSString*)key;
-(void)removeAllImages;
-(void)removeImage:(UIImage*)image;

@end
