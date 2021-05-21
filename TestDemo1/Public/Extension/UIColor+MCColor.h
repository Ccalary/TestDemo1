//
//  UIColor+MCColor.h
//  Transfer
//
//  Created by caohouhong on 2019/12/9.
//  Copyright © 2019 chh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (MCColor)
/** 主颜色 */
+ (UIColor *)mainColor;

// fff白色
+ (UIColor *)bgWhiteColor;
/** 浅灰 */
+ (UIColor *)colorGrayCCC;
/** 浅主题色 */
+ (UIColor *)fontColorLightMain;
/** 000 黑色 */
+ (UIColor *)fontColorBlack000;
/** 333 黑色 */
+ (UIColor *)fontColorBlack333;
/** 深灰 */
+ (UIColor *)fontColorGray666;
/** 999 浅灰 */
+ (UIColor *)fontColorGray999;
/** 8E **/
+ (UIColor *)fontColorGray8E;
// 浅蓝色
+ (UIColor *)fontColorBlue;
/** FC136E 品红 */
+ (UIColor *)fontColorPink;
/** 385E83 深蓝 */
+ (UIColor *)fontColorDarkBlue;
/** DC7FC 浅蓝 */
+ (UIColor *)fontColorLightBlue;
/** 38BF50 草绿色 */
+ (UIColor *)fontColorGreen;

/** 浅主题色 背景 */
+ (UIColor *)bgColorLightMain;
/** 浅灰 背景色 */
+ (UIColor *)bgColorf2f2f2;
/** 分割线颜色 */
+ (UIColor *)dividerBgColor;
/** 分割线颜色浅灰e8 */
+ (UIColor *)dividerBgGrayE8Color;

+ (UIColor *)colorWithHex:(NSInteger)hex;
+ (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
