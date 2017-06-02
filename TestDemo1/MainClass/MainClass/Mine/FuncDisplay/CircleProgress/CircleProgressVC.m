//
//  CircleProgressVC.m
//  TestDemo1
//
//  Created by caohouhong on 17/5/31.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "CircleProgressVC.h"
#import "CycleView.h"
#import "BlueView.h"

@interface CircleProgressVC ()
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) CycleView *cycleView;
@property (nonatomic, strong) BlueView *blueView;
@end

@implementation CircleProgressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _cycleView = [[CycleView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 200)];
    _cycleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_cycleView];
    
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(15, 250, ScreenWidth - 30, 10)];
    [_slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider];
    
    _blueView = [[BlueView alloc] initWithFrame:CGRectMake(0, 300, ScreenWidth, 300)];
    _blueView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_blueView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}

- (void)sliderAction:(UISlider *)slider{
    DLog(@"progress=%.2f",slider.value);
    _cycleView.progress = slider.value;
    
    [_blueView animationWithStrokeEnd:slider.value];
}

@end
