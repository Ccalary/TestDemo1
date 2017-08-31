//
//  HHEmitterButton.m
//  TestDemo1
//
//  Created by caohouhong on 17/6/13.
//  Copyright © 2017年 caohouhong. All rights reserved.
//  点击按钮周围会有一圈粒子散去，模仿点赞的效果

#import "HHEmitterButton.h"
@interface HHEmitterButton()
@property(strong,nonatomic) CAEmitterLayer *explosionLayer;
@end

@implementation HHEmitterButton

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected){
        [self explosionAni];
    }else {
        [self stopAnimation];
    }
}

- (void)drawRect:(CGRect)rect {
    [self setupExplosion];
}

- (void)setupExplosion{
    CAEmitterCell *explosionCell = [[CAEmitterCell alloc] init];
    
    explosionCell.name = @"explosion";
    //设置粒子颜色alpha能改变的范围
    explosionCell.alphaRange = 0.10;
    //粒子alpha的改变速度
    explosionCell.alphaSpeed = -1.0;
    //粒子的生命周期
    explosionCell.lifetime = 0.7;
    //粒子生命周期的范围
    explosionCell.lifetimeRange = 0.3;
    //粒子每秒产生的数目
    explosionCell.birthRate = 2500;
    //粒子的速度
    explosionCell.velocity = 40.00;
    //粒子的速度范围
    explosionCell.velocityRange = 10.00;
    //粒子的缩放比例
    explosionCell.scale = 0.03;
    //缩放比例范围
    explosionCell.scaleRange = 0.02;
    //发射范围（设置后是散状，不设置会从中间一个圆圈出去）
//    explosionCell.emissionRange = M_PI*2;
    //粒子要展示的图片（会展示图片颜色的粒子）
    explosionCell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"icon_xin_s"].CGImage);
    //发射源包含的粒子
    self.explosionLayer.emitterCells = @[explosionCell];
    [self.layer addSublayer:self.explosionLayer];
}

- (CAEmitterLayer *)explosionLayer{
    if (_explosionLayer == nil){
        _explosionLayer = [[CAEmitterLayer alloc] init];
        //发射的形状
        _explosionLayer.emitterShape = kCAEmitterLayerCircle;
        //发射模式
        _explosionLayer.emitterMode = kCAEmitterLayerOutline;
        //发射源大小
        _explosionLayer.emitterSize = CGSizeMake(10, 0);
        //渲染模式
        _explosionLayer.renderMode = kCAEmitterLayerOldestFirst;
        _explosionLayer.masksToBounds = NO;
        _explosionLayer.birthRate = 0;
        //发射位置
        _explosionLayer.position = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
        
        _explosionLayer.zPosition = -1;
    }
    return _explosionLayer;
}

//发射动画
- (void)explosionAni{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    if (self.selected){
        //动画
        animation.values = @[@2.0,@0.5,@1.0,@1.2,@1.0];
        animation.duration = 0.5;
        [self startAnimation];
    }else {
        animation.values = @[@0.8,@1.0];
        animation.duration = 0.5;
    }
    //根据模式估算时间
//    animation.calculationMode = kCAAnimationCubic;
    [self.layer addAnimation:animation forKey:@"explosionAni"];
}

- (void) startAnimation{
    self.explosionLayer.beginTime = CACurrentMediaTime();
    self.explosionLayer.birthRate = 1;
    NSLog(@"startAnimation被执行啦.birthRate = %f",self.explosionLayer.birthRate);
    
    [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:0.15];
}

- (void) stopAnimation{
    self.explosionLayer.birthRate = 0;
    NSLog(@"stopAnimation被执行啦，birthRate = %f",self.explosionLayer.birthRate);
}

@end
