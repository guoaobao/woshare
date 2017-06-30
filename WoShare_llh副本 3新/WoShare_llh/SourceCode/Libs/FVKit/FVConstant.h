//
//  FVConstant.h
//  FVKit
//
//  Created by 胡 波 on 13-3-27.
//
//

#ifndef FVKit_FVConstant_h
#define FVKit_FVConstant_h

#ifndef __OPTIMIZE__
#define FVLog(...) NSLog(__VA_ARGS__)
#else
#define FVLog(...)
#endif



#define FVIsRetina() ([[UIScreen mainScreen] scale]>1.0)
#define FVIsPad() (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define FVIF_IS_IPAD_ELSE(X,Y) (FVIsPad()?(X):(Y))
#define FVIsIPhone5() ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define FVIF_IS_P5_ELSE(X,Y) (FVIsIPhone5()?(X):(Y))
#define FVIsIOS7() ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define FVIF_IS_IOS7_ELSE(X,Y) (FVIsIOS7()?(X):(Y))
#define FVBundleVersion() ([[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey])
#define FVBundleShortVersionString  ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"])
#define FVIsPortrait() (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation]))
#define kRequestTimeOutInterval  (5.0)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define ISOS7() ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0)
#endif
