//
//  Draw2DView.m
//  TestDemo1
//
//  Created by caohouhong on 17/5/8.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "Draw2DView.h"

@implementation Draw2DView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    //获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 1);//设置线宽
    CGContextSetRGBStrokeColor(ctx, 0, 1, 0, 1);//设置颜色
    //定义4个点绘制线段
    const CGPoint points1[] = {
        CGPointMake(10, 10), CGPointMake(20, 20),CGPointMake(20, 20),CGPointMake(10, 30)
    };
    CGContextStrokeLineSegments(ctx, points1, 4);//绘制线段，默认不绘制端点
    CGContextSetLineCap(ctx, kCGLineCapSquare);//设置线段的端点形状：方形端点
}

@end

