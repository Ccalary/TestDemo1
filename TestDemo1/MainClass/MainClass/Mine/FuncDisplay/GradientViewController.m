//
//  GradientViewController.m
//  TestDemo1
//
//  Created by caohouhong on 17/5/27.
//  Copyright © 2017年 caohouhong. All rights reserved.
//  渐变色

#import "GradientViewController.h"

@interface GradientViewController ()
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@end

@implementation GradientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initColorLabel];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initColorLabel{
    
    // 创建UILabel
    UILabel *label = [[UILabel alloc] init];
    
    label.text = @"这是一个不太完美的渐变色Label";
    
    [label sizeToFit];
    
    label.center = CGPointMake(200, 100);
    
    // 疑问：label只是用来做文字裁剪，能否不添加到view上。
    // 必须要把Label添加到view上，如果不添加到view上，label的图层就不会调用drawRect方法绘制文字，也就没有文字裁剪了。
    // 如何验证，自定义Label,重写drawRect方法，看是否调用,发现不添加上去，就不会调用
    [self.view addSubview:label];
    
    // 创建渐变层
    _gradientLayer = [CAGradientLayer layer];
    
    _gradientLayer.frame = label.frame;
    
    // 设置渐变层的颜色，随机颜色渐变
    _gradientLayer.colors = @[(id)[self randomColor].CGColor, (id)[self randomColor].CGColor,(id)[self randomColor].CGColor];
    
    // 疑问:渐变层能不能加在label上
    // 不能，mask原理：默认会显示mask层底部的内容，如果渐变层放在mask层上，就不会显示了
    
    // 添加渐变层到控制器的view图层上
    [self.view.layer addSublayer:_gradientLayer];
    
    // mask层工作原理:按照透明度裁剪，只保留非透明部分，文字就是非透明的，因此除了文字，其他都被裁剪掉，这样就只会显示文字下面渐变层的内容，相当于留了文字的区域，让渐变层去填充文字的颜色。
    // 设置渐变层的裁剪层
    _gradientLayer.mask = label.layer;
    
    // 注意:一旦把label层设置为mask层，label层就不能显示了,会直接从父层中移除，然后作为渐变层的mask层，且label层的父层会指向渐变层，这样做的目的：以渐变层为坐标系，方便计算裁剪区域，如果以其他层为坐标系，还需要做点的转换，需要把别的坐标系上的点，转换成自己坐标系上点，判断当前点在不在裁剪范围内，比较麻烦。
    
    
    // 父层改了，坐标系也就改了，需要重新设置label的位置，才能正确的设置裁剪区域。
    label.frame = _gradientLayer.bounds;
    
    // 利用定时器，快速的切换渐变颜色，就有文字颜色变化效果
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(textColorChange)];
    link.frameInterval = 2.0;
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    
}

// 随机颜色方法
-(UIColor *)randomColor{
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

// 定时器触发方法
-(void)textColorChange {
    _gradientLayer.colors = @[(id)[self randomColor].CGColor,
                              (id)[self randomColor].CGColor,
                              (id)[self randomColor].CGColor,
                              (id)[self randomColor].CGColor,
                              (id)[self randomColor].CGColor];
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
    gradientLayer.frame = CGRectMake(0, 300, ScreenWidth, 300);
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
