//
//  TransitonViewController.m
//  TestDemo1
//
//  Created by caohouhong on 2018/4/27.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "TransitonViewController.h"
#import "UIView+MCTransition.h"
#import "HomeViewController.h"

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
    _imageView.userInteractionEnabled = YES;
    [self.view addSubview:_imageView];
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.imageView addGestureRecognizer:swipeGesture];
    
    UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    [nextBtn setTitle:@"转场跳转" forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [nextBtn setBackgroundColor:[UIColor lightGrayColor]];
    [nextBtn addTarget:self action:@selector(nextBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    nextBtn.center = self.view.center;
    
}

- (void)swipeAction {
    _imageView.image = [UIImage imageNamed:_imageArray[arc4random()%_imageArray.count]];
    //转场动画
    [_imageView setTransitionAnimationWithType:MCTransitonAnimTypeCube
                                      duration:2
                                     direction:MCTransitonAnimDirectionFromLeft
                                    timingFunc:MCTransitonAnimTimingFuncLinear];
}

- (void)nextBtnAction{
    // 更改转场动画效果
    [self.navigationController.view setTransitionAnimationWithType:MCTransitonAnimTypeSuckEffect
                              duration:1
                             direction:MCTransitonAnimDirectionFromLeft
                            timingFunc:MCTransitonAnimTimingFuncEaseInEaseOut];
    [self.navigationController pushViewController:[[HomeViewController alloc] init] animated:YES];
}

@end
