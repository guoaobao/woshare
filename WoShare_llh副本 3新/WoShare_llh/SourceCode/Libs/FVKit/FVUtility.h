//
//  FVUtility.h
//  FVKit
//
//  Created by 胡 波 on 13-3-27.
//
//

#import <QuartzCore/QuartzCore.h>

@interface UIImage (FVUtility)
+(UIImage*)imageNamedWithoutCache:(NSString *)fileName;
+(UIImage*)imageFromView:(UIView*)theView;
+(UIImage*)imageFromURLString:(NSString*)urlstring;//从url获取图片

-(UIImage*)scaleToSize:(CGSize)newSize;//缩放图片
-(UIImage*)screenshot;
-(UIImage*)getImageFromURL:(NSString*)fileURL;
-(UIImage*)fixOrientation;
+(UIImage*)rotateImage:(UIImage *)aImage;
@end

@interface NSString (FVUtility)
+(NSString*)stringWithTime:(NSTimeInterval)time showHour:(BOOL)showHour;
+(NSString*)stringWithTime:(NSTimeInterval)time;
+(NSString*)stringWithTime:(NSTimeInterval)time showZeroHour:(BOOL)hour;
+(NSString*)stringwithMd5Encode:(NSString*)str;
+(NSString *)createPostURL:(NSDictionary *)params;
-(NSString*)stringWithUrlEncode;
-(NSString*)stringWithUrlDecode;
-(NSString*)stringWithNumberOnly;
-(NSString*)stringFormDict:(NSDictionary*)dict;
+(BOOL)isValidateEmail:(NSString *)email;
+(BOOL)JudgmentMobilePhoneNumber:(NSString *)number;
+(NSString *)stringWithDate:(NSDate *)date formater:(NSString *)formater;
+(NSString *)decodeDES:(NSString*)string;

+(NSString *)deletePhoneNumber:(NSString*)string;

+(int)caluNumberOfString:(NSString *)str;
+ (int)caluLabelHeight:(NSString *)str contentWidth:(CGFloat)width fontsize:(int)size;
+ (int)caluLabelWidth:(NSString *)str contentHeight:(CGFloat)height fontSize:(int)size;
+ (NSString *)stringWithSize:(float)fileSize;
+ (BOOL)isNumber:(NSString *)string;
+ (NSString *)validateString:(NSString *)candidate;
+ (NSString *)coverTelNumber:(NSString *)numberStr;

//+ (NSString *)base64StringFromText:(NSString *)text;
//+ (NSString *)textFromBase64String:(NSString *)base64;

+ (NSString*)encodeBase64:(NSString*)input;
+ (NSString*)decodeBase64:(NSString*)input;

+ (BOOL)JudgmentYFX:(NSString*)input;
@end

@interface UIColor (FVUtility)
+(UIColor*)colorFromHexRGB:(NSString *) inColorString;
+ (UIColor *)colorWithR:(float)r G:(float)g B:(float)b A:(float)a;
+(UIColor *)colorWithString:(NSString *)string;
@end

@interface NSData (FVUtility)
+ (NSData *)DESDecrypt:(NSData *)data WithKey:(NSString *)key;
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;
@end

@interface NSString (FVUtilityPath)

-(BOOL)addSkipBackupAttributeToItem;

@end


@interface AlertViewWithData : UIAlertView
{
    id      userData_;
}
@property (nonatomic, retain) id    userData;

@end

@interface FileManager : NSObject
// 方法1：使用NSFileManager来实现获取文件大小
+ (long long) fileSizeAtPath1:(NSString*) filePath;
// 方法1：使用unix c函数来实现获取文件大小
+ (long long) fileSizeAtPath2:(NSString*) filePath;


// 方法1：循环调用fileSizeAtPath1
+ (long long) folderSizeAtPath1:(NSString*) folderPath;
// 方法2：循环调用fileSizeAtPath2
+ (long long) folderSizeAtPath2:(NSString*) folderPath;
// 方法2：在folderSizeAtPath2基础之上，去除文件路径相关的字符串拼接工作
+ (long long) folderSizeAtPath3:(NSString*) folderPath;

+ (BOOL)removeDirectory:(NSString*)path;

@end

@interface UIView (FVUtility)
- (void)removeAllSubviews;
- (CGFloat)left;
- (CGFloat)top;
- (CGFloat)right;
- (CGFloat)bottom;
- (CGFloat)width;
- (CGFloat)height;
- (UIView *)findFirstResponder;
@end


