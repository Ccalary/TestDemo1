//
//  HomeViewController.m
//  TestDemo1
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "HomeViewController.h"
#import "FirstViewController.h"
#import "HHPopButton.h"
#import "UIView+MCTransition.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initView];
}


- (void)initView{
    UIView *holdView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    holdView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:holdView];
    
    HHPopButton *nextMonthBtn = [[HHPopButton alloc] initWithFrame:CGRectMake(50, 150, 100, 50)];
    [nextMonthBtn setTitle:@"按钮" forState:UIControlStateNormal];
    [nextMonthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    nextMonthBtn.colicActionBlock = ^(){
        [self nextMonthBtnAction];
    };
    nextMonthBtn.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:nextMonthBtn];
    
    for (int i = 0; i < 3; i++){
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 300+i*40, 250, 25)];
        imageView.layer.borderWidth = 1;
        imageView.layer.borderColor = [UIColor blackColor].CGColor;
        [self.view addSubview:imageView];
        UIImage *image = [UIImage imageNamed:@"line_25x250"];
        imageView.image = [self image:image rotatedByDegrees:45*i];
    }

}
- (void)nextMonthBtnAction{
    FirstViewController *viewVC = [[FirstViewController alloc] init];
    [self.navigationController pushViewController:viewVC animated:YES];
}

- (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = - M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

/** 将图片旋转弧度radians */
- (UIImage *)image:(UIImage *)image rotatedByRadians:(CGFloat)radians
{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,image.size.width, image.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(radians);
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, radians);
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-image.size.width / 2, -image.size.height / 2, image.size.width, image.size.height), [image CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

/** 将图片旋转角度degrees */
- (UIImage *)image:(UIImage *)image rotatedByDegrees:(CGFloat)degrees
{
    return [self image:image rotatedByRadians:(M_PI * (degrees) / 180.0)];
}

@end
