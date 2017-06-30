//
//  FVUtility.m
//  FVKit
//
//  Created by 胡 波 on 13-3-27.
//
//

#import "FVUtility.h"
#import "CommonCrypto/CommonDigest.h"
#include <sys/stat.h>
#include <dirent.h>
#include "des.h"
#include "zlfs_util.h"
//#include "base64.h"
#import "FVKit.h"
#import "GTBase64.h"
#import <CommonCrypto/CommonCryptor.h>
#define kDesKey @"hnaction"

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation UIImage (FVUtility)
+(UIImage *)imageNamedWithoutCache:(NSString *)fileName
{
	if(fileName==nil)
	{
		FVLog(@"Image without cache");
		return nil;
	}
	
	if (![fileName hasSuffix:@".png"])
	{
		fileName = [NSString stringWithFormat:@"%@.png", fileName];
	}
	
	NSString *path=[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
	UIImage *img=[[[self alloc] initWithContentsOfFile:path] autorelease];
	return img;
}

+ (UIImage *)rotateImage:(UIImage *)aImage
{
    CGImageRef imgRef = aImage.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    CGFloat scaleRatio = 1;
    CGFloat boundHeight;
    UIImageOrientation orient = aImage.imageOrientation;
    switch(orient)
    {
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(width, height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
    }
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageCopy;
}

+ (UIImage *) imageFromURLString: (NSString *) urlstring
{
    // This call is synchronous and blocking
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlstring]]];
}

+ (UIImage *) imageFromView: (UIView *) theView
{
    // Draw a view’s contents into an image context
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (UIImage*)scaleToSize:(CGSize)newSize {
	UIGraphicsBeginImageContext(newSize);
	CGRect imageRect = CGRectMake(0.0, 0.0, newSize.width, newSize.height);
	[self drawInRect:imageRect];
	UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return scaledImage;
}

- (UIImage*)screenshot
{
    // Create a graphics context with the target size
    // On iOS 4 and later, use UIGraphicsBeginImageContextWithOptions to take the scale into consideration
    // On iOS prior to 4, fall back to use UIGraphicsBeginImageContext
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
    if (NULL != UIGraphicsBeginImageContextWithOptions)
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    else
        UIGraphicsBeginImageContext(imageSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    // Iterate over every window from back to front
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen])
        {
            // -renderInContext: renders in the coordinate space of the layer,
            // so we must first apply the layer's geometry to the graphics context
            CGContextSaveGState(context);
            // Center the context around the window's anchor point
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            // Apply the window's transform about the anchor point
            CGContextConcatCTM(context, [window transform]);
            // Offset by the portion of the bounds left of and above the anchor point
            CGContextTranslateCTM(context,
                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
                                  -[window bounds].size.height * [[window layer] anchorPoint].y);
            // Render the layer hierarchy to the current context
            [[window layer] renderInContext:context];
            // Restore the context
            CGContextRestoreGState(context);
        }
    }
    // Retrieve the screenshot image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(UIImage *) getImageFromURL:(NSString *)fileURL {
    FVLog(@"执行图片下载函数");
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}

- (UIImage *)fixOrientation {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
            
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationLeft:
        case UIImageOrientationDown:
        case UIImageOrientationRight:
        case UIImageOrientationUp:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


@end

@implementation NSString (FVUtility)
+(id)stringUUID
{
    CFUUIDRef uuid=CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidString=(NSString*)CFUUIDCreateString(kCFAllocatorDefault, uuid);
    CFRelease(uuid);
    FVLog(@"Create a new uuid: %@",uuidString);
    return [uuidString autorelease];
}

+(NSString*)stringWithTime:(NSTimeInterval)time showHour:(BOOL)showHour
{
    if(showHour)
        return [self stringWithTime:time showZeroHour:YES];
    else
    {
        NSInteger timeInt=(NSInteger)time;
        NSInteger minute=timeInt/60;
        NSInteger second=timeInt%60;
        NSString *s=[NSString stringWithFormat:@"%02d:%02d",minute,second];
        return s;
    }
}

+(NSString*)stringWithTime:(NSTimeInterval)time
{
    NSInteger timeInt=(NSInteger)time;
    NSInteger hour=timeInt/3600;
    timeInt=timeInt%3600;
    NSInteger minute=timeInt/60;
    NSInteger second=timeInt%60;
    NSMutableString *s=[NSMutableString string];
    if(hour>0)
        [s appendFormat:@"%02d:",hour];
    [s appendFormat:@"%02d:%02d",minute,second];
    return s;
}

+(NSString*)stringWithTime:(NSTimeInterval)time showZeroHour:(BOOL)hour
{
    if(hour==NO)
        return [self stringWithTime:time];
    else
    {
        NSInteger timeInt=(NSInteger)time;
        NSInteger hour=timeInt/3600;
        timeInt=timeInt%3600;
        NSInteger minute=timeInt/60;
        NSInteger second=timeInt%60;
        NSMutableString *s=[NSMutableString string];
        [s appendFormat:@"%02d:%02d:%02d",hour,minute,second];
        return s;
    }
}

+(NSString*)stringwithMd5Encode:(NSString*)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2],  result[3],
            result[4],  result[5],  result[6],  result[7],
            result[8],  result[9],  result[10],  result[11],
            result[12],  result[13],  result[14],  result[15]
            ];
}


+(NSString *)createPostURL:(NSDictionary *)params
{
    NSString *postString=@"";
    for(NSString *key in [params allKeys])
    {
        NSString *value=[params objectForKey:key];
        postString=[postString stringByAppendingFormat:@"%@=%@&",key,value];
    }
    if([postString length]>1)
    {
        postString=[postString substringToIndex:[postString length]-1];
    }
    return postString;
}

-(NSString*)stringWithUrlEncode
{
    NSString *result=(NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR("?#[]@!$'()*+,;="), kCFStringEncodingUTF8);
	return [result autorelease];
}

-(NSString*)stringWithUrlDecode
{
    NSString *result=(NSString*)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                        (CFStringRef)self,
                                                                                        CFSTR("?#[]@!$'()*+,;="),
                                                                                        kCFStringEncodingUTF8);
    return [result autorelease];
}

-(NSString*)stringWithNumberOnly
{
    NSCharacterSet *set=[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    return [[self componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
}

- (NSString *)stringFormDict:(NSDictionary*)dict
{
    NSMutableString *str = [NSMutableString string];
    NSArray *keys = [dict allKeys];
    for (NSString *key in keys) {
        if ([[dict objectForKey:key] isKindOfClass:[NSDictionary class]]) {
            id obj = [dict objectForKey:key];
            [str appendFormat:@"\n%@: %@",key,[self stringFormDict:obj]];
        }else if ([[dict objectForKey:key] isKindOfClass:[NSArray class]]){
            [str appendFormat:@"\n%@:",key];
            for (id obj in [dict objectForKey:key]) {
                [str appendFormat:@"\n%@",[self stringFormDict:obj]];
            }
        }else{
            [str appendFormat:@"\n%@: %@",key,[dict objectForKey:key]];
        }
    }
    return str;
}

+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailRegex];
    return [emailTest evaluateWithObject:email];
}

+(NSString *)deletePhoneNumber:(NSString*)string
{
    if ([NSString JudgmentMobilePhoneNumber:string]) {
        NSMutableString *String1 = [[NSMutableString alloc] initWithString:string];
        [String1 replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        return [NSString stringWithFormat:@"%@",String1];
    }
    else
        return string;
}

+(BOOL)JudgmentMobilePhoneNumber:(NSString *)number{
    NSString *regPred = @"^((861)|(\\+861)|1)(3[0-2]|5[56]|8[56])\\d{8}$";
    NSPredicate *newDisposalStr = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regPred];
    
    if ([newDisposalStr evaluateWithObject:number]) {
        return YES;
    }
    return NO;
}

+ (NSString *)stringWithDate:(NSDate *)date formater:(NSString *)formater
{
    if (!date) {
        return  nil;
    }
    if (!formater) {
        formater = @"yyyy-MM-dd";
    }
    
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formater];
    return [formatter stringFromDate:date];
}

+ (int)caluNumberOfString:(NSString *)str
{
    int len = 0;
    for (int i = 0; i < [str length]; ++i)
    {
        NSString *singleStr = [str substringWithRange:NSMakeRange(i, 1)];
        
        NSString *reg = [NSString stringWithFormat:@"[\u4e00-\u9fa5]{1,}$"];
        NSPredicate *newDisposalStr = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg];
        if([newDisposalStr evaluateWithObject:singleStr])
        {
            len += 2;
        }
        else
        {
            len++;
        }
    }
    return len;
}

+ (int)caluLabelHeight:(NSString *)str contentWidth:(CGFloat)width fontsize:(int)size
{
    if (![str isKindOfClass:[NSNull class]] && [str length] > 0)
    {
        // 用何種字體進行顯示
        UIFont *font = [UIFont systemFontOfSize:size];
        // 計算出顯示完內容需要的最小尺寸
        CGSize fsize = [str sizeWithFont:font constrainedToSize:CGSizeMake(width, 1000) lineBreakMode:NSLineBreakByWordWrapping];
        // 這裏返回需要的高度
        //        return fsize.height > 55 ? 55 : fsize.height;
        return fsize.height;
    }
    else
    {
        return 0;
    }
}

+ (int)caluLabelWidth:(NSString *)str contentHeight:(CGFloat)height fontSize:(int)size
{
    if (![str isKindOfClass:[NSNull class]] && [str length] > 0)
    {
        // 用何種字體進行顯示
        UIFont *font = [UIFont systemFontOfSize:size];
        // 計算出顯示完內容需要的最小尺寸
        CGSize fsize = [str sizeWithFont:font constrainedToSize:CGSizeMake(1000, height) lineBreakMode:NSLineBreakByWordWrapping];
        // 這裏返回需要的高度
        return fsize.width;
    }
    else
    {
        return 0;
    }
}
+ (NSString *)stringWithSize:(float)fileSize
{
    NSString *sizeStr;
    if(fileSize/1024.0/1024.0/1024.0 > 1)
    {
        sizeStr = [NSString stringWithFormat:@"%0.1fGB",fileSize/1024.0/1024.0/1024.0];
    }
    else if(fileSize/1024.0/1024.0 > 1 && fileSize/1024.0/1024.0 < 1024 )
    {
        sizeStr = [NSString stringWithFormat:@"%0.1fMB",fileSize/1024.0/1024.0];
    }
    else
    {
        sizeStr = [NSString stringWithFormat:@"%0.1fKB",fileSize/1024.0];
    }
    
    
    return sizeStr;
    
}
+ (BOOL)isNumber:(NSString *)string
{
    //    NSString * regex    = @"^\d+$";
    //    NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    //    BOOL isMatch        = [pred evaluateWithObject:string];
    //    return isMatch;
    unichar c;
    for (int i=0; i<string.length; i++) {
        c=[string characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}

+ (NSString *)validateString:(NSString *)candidate
{
    if ([candidate isKindOfClass:[NSNull class]] || [candidate isEqualToString:@"<null>"])
    {
        return nil;
    }
    else
    {
        return candidate;
    }
}

+ (NSString *)coverTelNumber:(NSString *)numberStr
{
    if (![numberStr isEqualToString:@""] && [NSString JudgmentMobilePhoneNumber:numberStr])
    {
        NSString *yanMa = [NSString stringWithFormat:@"%@****%@",[numberStr substringToIndex:3],[numberStr substringFromIndex:7]];
        return yanMa;
    }
    else
    {
        return numberStr;
    }
}

+ (NSString*)encodeBase64:(NSString*)input
{
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    //转换到base64
    data = [GTBase64 encodeData:data];
    NSString * base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString*)decodeBase64:(NSString*)input
{
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    //转换到base64
    data = [GTBase64 decodeData:data];
    NSString * base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+(NSString *)decodeDES:(NSString*)string
{
//	int hex_len = [string length] / 2;
//	unsigned char* hex_str = malloc(hex_len + 1);
//    memset(hex_str, 0, hex_len+1);
//	int i = 0;
//	for(i = 0;i < hex_len;i++)
//	{
//		hex_str[i] = ascii2hex([string UTF8String] + i * 2);
//	}
//	unsigned char* decrypt_str = malloc(hex_len + 1);
//    memset(decrypt_str, 0, hex_len+1);
//	des_context ctx;
//	des_set_key(&ctx,[kDesKey UTF8String]);
//	//copy iv
//	unsigned char* des_iv = malloc(8 + 1);
//    memset(des_iv, 0, 8 + 1);
//    memcpy(des_iv,[kDesKey UTF8String] , 8);
//	des_cbc_decrypt(&ctx,des_iv,hex_str,decrypt_str,hex_len);
//    free(hex_str);
//    free(des_iv);
//    if (strlen(decrypt_str)>=11) {
//        unsigned char* outStr = malloc(11 + 1);
//        memset(outStr, 0, 11 + 1);
//        memcpy(outStr,decrypt_str , 11);
//        NSString *result=[[[NSString alloc] initWithUTF8String:outStr]autorelease];
//        free(decrypt_str);
//        free(outStr);
//        if (result) {
//            return result;
//        }
//        else
//            return @"0";
//    }
//    else
//    {
//        return @"0";
//    }
    NSLog(@"%@",string);
    NSString *base64DecodeString = [self decodeBase64:string];
    NSLog(@"%@",base64DecodeString);
    NSData *retStr = [NSData DESDecrypt:[base64DecodeString dataUsingEncoding: NSUTF8StringEncoding] WithKey:kDesKey];
    NSLog(@"%@",[[NSString alloc] initWithData:retStr encoding:NSUTF8StringEncoding]);
    return [[[NSString alloc] initWithData:retStr encoding:NSUTF8StringEncoding]autorelease];
}

+ (NSString *)base64EncodedStringFrom:(NSData *)data
{
    if ([data length] == 0)
        return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

+ (BOOL)JudgmentYFX:(NSString*)input
{
    if ([input length]==15) {
        NSString *a = [input substringFromIndex:4];
        NSString *b = [input substringToIndex:4];
        if ([b isEqualToString:@"yfx-"] && [a length]==11) {
            return YES;
        }
    }
    return NO;
}

@end



@implementation NSData (FVUtility)

+ (NSData *)dataWithBase64EncodedString:(NSString *)string
{
    if (string == nil)
        [NSException raise:NSInvalidArgumentException format:nil];
    if ([string length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}

+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}

@end


@implementation UIColor (FVUtility)
+ (UIColor *) colorFromHexRGB:(NSString *) inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}

+ (UIColor *)colorWithR:(float)r G:(float)g B:(float)b A:(float)a
{
    return  [UIColor colorWithRed:r/256.f green:g/256.f blue:b/256.f alpha:a];
}

+ (UIColor *)colorWithString:(NSString *)string
{
    NSString *cString = [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}


@end

@implementation NSString (FVUtilityPath)
-(BOOL)addSkipBackupAttributeToItem
{
//    if([[NSFileManager defaultManager] fileExistsAtPath:self]==NO)
//    {
//        FVLog(@"Failed to addSkipBackupAttributeToItemAtPath, path is not exist");
//        return NO;
//    }
//    
//    NSString *currentVersion=[[UIDevice currentDevice] systemVersion];
//    
//    //5.1 or later
//    if ([currentVersion compare:@"5.1" options:NSNumericSearch] != NSOrderedAscending)
//    {
//        FVLog(@"Current OS Version:%@, 5.1 later",currentVersion);
//        
//        NSError *error = nil;
//        NSURL *url=[NSURL fileURLWithPath:self];
//        BOOL success=[url setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:NULL];
//        
//        if(!success)
//            FVLog(@"Error excluding %@ from backup %@", [url lastPathComponent], error);
//        
//        return success;
//    }
//    else if([currentVersion compare:@"5.0.1" options:NSNumericSearch] !=NSOrderedAscending)
//    {
//        FVLog(@"Current OS Version:%@, 5.0.1 later",currentVersion);
//        
//        const char* filePath = [self fileSystemRepresentation];
//        const char* attrName = "com.apple.MobileBackup";
//        u_int8_t attrValue = 1;
//        int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
//        if(result!=0)
//            FVLog(@"Failed to addSkipBackupAttributeToItemAtPath \"setxattr\"");
//        return result == 0;
//    }
//    FVLog(@"Failed to addSkipBackupAttributeToItemAtPath (Current Version:%@, Before 5.0.1)",currentVersion);
//    return NO;
    return NO;
}

@end


@implementation AlertViewWithData
@synthesize userData=userData_;

-(void)dealloc
{
    [userData_ release];
    [super dealloc];
}

@end


@interface FileManager(Private)
+ (long long) _folderSizeAtPath: (const char*)folderPath;
@end


@implementation FileManager

// 方法1：使用NSFileManager来实现获取文件大小
+ (long long) fileSizeAtPath1:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

// 方法1：使用unix c函数来实现获取文件大小
+ (long long) fileSizeAtPath2:(NSString*) filePath{
    struct stat st;
    if(lstat([filePath cStringUsingEncoding:NSUTF8StringEncoding], &st) == 0){
        return st.st_size;
    }
    return 0;
}
#pragma mark 获取目录大小


// 方法1：循环调用fileSizeAtPath1
+ (long long) folderSizeAtPath1:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        if ([self fileSizeAtPath1:fileAbsolutePath] != [self fileSizeAtPath2:fileAbsolutePath]){
            NSLog(@"%@, %lld, %lld", fileAbsolutePath,
                  [self fileSizeAtPath1:fileAbsolutePath],
                  [self fileSizeAtPath2:fileAbsolutePath]);
        }
        folderSize += [self fileSizeAtPath1:fileAbsolutePath];
    }
    return folderSize;
}


// 方法2：循环调用fileSizeAtPath2
+ (long long) folderSizeAtPath2:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath2:fileAbsolutePath];
    }
    return folderSize;
}

// 方法3：完全使用unix c函数
+ (long long) folderSizeAtPath3:(NSString*) folderPath{
    return [self _folderSizeAtPath:[folderPath cStringUsingEncoding:NSUTF8StringEncoding]];
}

+ (BOOL) removeDirectory:(NSString *)path
{   
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:path error:nil];
}

//private method
+ (long long) _folderSizeAtPath: (const char*)folderPath{
    long long folderSize = 0;
    DIR* dir = opendir(folderPath);
    if (dir == NULL) return 0;
    struct dirent* child;
    while ((child = readdir(dir))!=NULL) {
        if (child->d_type == DT_DIR && (
                                        (child->d_name[0] == '.' && child->d_name[1] == 0) || // 忽略目录 .
                                        (child->d_name[0] == '.' && child->d_name[1] == '.' && child->d_name[2] == 0) // 忽略目录 ..
                                        )) continue;
        
        int folderPathLength = strlen(folderPath);
        char childPath[1024]; // 子文件的路径地址
        stpcpy(childPath, folderPath);
        if (folderPath[folderPathLength-1] != '/'){
            childPath[folderPathLength] = '/';
            folderPathLength++;
        }
        stpcpy(childPath+folderPathLength, child->d_name);
        childPath[folderPathLength + child->d_namlen] = 0;
        if (child->d_type == DT_DIR){ // directory
            folderSize += [self _folderSizeAtPath:childPath]; // 递归调用子目录
            // 把目录本身所占的空间也加上
            struct stat st;
            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
        }else if (child->d_type == DT_REG || child->d_type == DT_LNK){ // file or link
            struct stat st;
            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
        }
    }
    return folderSize;
}

@end

@implementation UIView (FVUtility)

- (void)removeAllSubviews
{
    for (id obj in [self subviews])
    {
        [(UIView *)obj removeFromSuperview];
    }
}

- (UIView *)findFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView findFirstResponder];
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    return nil;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}


@end
