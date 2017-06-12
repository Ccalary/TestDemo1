//
//  BezierPathQuadCurve.m
//  TestDemo1
//
//  Created by caohouhong on 17/6/9.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "BezierPathQuadCurve.h"

@implementation BezierPathQuadCurve

+ (BezierPathQuadCurve *)addViewTo:(UIView *)view{
    BezierPathQuadCurve *baseView = [[BezierPathQuadCurve alloc] initWithFrame:CGRectMake(ScreenWidth/2.0, 80, ScreenWidth/2, 80)];
    [view addSubview:baseView];
    return baseView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    //二次贝赛尔曲线
    UIColor *color = [UIColor redColor];
    [color set];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    //起点
    [path moveToPoint:CGPointMake(10, 30)];
    //终点， 控制点
    [path addQuadCurveToPoint:CGPointMake(100, 30) controlPoint:CGPointMake(20, 0)];
    [path stroke];
    
    //三次贝赛尔曲线
    UIBezierPath *threePath = [UIBezierPath bezierPath];
    [threePath moveToPoint:CGPointMake(10, 60)];
    [threePath addCurveToPoint:CGPointMake(150, 60) controlPoint1:CGPointMake(20, 40) controlPoint2:CGPointMake(100, 80)];
    [threePath stroke];
    
}

@end
