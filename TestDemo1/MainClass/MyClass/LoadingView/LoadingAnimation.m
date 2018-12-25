//
//  LoadingAnimation.m
//  LoadingDemo
//
//  Created by caohouhong on 2018/12/13.
//  Copyright © 2018年 chh. All rights reserved.
//

#import "LoadingAnimation.h"
#import <Lottie/Lottie.h>
@interface LoadingAnimation()
@property (nonatomic, strong) UIView *holdView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) LOTAnimationView *animation;
@property (nonatomic, assign) NSUInteger tapNum;
@end
@implementation LoadingAnimation
+ (instancetype)sharedInstance {
    static LoadingAnimation *_animation = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _animation = [[self alloc] init];
    });
    return _animation;
}

- (void)show {
    _tapNum = 0;
    UIView *keyView = [UIApplication sharedApplication].keyWindow;
    
    _holdView = [[UIView alloc] initWithFrame:keyView.bounds];
    _holdView.backgroundColor = [UIColor clearColor];
    [keyView addSubview:_holdView];
    
    UITapGestureRecognizer *atap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(atapAction)];
    [_holdView addGestureRecognizer:atap];
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 120)];
    _bgView.layer.cornerRadius = 20;
    _bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [_holdView addSubview:_bgView];
    _bgView.center = _holdView.center;
    
    _animation = [LOTAnimationView animationNamed:@"loading_a"];
    _animation.loopAnimation = YES;
    _animation.animationSpeed = 2;
    [_holdView addSubview:_animation];
    _animation.center = _holdView.center;
    [_animation playWithCompletion:^(BOOL animationFinished) {
        
    }];
}

- (void)atapAction {
    self.tapNum += 1;
    if (self.tapNum >= 3){
       [self dismiss];
    }
}

- (void)dismiss {
    self.tapNum = 0;
    if (_animation){
       [_animation stop];
    }
    if (_holdView){
       [_holdView removeFromSuperview];
    }
}
@end
