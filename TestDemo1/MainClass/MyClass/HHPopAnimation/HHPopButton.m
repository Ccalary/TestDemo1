//
//  HHPopButton.m
//  TestDemo1
//
//  Created by caohouhong on 17/5/27.
//  Copyright © 2017年 caohouhong. All rights reserved.
//  利用pop动画创建的点击按钮就会有动效

#import "HHPopButton.h"
#import <pop/POP.h>

@implementation HHPopButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self addTarget:self action:@selector(scaleAnimation) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (instancetype)init{
    if (self = [super init]){
        [self addTarget:self action:@selector(scaleAnimation) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)scaleAnimation{
    //动画过程中取消用户的交互，防止用户重复点击
    self.userInteractionEnabled = NO;
    POPSpringAnimation *sprAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    //它会先缩小然后再去放大到(1.0,1.0)
    sprAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.7, 0.7)];
    sprAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
    sprAnimation.springBounciness = 10;//弹簧弹力
    //动画结束之后的回调方法
    __weak typeof (self) weakSelf = self;
    sprAnimation.completionBlock = ^(POPAnimation *anim, BOOL isFinished){
        weakSelf.userInteractionEnabled = YES;
        if (weakSelf.colicActionBlock){
            weakSelf.colicActionBlock();
        };
    };
    [self.layer pop_addAnimation:sprAnimation forKey:@"kScaleAnimation"];
}

@end
