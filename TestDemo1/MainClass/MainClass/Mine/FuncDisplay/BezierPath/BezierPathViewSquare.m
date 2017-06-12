//
//  BezierPathViewSquare.m
//  TestDemo1
//
//  Created by caohouhong on 17/6/8.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "BezierPathViewSquare.h"

@implementation BezierPathViewSquare

+ (BezierPathViewSquare *)addViewTo:(UIView *)view{
    BezierPathViewSquare *baseView = [[BezierPathViewSquare alloc] initWithFrame:CGRectMake(ScreenWidth/2, 0, ScreenWidth/2, 80)];
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
    UIColor *color = [UIColor redColor];
    [color set];
    
    //绘制
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 3.0;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinBevel;
    
    [path moveToPoint:CGPointMake(20, 10)];
    
    [path addLineToPoint:CGPointMake(100, 10)];
    [path addLineToPoint:CGPointMake(110, 30)];
    [path addLineToPoint:CGPointMake(100, 50)];
    [path addLineToPoint:CGPointMake(20, 50)];
    [path addLineToPoint:CGPointMake(10, 30)];
    [path closePath];
    [path fill];
    
    //矩形
    UIBezierPath *pathSquare = [UIBezierPath bezierPathWithRect:CGRectMake(120,10 , 20, 40)];
    pathSquare.lineWidth = 1.0;
    UIColor *green = [UIColor greenColor];
    [green set];
    [pathSquare stroke];
    
    //带圆角边框
    UIBezierPath *roundPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(20, 20)];
    roundPath.lineWidth = 4.0;
    [roundPath stroke];
}

@end
