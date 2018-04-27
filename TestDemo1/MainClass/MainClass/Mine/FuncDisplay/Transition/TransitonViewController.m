//
//  TransitonViewController.m
//  TestDemo1
//
//  Created by caohouhong on 2018/4/27.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "TransitonViewController.h"
#import "UIView+MCTransition.h"

@interface TransitonViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSArray *imageArray;
@end

@implementation TransitonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _imageArray = @[@"img_1",@"img_1",@"img_1"];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
    _imageView.image = [UIImage imageNamed:_imageArray.firstObject];
    [self.view addSubview:_imageView];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _imageView.image = [UIImage imageNamed:_imageArray[arc4random()%_imageArray.count]];
    //转场动画
    [_imageView setTransitionAnimationWithType:MCTransitonAnimTypeCube
                                      duration:2
                                     direction:MCTransitonAnimDirectionFromLeft
                                    timingFunc:MCTransitonAnimTimingFuncLinear];
}

@end
