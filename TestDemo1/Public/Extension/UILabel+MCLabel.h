//
//  UILabel+MCLabel.h
//  Transfer
//
//  Created by caohouhong on 2019/12/9.
//  Copyright © 2019 chh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (MCLabel)
/**
 创建常规的label，黑色，15号，居左
 @param title 内容
 @return label
 */
+ (UILabel *)createNormalLabelWithTitle:(NSString *)title;
/**
 创建label，15号，居左
 @param title 内容
 @param color 颜色
 @return label
 */
+ (UILabel *)createLabelWithTitle:(NSString *)title textColor:(UIColor*)color;
/**
 创建label，黑色，居左
 @param title 内容
 @param size 大小
 @return label
 */
+ (UILabel *)createLabelWithTitle:(NSString *)title fontSize:(CGFloat)size;
/**
 自定义label，内容，颜色，大小
 @param title 内容
 @param color 颜色
 @param size 大小
 @return label
 */
+ (UILabel *)createLabelWithTitle:(NSString *)title
                        textColor:(UIColor*)color
                         fontsize:(CGFloat)size;
/**
 自定义label，内容，颜色，大小，居中
 @param title 内容
 @param color 颜色
 @param size 大小
 @return label
 */
+ (UILabel *)createLabelWithCenterTitle:(NSString *)title
                              textColor:(UIColor*)color
                               fontsize:(CGFloat)size;
@end

NS_ASSUME_NONNULL_END
