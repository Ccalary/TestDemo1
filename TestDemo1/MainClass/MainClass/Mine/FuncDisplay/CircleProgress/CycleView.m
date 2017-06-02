//
//  CycleView.m
//  TestDemo1
//
//  Created by caohouhong on 17/6/1.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "CycleView.h"
@interface CycleView()
@property (nonatomic, strong) UILabel *progressLabel;
@end

@implementation CycleView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        _progress = 0.5;
        [self initView];
    }
    return self;
}

- (void)initView{
    _progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    _progressLabel.center = CGPointMake(100, 100);
    _progressLabel.text = [NSString stringWithFormat:@"%.2f％",_progress*100];
    _progressLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_progressLabel];
    
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //设置圆心
    CGPoint center = CGPointMake(100, 100);
    //设置半径
    CGFloat radius = 90;
    //圆的起点位置
    CGFloat startA = - M_PI_2;
    //圆点终点位置
    CGFloat endA = -M_PI_2 + M_PI*2*_progress;
    //贝赛尔曲线
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startA endAngle:endA clockwise:YES];
    //设置线条宽度
    CGContextSetLineWidth(ctx, 10);
    //描边颜色
    [[UIColor blueColor] setStroke];
    //把路径添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    //渲染
    CGContextStrokePath(ctx);
}

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    //重新绘制
    _progressLabel.text = [NSString stringWithFormat:@"%.2f％",_progress*100];
    [self setNeedsDisplay];
}
@end
