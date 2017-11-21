//
//  RoundCoverView.m
//  TestDemo1
//
//  Created by chh on 2017/9/27.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "RoundCoverView.h"

@interface RoundCoverView()
@property (nonatomic, strong) CAShapeLayer *roundShapeLayer;
@property (nonatomic, strong) UIImageView *bgImageView;
@end

@implementation RoundCoverView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self initView];
        [self.bgImageView.layer addSublayer:self.roundShapeLayer];
    }
    return self;
}

- (void)initView{
    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 30, 40, 40)];
    _bgImageView.image = [UIImage imageNamed:@"coin"];
    [self addSubview:_bgImageView];
}

- (CAShapeLayer *)roundShapeLayer{
    if (!_roundShapeLayer){
        _roundShapeLayer = [CAShapeLayer layer];
        _roundShapeLayer.frame = self.bounds;
        CGFloat radius = self.bgImageView.frame.size.width/2.0/2.0;
        // clockwise 是否为顺时针
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bgImageView.frame.size.width/2.0, self.bgImageView.frame.size.height/2.0) radius:radius startAngle:-M_PI_2  endAngle:-M_PI_2 + 2*M_PI clockwise:YES];
        _roundShapeLayer.lineWidth = radius*2; //经测试，宽度为半径的2倍可以填充整个圆（不确定）
        _roundShapeLayer.path = path.CGPath;
        _roundShapeLayer.fillColor = [UIColor clearColor].CGColor;//填充为透明
        _roundShapeLayer.strokeColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3].CGColor; //随便设置一个边框颜色
//        _roundShapeLayer.lineCap = kCALineCapRound;//设置线为圆角

    }
    return _roundShapeLayer;
}

- (void)animationWithStokenEnd:(CGFloat)end{
    
    self.roundShapeLayer.strokeStart = 1- end;
}

@end
