//
//  BezierPathViewRound.m
//  TestDemo1
//
//  Created by caohouhong on 17/6/9.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "BezierPathViewRound.h"

@implementation BezierPathViewRound

+ (BezierPathViewRound *)addViewTo:(UIView *)view{
    BezierPathViewRound *baseView = [[BezierPathViewRound alloc] initWithFrame:CGRectMake(0, 80, ScreenWidth/2, 80)];
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
    
    UIColor *redColor = [UIColor redColor];
    [redColor set];
    //圆弧的创建
    //圆心
    CGPoint centerPoint = CGPointMake(20, 40);
    CGFloat radius = 15;
    //clockwise 是否顺时针方向
    UIBezierPath *roundPath = [UIBezierPath bezierPathWithArcCenter:centerPoint radius:radius startAngle:0 endAngle:4*M_PI/3.0 clockwise:YES];
    roundPath.lineWidth = 4.0;
    [roundPath stroke];
    
    //椭圆的创建
    UIBezierPath *rectRoundPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(60, 25, 50, 40)];
    [rectRoundPath stroke];
}


@end
