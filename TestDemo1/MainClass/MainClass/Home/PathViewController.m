//
//  PathViewController.m
//  TestDemo1
//
//  Created by caohouhong on 2022/3/18.
//  Copyright © 2022 caohouhong. All rights reserved.
//

#import "PathViewController.h"

@interface PathViewController ()

@end

@implementation PathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    self.navigationItem.title = @"路径动画";
    self.view.backgroundColor = [UIColor bgColorf2f2f2];
    
    [self initBird];
    
}

- (void)initBird{
    CAShapeLayer *birdLayer = [CAShapeLayer layer];
    UIBezierPath *birdPath = [UIBezierPath bezierPath];
    [birdPath moveToPoint:CGPointMake(0, 20)];
    [birdPath addLineToPoint:CGPointMake(15, 5)];
    [birdPath addLineToPoint:CGPointMake(40, 30)];
    [birdPath addLineToPoint:CGPointMake(40, 10)];
    [birdPath addLineToPoint:CGPointMake(15, 35)];
    [birdPath closePath];
    birdLayer.path = birdPath.CGPath;
    birdLayer.fillColor = [UIColor yellowColor].CGColor;
    [self.view.layer addSublayer:birdLayer];
    
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:CGPointMake(ScreenWidth, 50)];
    [movePath addCurveToPoint:CGPointMake(-40, 50) controlPoint1:CGPointMake(ScreenWidth-100, 0) controlPoint2:CGPointMake(ScreenWidth/4.0, 200)];

    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.path = movePath.CGPath;
    lineLayer.strokeColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:lineLayer];
    
    //位移动画
    CAKeyframeAnimation *ani = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //移动路径
    ani.path = movePath.CGPath;
    ani.duration = 10;
    ani.autoreverses = NO;
    ani.repeatCount = CGFLOAT_MAX;
    ani.calculationMode = kCAAnimationPaced;
    
    [birdLayer addAnimation:ani forKey:@"position"];
    
}
@end
