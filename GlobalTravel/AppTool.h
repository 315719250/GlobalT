//
//  AppTool.h
//  UI_11_CustomCell_autoHeight
//
//  Created by lanou on 16/9/1.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AppTool : NSObject
+(CGFloat)heightWithImage:(UIImage *)image width:(CGFloat)width;
+(CGFloat)heightWithString:(NSString *)str width:(CGFloat)width font:(UIFont *)font;
@end
