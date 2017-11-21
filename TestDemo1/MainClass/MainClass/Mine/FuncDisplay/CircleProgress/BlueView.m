//
//  BlueView.m
//  TestDemo1
//
//  Created by caohouhong on 17/5/31.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "BlueView.h"
#import <pop/POP.h>

@interface BlueView()
@property (nonatomic, strong) CAShapeLayer *colorLayer;
@property (nonatomic, strong) CAShapeLayer *colorMaskLayer, *blueMaskLayer;
@end

@implementation BlueView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        [self setupColorLayer];
        [self setupBlueMaskLayer];
    }
    return self;
}

/*
思路整理，背景色是一层，渐变图是一个底层layer,然后一个环形mask遮罩，在这个上面再加一层遮罩才能显示出来看不到底色的效果图，动画可以实现变化时的动画效果。
 */
- (void)setupColorLayer{
    
    self.colorLayer = [CAShapeLayer layer];
    self.colorLayer.frame = self.bounds;
    [self.layer addSublayer:self.colorLayer];
    
    CAGradientLayer *leftLayer = [CAGradientLayer layer];
    leftLayer.frame = CGRectMake(0, 0, self.frame.size.width/2.0, self.frame.size.height);
    //分段设置颜色
    leftLayer.locations = @[@0.3,@0.9,@1];
    leftLayer.colors = @[(__bridge id)[UIColor yellowColor].CGColor,
                             (__bridge id)[UIColor greenColor].CGColor];
    [self.colorLayer addSublayer:leftLayer];

    CAGradientLayer *rightLayer = [CAGradientLayer layer];
    rightLayer.frame = CGRectMake(self.frame.size.width/2.0, 0, self.frame.size.width/2.0, self.frame.size.height);
    //分段设置颜色
    rightLayer.locations = @[@0.3,@0.9,@1];
    rightLayer.colors = @[(__bridge id)[UIColor yellowColor].CGColor,
                         (__bridge id)[UIColor redColor].CGColor];
    [self.colorLayer addSublayer:rightLayer];
    
    CAShapeLayer *layer = [self generateMaskLayer];
    layer.lineWidth = 30; // 渐变遮罩线宽较大，防止蓝色遮罩有边露出来
    self.colorLayer.mask = layer;
    
    self.colorMaskLayer = [CAShapeLayer layer];
    self.colorMaskLayer = layer;
   }

//环形遮罩
- (CAShapeLayer *)generateMaskLayer{
    CAShapeLayer *sharpLayer = [CAShapeLayer layer];
    sharpLayer.frame = self.bounds;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0) radius:90 startAngle:-M_PI_2 endAngle:-M_PI_2 + 2*M_PI clockwise:YES];
    sharpLayer.lineWidth = 10;
    sharpLayer.path = path.CGPath;
    sharpLayer.fillColor = [UIColor clearColor].CGColor;//填充为透明
    sharpLayer.strokeColor = [UIColor blackColor].CGColor; //随便设置一个边框颜色
    sharpLayer.lineCap = kCALineCapRound;//设置线为圆角
    return sharpLayer;
}

- (void)setupBlueMaskLayer {
    
    CAShapeLayer *layer = [self generateMaskLayer];
    self.layer.mask = layer;
    self.blueMaskLayer = layer;
}

- (void)animationWithStrokeEnd:(CGFloat)strokeEnd {
    
    
    POPSpringAnimation *strokeAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPShapeLayerStrokeEnd];
    strokeAnimation.toValue = @(strokeEnd);
    strokeAnimation.springBounciness = 12.f;
    strokeAnimation.removedOnCompletion = NO;
    [self.colorMaskLayer pop_addAnimation:strokeAnimation forKey:@"layerStrokeAnimation"];
}

@end
