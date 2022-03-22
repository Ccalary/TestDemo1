//
//  HomeViewController.m
//  TestDemo1
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "HomeViewController.h"
#import "HHPopButton.h"
#import "PathViewController.h"
#import "OCPathAnimationView.h"
#import "TestDemo1-Swift.h"
@interface HomeViewController ()
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    OCPathAnimationView *animationView = [[OCPathAnimationView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 300)];
    [self.view addSubview:animationView];
    
//    {
//        CGPoint firstPoint = CGPointMake(50, 50);
//        CGPoint secontPoint = CGPointMake(100, 50);
//        CGPoint thirdPoint = CGPointMake(100, 150);
//        CGPoint fourPoint = CGPointMake(150, 150);
//        NSArray *pointArray = @[[NSValue valueWithCGPoint:firstPoint],[NSValue valueWithCGPoint:secontPoint],[NSValue valueWithCGPoint:thirdPoint],[NSValue valueWithCGPoint:fourPoint]];
//
//        PathAnimation *pathView = [[PathAnimation alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth/2.0, 200) pointArray:pointArray pathCornerRadius:5 isNeedMove:YES];
////        pathView.backgroundColor = [UIColor redColor];
//        [self.view addSubview:pathView];
//    }
//    {
//        CGPoint firstPoint = CGPointMake(150, 50);
//        CGPoint secontPoint = CGPointMake(100, 50);
//        CGPoint thirdPoint = CGPointMake(100, 150);
//        CGPoint fourPoint = CGPointMake(50, 150);
//        NSArray *pointArray = @[[NSValue valueWithCGPoint:firstPoint],[NSValue valueWithCGPoint:secontPoint],[NSValue valueWithCGPoint:thirdPoint],[NSValue valueWithCGPoint:fourPoint]];
//
//        PathAnimation *pathView = [[PathAnimation alloc] initWithFrame:CGRectMake(ScreenWidth/2.0, 0, ScreenWidth/2.0, 200) pointArray:pointArray pathCornerRadius:5 isNeedMove:YES];
////        pathView.backgroundColor = [UIColor yellowColor];
//        [self.view addSubview:pathView];
//    }

}

- (void)initView{
    HHPopButton *nextMonthBtn = [[HHPopButton alloc] initWithFrame:CGRectMake(50, 150, 100, 50)];
    [nextMonthBtn setTitle:@"按钮" forState:UIControlStateNormal];
    nextMonthBtn.center = self.view.center;
    [nextMonthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    nextMonthBtn.colicActionBlock = ^(){
        [self nextMonthBtnAction];
    };
    nextMonthBtn.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:nextMonthBtn];
}

- (void)nextMonthBtnAction {

}

- (void)initAnimationWithPointArray:(NSArray *)pointArray {
    CGFloat cornerRadius = 5;
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    for (int i = 0; i < pointArray.count; i++) {
        CGPoint point = CGPointFromString(pointArray[i]);
        if (i == 0) { // 开始点
            [linePath moveToPoint:point];
        }else if (i == pointArray.count - 1) { // 终止点
            [linePath addLineToPoint:point];
        }else {
            CGPoint lastPoint = CGPointFromString(pointArray[i-1]);
            CGPoint nextPoint = CGPointFromString(pointArray[i+1]);
            CGPoint centerPoint = CGPointZero;
            CGPoint pointA = point;
            CGFloat startAngle = 0;
            if (point.x == lastPoint.x) { // 垂直线
                if (point.y > lastPoint.y) { // 向下
                    centerPoint.y = point.y - cornerRadius;
                }else { // 向上
                    centerPoint.y = point.y + cornerRadius;
                }
                pointA = CGPointMake(point.x, centerPoint.y);
            }else if (point.y == lastPoint.y) { // 水平线
                if (point.x > lastPoint.x) { // 向右
                    centerPoint.x = point.x - cornerRadius;
                }else {
                    centerPoint.x = point.x + cornerRadius;
                }
                pointA = CGPointMake(centerPoint.x, point.y);
            }
            if (point.x == nextPoint.x) { // 垂直
                if (point.y > nextPoint.y) {
                    centerPoint.y = point.y - cornerRadius;
                    startAngle = M_PI_2; // 两边方向起始角度是一致的，方向不同而已
                }else {
                    centerPoint.y = point.y + cornerRadius;
                    startAngle = -M_PI_2;
                }
            }else if (point.y == nextPoint.y) {
                if (point.x > nextPoint.x) {
                    centerPoint.x = point.x - cornerRadius;
                    startAngle = 0;
                }else {
                    centerPoint.x = point.x + cornerRadius;
                    startAngle = M_PI;
                }
            }
            /**向量叉积 P×Q=（x1y2-x2y1)
             叉积时一个非常重要的性质是可以通过它的符号判断两向量相互之间的顺逆时针关系：
             若P×Q > 0 , 则P在Q的顺时针方向；
             若P×Q < 0 , 则P在Q的逆时针方向；
             若P×Q = 0 , P与Q共线，可能是同向也可能是反向；
             iOS中坐标下为y正，右为x正，顺逆相反
             */
            CGPoint lastToPoint = CGPointMake(point.x - lastPoint.x, point.y - lastPoint.y);
            CGPoint nextToPoint = CGPointMake(nextPoint.x - point.x, nextPoint.y - point.y);
            // 叉积
            CGFloat result = lastToPoint.x*nextToPoint.y - nextToPoint.x*lastToPoint.y;
            // 判断旋转方向
            BOOL clockwise = (result < 0) ? NO : YES;
            CGFloat endAngle = clockwise ? (startAngle + M_PI_2) : (startAngle - M_PI_2);
            // 圆角
            [linePath addLineToPoint:pointA];
            [linePath addArcWithCenter:centerPoint radius:cornerRadius startAngle:startAngle endAngle:endAngle clockwise:clockwise];
        }
    }
    
    // 路线
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.path = linePath.CGPath;
    lineLayer.lineWidth = 2;
    lineLayer.lineCap = kCALineCapRound;
    lineLayer.lineJoin = kCALineJoinRound;
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    lineLayer.strokeColor = [UIColor fontColorLightMain].CGColor;
    [self.view.layer addSublayer:lineLayer];
    
    // 小圆点
    UIView *roundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
    roundView.backgroundColor = [UIColor clearColor];
    roundView.center = CGPointZero;
    [self.view addSubview:roundView];
    
    // 画外圆
    UIBezierPath *roundPath = [UIBezierPath bezierPath];
    [roundPath addArcWithCenter:CGPointMake(roundView.frame.size.width/2.0, roundView.frame.size.height/2.0) radius:CGRectGetWidth(roundView.frame)/2.0 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    CAShapeLayer *roundLayer = [CAShapeLayer layer];
    roundLayer.fillColor = [UIColor clearColor].CGColor;
    roundLayer.strokeColor = [UIColor colorWithHex:0x4682F4 alpha:0.3].CGColor;
    roundLayer.lineWidth = 2;
    roundLayer.path = [roundPath CGPath];
    [roundView.layer addSublayer:roundLayer];
    
    // 画内圆
    UIBezierPath *smallRoundPath = [UIBezierPath bezierPath];
    [smallRoundPath addArcWithCenter:CGPointMake(roundView.frame.size.width/2.0, roundView.frame.size.height/2.0) radius:4 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    CAShapeLayer *smallRoundLayer = [CAShapeLayer layer];
    smallRoundLayer.fillColor = [UIColor whiteColor].CGColor;
    smallRoundLayer.strokeColor = [UIColor colorWithHex:0x4682F4].CGColor;
    smallRoundLayer.lineWidth = 2;
    smallRoundLayer.path = [smallRoundPath CGPath];
    [roundView.layer addSublayer:smallRoundLayer];
    
    //圆圈位移动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //移动路径
    animation.path = lineLayer.path;
    animation.duration = 5;
    animation.autoreverses = NO;
    animation.repeatCount = CGFLOAT_MAX;
    animation.removedOnCompletion = NO;
    animation.calculationMode = kCAAnimationPaced;
    [roundView.layer addAnimation:animation forKey:@"position"];
}
@end
