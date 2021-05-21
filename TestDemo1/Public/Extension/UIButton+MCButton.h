//
//  UIButton+MCButton.h
//  Transfer
//
//  Created by caohouhong on 2019/12/9.
//  Copyright © 2019 chh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (MCButton)
/**
 创建button，默认 15号，黑色，无图,title
 
 @param title 标题
 @return button
 */
+ (UIButton *)createBtnWithTitle:(NSString *)title;
/**
 创建button，默认 15号，黑色,title-name
 
 @param title 标题
 @param name 图片名称
 @return button
 */
+ (UIButton *)createBtnWithTitle:(NSString *)title
                       imageName:(NSString *)name;

/**
 创建button,title-color-size
 
 @param title 标题
 @param color 颜色
 @param size 大小
 @return button
 */
+ (UIButton *)createBtnWithTitle:(NSString *)title
                           color:(UIColor *)color
                        fontSize:(CGFloat)size;
/**
 创建button,title-size-name
 
 @param title 标题
 @param size 大小
 @param name 图片
 @return button
 */
+ (UIButton *)createBtnWithTitle:(NSString *)title
                        fontSize:(CGFloat)size
                       imageName:(NSString *)name;
/**
 创建button,title-color-size-name
 
 @param title 标题
 @param color 颜色
 @param size 大小
 @param name 图片
 @return button
 */
+ (UIButton *)createBtnWithTitle:(NSString *)title
                           color:(UIColor *)color
                        fontSize:(CGFloat)size
                       imageName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
