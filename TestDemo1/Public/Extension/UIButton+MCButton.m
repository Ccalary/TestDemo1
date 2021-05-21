//
//  UIButton+MCButton.m
//  Transfer
//
//  Created by caohouhong on 2019/12/9.
//  Copyright © 2019 chh. All rights reserved.
//

#import "UIButton+MCButton.h"

@implementation UIButton (MCButton)
+ (UIButton *)createBtnWithTitle:(NSString *)title{
    UIButton *button = [UIButton createBtnWithTitle:title color:[UIColor blackColor] fontSize:15*UIRate imageName:@""];
    return button;
}

+ (UIButton *)createBtnWithTitle:(NSString *)title
                       imageName:(NSString *)name{
    UIButton *button = [UIButton createBtnWithTitle:title color:[UIColor blackColor] fontSize:15*UIRate imageName:name];
    return button;
}

+ (UIButton *)createBtnWithTitle:(NSString *)title
                           color:(UIColor *)color
                        fontSize:(CGFloat)size{
    UIButton *button = [UIButton createBtnWithTitle:title color:color fontSize:size imageName:@""];
    return button;
}

+ (UIButton *)createBtnWithTitle:(NSString *)title
                        fontSize:(CGFloat)size
                       imageName:(NSString *)name{
    UIButton *button = [UIButton createBtnWithTitle:title color:[UIColor blackColor] fontSize:size imageName:name];
    return button;
}


+ (UIButton *)createBtnWithTitle:(NSString *)title
                           color:(UIColor *)color
                        fontSize:(CGFloat)size
                       imageName:(NSString *)name{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:size];
    [button setTitleColor:color forState:UIControlStateNormal];
    if (name.length > 0){
        [button setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    }
    return button;
}
@end
