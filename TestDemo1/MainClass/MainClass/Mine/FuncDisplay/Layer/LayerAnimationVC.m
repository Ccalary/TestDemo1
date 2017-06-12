//
//  LayerAnimationVC.m
//  TestDemo1
//
//  Created by caohouhong on 17/6/9.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "LayerAnimationVC.h"


#define kBottomHeight 20
@interface LayerAnimationVC ()
@property (nonatomic, strong)CAShapeLayer *greenTrack;
@end

@implementation LayerAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //渐变的天空
    [self initBackgroundSky];
    //波动的河流
    [self initRiver];
    //雪山
    [self initSnowMountain];
    //草坪
    [self initLawn];
    //鸟
    [self initBird];
    //绿色轨道
    [self initGreenTrack];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initBackgroundSky{
    //天空渐变色
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    //frame留出河的尺寸
    gradientLayer.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - 20);
    [self.view.layer addSublayer:gradientLayer];
    
    UIColor *lightColor = [UIColor colorWithRed:40.0 / 255.0 green:150.0 / 255.0 blue:200.0 / 255.0 alpha:1.0];
    UIColor *darkColor = [UIColor colorWithRed:255.0 / 255.0 green:250.0 / 255.0 blue:250.0 / 255.0 alpha:1.0];
    gradientLayer.colors = @[(__bridge id)lightColor.CGColor,(__bridge id)darkColor.CGColor];
   //45度变色
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 1);
    
}

#pragma mark - TODO 波动的河流
- (void)initRiver{
    CAGradientLayer *layer = [[CAGradientLayer alloc] init];
    layer.frame = CGRectMake(0, ScreenHeight - 20, ScreenWidth, 20);
    //浅到深
    layer.colors = @[(__bridge id)HEXCOLOR(0x66b6da).CGColor,(__bridge id)HEXCOLOR(0x10386a).CGColor];
    [self.view.layer addSublayer:layer];
}

#pragma mark - 草坪
- (void)initLawn{
    //CAShapeLayer添加path
    CAShapeLayer *leftLayer = [[CAShapeLayer alloc] init];
    
    UIBezierPath *leftPath = [UIBezierPath bezierPath];
    CGPoint startPoint = CGPointMake(0, ScreenHeight - kBottomHeight);
    
    [leftPath moveToPoint:startPoint];
    [leftPath addQuadCurveToPoint:CGPointMake(ScreenWidth, ScreenHeight -  80) controlPoint:CGPointMake(ScreenWidth/1.5, ScreenHeight - 80)];
    [leftPath addLineToPoint:CGPointMake(ScreenWidth, ScreenHeight - kBottomHeight)];
    
    [leftPath moveToPoint:startPoint];
    [leftPath addLineToPoint:CGPointMake(0, ScreenHeight - 80)];
    [leftPath addQuadCurveToPoint:CGPointMake(ScreenWidth/3.0, ScreenHeight - 40) controlPoint:CGPointMake(ScreenWidth/5.0, ScreenHeight - 80)];
   
    //设置路线
    leftLayer.path = leftPath.CGPath;
    //填充颜色
    leftLayer.fillColor = [UIColor colorWithDisplayP3Red:82.0 / 255.0 green:177.0 / 255.0 blue:52.0 / 255.0 alpha:1.0].CGColor;
    [self.view.layer addSublayer:leftLayer];
}

#pragma mark - 雪山
- (void)initSnowMountain{
    //白色
    CAShapeLayer *leftSharpLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *leftPath = [UIBezierPath bezierPath];
    //雪山1 起点、顶点、终点
    CGPoint startPoint1 = CGPointMake(0, ScreenHeight - 80);
    CGPoint topPoint1 = CGPointMake(ScreenWidth/5.0, ScreenHeight - 180);
    CGPoint endPoint1 = CGPointMake(ScreenWidth/5.0*2.5, ScreenHeight - kBottomHeight);
    
    [leftPath moveToPoint:startPoint1];
    [leftPath addLineToPoint:topPoint1];
    [leftPath addLineToPoint:endPoint1];
    [leftPath closePath];
    
    //雪山2 起点、顶点、终点
    CGPoint startPoint2 = CGPointMake(ScreenWidth/5.0, ScreenHeight - kBottomHeight);
    CGPoint topPoint2 = CGPointMake(ScreenWidth/5.0*3.5, ScreenHeight - 140);
    CGPoint endPoint2 = CGPointMake(ScreenWidth, ScreenHeight - kBottomHeight);
    
    [leftPath moveToPoint:startPoint2];
    [leftPath addLineToPoint:topPoint2];
    [leftPath addLineToPoint:endPoint2];
    [leftPath closePath];
    
    leftSharpLayer.path = leftPath.CGPath;
    leftSharpLayer.fillColor = [UIColor whiteColor].CGColor;
    [self.view.layer addSublayer:leftSharpLayer];
    
    //底部灰色
    CAShapeLayer *bottomLayer = [CAShapeLayer layer];
    UIBezierPath *bottomPath = [UIBezierPath bezierPath];
    
    //雪山1底部
    [bottomPath moveToPoint:startPoint1];
    CGPoint firstPathPoint = [self calculateWithXValue:20 startPoint:startPoint1 endpoint:topPoint1];
    CGPoint secondPathPoint = [self calculateWithXValue:ScreenWidth/5.0*2 startPoint:topPoint1 endpoint:endPoint1];
    [bottomPath addLineToPoint:firstPathPoint];
    [bottomPath addQuadCurveToPoint:CGPointMake(ScreenWidth/5.0 - 10 , firstPathPoint.y + 10) controlPoint:CGPointMake(ScreenWidth/5.0/2.0, firstPathPoint.y + 30)];
    [bottomPath addLineToPoint:CGPointMake(ScreenWidth/5.0 - 10 + 30, firstPathPoint.y - 10)];
    [bottomPath addLineToPoint:CGPointMake(ScreenWidth/5.0 - 10 + 50, firstPathPoint.y + 5)];
    [bottomPath addLineToPoint:secondPathPoint];
    [bottomPath addLineToPoint:endPoint1];
    [bottomPath closePath];
    
    //雪山2底部
    [bottomPath moveToPoint:startPoint2];
    CGPoint firstPathPoint2 = [self calculateWithXValue:ScreenWidth/5.0*2.5 startPoint:startPoint2 endpoint:topPoint2];
    CGPoint secondPathPoint2 = [self calculateWithXValue:ScreenWidth/5.0*4 startPoint:topPoint2 endpoint:endPoint2];
    [bottomPath addLineToPoint:firstPathPoint2];
    [bottomPath addLineToPoint:secondPathPoint2];
    [bottomPath addLineToPoint:endPoint2];
    [bottomPath closePath];
    
    bottomLayer.path = bottomPath.CGPath;
    bottomLayer.fillColor = [UIColor colorWithDisplayP3Red:139.0 /255.0 green:92.0 /255.0 blue:0.0 /255.0 alpha:1.0].CGColor;
    [self.view.layer addSublayer:bottomLayer];
    
}
#pragma mark - 飞翔的鸟
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

#pragma mark - 绿色轨道
- (void)initGreenTrack{
    _greenTrack = [CAShapeLayer layer];
    _greenTrack.lineWidth = 5.0;
    _greenTrack.strokeColor = [UIColor colorWithDisplayP3Red:0.0 / 255.0 green:147.0 / 255.0 blue:163.0 /255.0  alpha:1.0].CGColor;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(ScreenWidth + 10, ScreenHeight - 20)];
    [path addLineToPoint:CGPointMake(ScreenWidth + 10, ScreenHeight - 60)];
    [path addQuadCurveToPoint:CGPointMake(ScreenWidth/1.5, ScreenHeight - 60) controlPoint:CGPointMake(ScreenWidth*5/7.0 ,  ScreenHeight - 260)];
    //画圆
    [path addArcWithCenter:CGPointMake(ScreenWidth/1.6, ScreenHeight - 130) radius:65 startAngle:M_PI/2.0 endAngle:5*M_PI/2.0 clockwise:YES];
    
    [path addCurveToPoint:CGPointMake(0, ScreenHeight - 40) controlPoint1:CGPointMake(ScreenWidth/1.8, ScreenHeight - 40) controlPoint2:CGPointMake(ScreenWidth/5, ScreenHeight/1.6)];
    [path addLineToPoint:CGPointMake(-20, ScreenHeight - 20)];
    
    _greenTrack.path = path.CGPath;
    //填充图片为背景颜色
    _greenTrack.fillColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"square_green"]].CGColor;
    [self.view.layer addSublayer:_greenTrack];

    //制作镂空的虚线
    CAShapeLayer *trackLine = [CAShapeLayer layer];
    trackLine.lineCap = kCALineCapRound;
    trackLine.strokeColor = [UIColor whiteColor].CGColor;
    //线条宽度和空白宽度
    trackLine.lineDashPattern = @[@1.0,@6.0];
    trackLine.lineWidth = 2.5;
    trackLine.fillColor = [UIColor clearColor].CGColor;
    trackLine.path = path.CGPath;
    [_greenTrack addSublayer:trackLine];
    
    [self carAnimation];
}

- (void)carAnimation{
    CALayer *carLayer = [[CALayer alloc] init];
    carLayer.frame = CGRectMake(0, 0, 17, 11);
    //添加内容
    carLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"car"].CGImage);
    
    [_greenTrack addSublayer:carLayer];
    
    CAKeyframeAnimation *ani = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    ani.path = _greenTrack.path;
    ani.duration = 20;
    //重复次数（一直）
    ani.repeatCount = CGFLOAT_MAX;
    ani.autoreverses = NO;
    
    ani.calculationMode = kCAAnimationPaced;
    ani.rotationMode = kCAAnimationRotateAuto;
    
    [carLayer addAnimation:ani forKey:@"carAni"];
}

//根据起始点，算出指定的x在这条线段上对应的y。返回这个point。知道两点，根据两点坐标，求出两点连线的斜率。y=kx+b求出点坐标。
- (CGPoint)calculateWithXValue:(CGFloat)xvalue startPoint:(CGPoint)startPoint endpoint:(CGPoint)endpoint{
    //    求出两点连线的斜率
    CGFloat k = (endpoint.y - startPoint.y) / (endpoint.x - startPoint.x);
    CGFloat b = startPoint.y - startPoint.x * k;
    CGFloat yvalue = k * xvalue + b;
    return CGPointMake(xvalue, yvalue);
}

@end
