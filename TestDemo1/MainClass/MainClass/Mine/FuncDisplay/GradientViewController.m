//
//  GradientViewController.m
//  TestDemo1
//
//  Created by caohouhong on 17/5/27.
//  Copyright © 2017年 caohouhong. All rights reserved.
//  渐变色

#import "GradientViewController.h"

@interface GradientViewController ()

@end

@implementation GradientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initView{
    
//    CAGradientLayer *colorLayer = [CAGradientLayer layer];
//    colorLayer.frame    = (CGRect){CGPointZero, CGSizeMake(200, 200)};
//    colorLayer.position = self.view.center;
//    [self.view.layer addSublayer:colorLayer];
//    
//    // 颜色分配
//    colorLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
//                          (__bridge id)[UIColor greenColor].CGColor,
//                          (__bridge id)[UIColor blueColor].CGColor];
//    
//    // 颜色分割线
//    colorLayer.locations  = @[@(0.25), @(0.5), @(0.75)];
//    
//    // 起始点
//    colorLayer.startPoint = CGPointMake(0, 0);
//    
//    // 结束点
//    colorLayer.endPoint   = CGPointMake(1, 0);
    
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.frame = self.view.frame;
    [self.view.layer addSublayer:gradientLayer];
    
    
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                             (__bridge id)[UIColor blueColor].CGColor,
                             (__bridge id)[UIColor clearColor].CGColor
                             ];
    
    //默认为垂直排列，设置以后根据设置的方向排列
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    
    //(__bridge id)[UIColor yellowColor].CGColor,
    //(__bridge id)[UIColor greenColor].CGColor,
    //(__bridge id)[UIColor blueColor].CGColor
}

@end
