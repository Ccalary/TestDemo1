//
//  UIColor+MCColor.m
//  Transfer
//
//  Created by caohouhong on 2019/12/9.
//  Copyright © 2019 chh. All rights reserved.
//

#import "UIColor+MCColor.h"

@implementation UIColor (MCColor)
//MARK:- Theme 主颜色
+ (UIColor *)mainColor{
    return [UIColor colorWithHex:0x3A9CFF];
}

// fff白色
+ (UIColor *)bgWhiteColor {
    return [UIColor colorWithHex:0xFFFFFF];
}

// ccc 浅灰
+ (UIColor *)colorGrayCCC{
    return [UIColor colorWithHex:0xcccccc];
}

#pragma mark - 字体颜色
// 浅主题色
+ (UIColor *)fontColorLightMain{
    return [UIColor colorWithHex:0xFD7155];
}
// 000 黑色
+ (UIColor *)fontColorBlack000{
    return [UIColor colorWithHex:0x000000];
}
// 333 黑色
+ (UIColor *)fontColorBlack333{
    return [UIColor colorWithHex:0x333333];
}
// 666 深灰
+ (UIColor *)fontColorGray666{
    return [UIColor colorWithHex:0x666666];
}
// 999 浅灰
+ (UIColor *)fontColorGray999{
    return [UIColor colorWithHex:0x999999];
}
// 8E 浅灰
+ (UIColor *)fontColorGray8E{
    return [UIColor colorWithHex:0x8E8E8E];
}
// 浅蓝色
+ (UIColor *)fontColorBlue {
    return [UIColor colorWithHex:0x2682BB];
}
// FC136E 品红
+ (UIColor *)fontColorPink{
    return [UIColor colorWithHex:0xFC136E];
}

// 385E83 深蓝
+ (UIColor *)fontColorDarkBlue{
    return [UIColor colorWithHex:0x385E83];
}

// DC7FC 浅蓝
+ (UIColor *)fontColorLightBlue{
    return [UIColor colorWithHex:0x8DC7FC];
}

// 38BF50 草绿色
+ (UIColor *)fontColorGreen{
    return [UIColor colorWithHex:0x38BF50];
}

#pragma mark - 背景色
// 浅主题色 背景
+ (UIColor *)bgColorLightMain{
    return [UIColor colorWithHex:0xFFDDD6];
}

// 浅灰 背景色
+ (UIColor *)bgColorf2f2f2{
    return [UIColor colorWithHex:0xf2f2f2];
}

//分割线颜色
+ (UIColor *)dividerBgColor {
    return [UIColor colorWithHex:0xc2c2c2];
}

//分割线颜色浅灰e8
+ (UIColor *)dividerBgGrayE8Color {
    return [UIColor colorWithHex:0xe8e8e8];
}

//MARK:- Method
+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0 alpha:alpha];
}

+ (UIColor *)colorWithHex:(NSInteger)hex
{
    return [UIColor colorWithHex:hex alpha:1.0];
}
@end
