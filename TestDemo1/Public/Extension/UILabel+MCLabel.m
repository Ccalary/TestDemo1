//
//  UILabel+MCLabel.m
//  Transfer
//
//  Created by caohouhong on 2019/12/9.
//  Copyright © 2019 chh. All rights reserved.
//

#import "UILabel+MCLabel.h"
#import <CoreText/CoreText.h>

@implementation UILabel (MCLabel)
+ (UILabel *)createNormalLabelWithTitle:(NSString *)title{
    UILabel *label = [UILabel createLabelWithTitle:title textColor:[UIColor blackColor] fontsize:15*UIRate];
    return label;
}

+ (UILabel *)createLabelWithTitle:(NSString *)title textColor:(UIColor*)color{
    UILabel *label = [UILabel createLabelWithTitle:title textColor:color fontsize:15*UIRate];
    return label;
}

+ (UILabel *)createLabelWithTitle:(NSString *)title fontSize:(CGFloat)size{
    UILabel *label = [UILabel createLabelWithTitle:title textColor:[UIColor blackColor] fontsize:size ];
    return label;
}

+ (UILabel *)createLabelWithTitle:(NSString *)title
                        textColor:(UIColor*)color
                         fontsize:(CGFloat)size{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:size];
    label.textColor = color;
    label.text = title;
    return label;
}

+ (UILabel *)createLabelWithCenterTitle:(NSString *)title
                              textColor:(UIColor*)color
                               fontsize:(CGFloat)size{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:size];
    label.textColor = color;
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}
@end
