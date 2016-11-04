//
//  AppTool.m
//  UI_11_CustomCell_autoHeight
//
//  Created by lanou on 16/9/1.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "AppTool.h"

@implementation AppTool
+(CGFloat)heightWithImage:(UIImage *)image width:(CGFloat)width
{
    CGFloat sh = 0;
    CGFloat ow,oh;
    ow=image.size.width;
    oh=image.size.height;
    
    sh=width *oh/ow;
    
    return sh;
}
+(CGFloat)heightWithString:(NSString *)str width:(CGFloat)width font:(UIFont *)font
{
    CGFloat sh =0;
    /**
     *  获取指定情况下文本所占的大小
     *
     *  @param CGSize 指定大小
                      以小的值为标准，求最大值对应的值
     *  @param options 计算文本宽高的标准
     *  @param attributes 字体的属性
     *  @param context 保留属性 ，nil
     *
     *  @return 返回计算后的rect
     */
    CGRect rect = [str boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    sh=rect.size.height;
    
    return sh;
}








@end
