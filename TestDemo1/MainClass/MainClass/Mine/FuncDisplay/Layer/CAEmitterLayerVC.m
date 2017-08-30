//
//  CAEmitterLayerVC.m
//  TestDemo1
//
//  Created by caohouhong on 17/6/13.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "CAEmitterLayerVC.h"
#import "HHEmitterButton.h"

@interface CAEmitterLayerVC ()
@property (nonatomic, strong) HHEmitterButton *button;
@property (nonatomic, strong) UIView *fireView;
@property (nonatomic, strong) CAEmitterLayer *emitterLayer;

@end

@implementation CAEmitterLayerVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initView];
    [self fireEmitterLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initView{
    _button = [[HHEmitterButton alloc] initWithFrame:CGRectMake(50, 10, 100, 50)];
    [_button setImage:[UIImage imageNamed:@"icon_xin_n"] forState:UIControlStateNormal];
    [_button setImage:[UIImage imageNamed:@"icon_xin_s"] forState:UIControlStateSelected];
    [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
    _fireView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, ScreenWidth, ScreenWidth - 100)];
    _fireView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_fireView];
}

//粒子发射器
- (void)fireEmitterLayer{
    
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    //展示的图片
    cell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"white_piece"].CGImage);
    
    //每秒粒子产生个数的乘数因子，会和layer的birthRate相乘，然后确定每秒产生的粒子个数
    cell.birthRate = 2000;
    //每个粒子存活时长
    cell.lifetime = 5.0;
    //粒子生命周期范围
    cell.lifetimeRange = 0.3;
    //粒子透明度变化，设置为－0.4，就是每过一秒透明度就减少0.4，这样就有消失的效果,一般设置为负数。
    cell.alphaSpeed = -0.2;
    cell.alphaRange = 0.5;
    //粒子的速度
    cell.velocity = 40;
    //粒子的速度范围
    cell.velocityRange = 20;
    //周围发射的角度，如果为M_PI*2 就可以从360度任意位置发射
//    cell.emissionRange = M_PI*2;
    //粒子内容的颜色
//    cell.color = [[UIColor whiteColor] CGColor];
    
    cell.color = [[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.000] CGColor];

    cell.redRange = 1;
    cell.greenRange = 1;
    cell.blueRange = 1;
    
    //缩放比例
    cell.scale = 0.09;
    //缩放比例范围
    cell.scaleRange = 0.02;

    //粒子的初始发射方向
    cell.emissionLongitude = M_PI;
    //Y方向的加速度
    cell.yAcceleration = 70.0;
//    cell.xAcceleration = 20.0;
    
    _emitterLayer = [CAEmitterLayer layer];

    //发射位置
    _emitterLayer.emitterPosition = CGPointMake(self.fireView.frame.size.width/2.0, 0);
    //粒子产生系数，默认为1
    _emitterLayer.birthRate = 1;
    //发射器的尺寸
    _emitterLayer.emitterSize = CGSizeMake(ScreenWidth, 0);
    //发射的形状
    _emitterLayer.emitterShape = kCAEmitterLayerLine;
    //发射的模式
    _emitterLayer.emitterMode = kCAEmitterLayerOutline;
    //渲染模式
    _emitterLayer.renderMode = kCAEmitterLayerOldestFirst;
    _emitterLayer.masksToBounds = NO;
    
    
    _emitterLayer.zPosition = -1;
    _emitterLayer.emitterCells = @[cell];
    [self.fireView.layer addSublayer:_emitterLayer];
}


- (void)buttonAction:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (btn.selected){
        [self startAnimation];
    }else {
    }
    
}

- (void) startAnimation{
    self.emitterLayer.beginTime = CACurrentMediaTime();
    self.emitterLayer.birthRate = 1;
   
    
    [self performSelector:@selector(stopAnimation) withObject:nil afterDelay:0.15];
}

- (void) stopAnimation{
    self.emitterLayer.birthRate = 0;
   
}
@end
