//
//  BezierPathViewBase.m
//  TestDemo1
//
//  Created by caohouhong on 17/6/8.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "BezierPathViewBase.h"

@implementation BezierPathViewBase

+ (BezierPathViewBase *)addViewTo:(UIView *)view{
    BezierPathViewBase *baseView = [[BezierPathViewBase alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth/2, 80)];
    [view addSubview:baseView];
    return baseView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {

    UIColor *color = [UIColor redColor];
    //设置颜色
    [color set];
    UIBezierPath *path = [UIBezierPath bezierPath];
    //起点
    [path moveToPoint:CGPointMake(10, 10)];
    //终点
    [path addLineToPoint:CGPointMake(30, 30)];
    //线条宽度
    path.lineWidth = 4.0;
    path.lineCapStyle = kCGLineCapRound; //起点和终点的样式 1.默认 2.圆形 3.方形（和默认很相似）
    path.lineJoinStyle = kCGLineJoinRound; //两条线连结点样式 1.斜接 2.圆滑衔接 3.斜角连接
    //用 stroke 得到的是不被填充的 view
    [path stroke];
    
    //用 fill 得到的内部被填充的 view
//    [path fill];
}

@end
