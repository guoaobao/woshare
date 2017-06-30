//
//  NSString+CaculateSize.m
//  CST
//
//  Created by 陆利刚 on 15/10/27.
//  Copyright © 2015年 陆利杭. All rights reserved.
//

#import "NSString+CaculateSize.h"

@implementation NSString (CaculateSize)

- (CGSize)caculateSizeByFont:(UIFont *)font
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = font;
    CGSize size = [self sizeWithAttributes:dict];
    return size;
}

- (CGRect)caculateRectByFont:(UIFont *)font ByConstrainedSize:(CGSize)constrain
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = font;
    CGRect rect = [self boundingRectWithSize:constrain options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];//计算文本大小
    return rect;
}

@end
