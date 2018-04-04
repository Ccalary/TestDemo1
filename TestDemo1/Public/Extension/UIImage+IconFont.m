//
//  UIImage+IconFont.m
//  TestDemo1
//
//  Created by chh on 2018/4/4.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "UIImage+IconFont.h"

@implementation UIImage (IconFont)
+ (UIImage*)imageWithIcon:(NSString*)iconCode size:(NSUInteger)size color:(UIColor*)color {
    CGSize imageSize = CGSizeMake(size, size);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [[UIScreen mainScreen] scale]);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size, size)];
    label.font = [UIFont fontWithName:@"iconfont" size:size];
    label.text = iconCode;
    if(color){
        label.textColor = color;
    }
    [label.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    return retImage;
}
@end
