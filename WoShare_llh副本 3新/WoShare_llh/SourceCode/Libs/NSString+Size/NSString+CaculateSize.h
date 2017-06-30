//
//  NSString+CaculateSize.h
//  CST
//
//  Created by 陆利刚 on 15/10/27.
//  Copyright © 2015年 陆利杭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CaculateSize)

/** 计算文字的Size */
- (CGSize)caculateSizeByFont:(UIFont *)font;

/** 根据约束计算文字的Rect，如多行显示时的Rect */
- (CGRect)caculateRectByFont:(UIFont *)font ByConstrainedSize:(CGSize)constrain;


@end
