//
//  UIView+MCTransition.m
//  MCTransitionDemo
//
//  Created by caohouhong on 2018/4/27.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "UIView+MCTransition.h"

@implementation UIView (MCTransition)
/**
 *  设置动画
 *  默认MoveIn，FromLeft，1s,Linear
 */
- (void)setTransitionAnimationWithType{
    [self setTransitionAnimationWithType:MCTransitonAnimTypeMoveIn
                                duration:1.0f
                               direction:MCTransitonAnimDirectionFromLeft
                              timingFunc:MCTransitonAnimTimingFuncLinear];
}

/**
 *  动画设置
 *
 *  @param animType     动画种类
 *  @param duration     时间
 *  @param subtype      方向
 *  @param timingFunc   速度变化
 */
- (void)setTransitionAnimationWithType:(MCTransitonAnimType)animType
                              duration:(float)duration
                             direction:(MCTransitonAnimDirection)subtype
                            timingFunc:(MCTransitonAnimTimingFunc)timingFunc
{
    CATransition *trans = [CATransition animation];
    trans.duration = duration;
    // 动画种类
    switch (animType) {
        case MCTransitonAnimTypeFade://渐变，效果不明显
            trans.type = kCATransitionFade;
            break;
        case MCTransitonAnimTypeMoveIn://新的移入
            trans.type = kCATransitionMoveIn;
            break;
        case MCTransitonAnimTypeReveal://旧的移出
            trans.type = kCATransitionReveal;
            break;
        case MCTransitonAnimTypePush://推入,新的推入旧的推出
            trans.type = kCATransitionPush;
            break;
        case MCTransitonAnimTypePageCurl:// 向上翻一页
            trans.type = @"pageCurl";
            break;
        case MCTransitonAnimTypePageUnCurl:// 向下翻一页
            trans.type = @"pageUnCurl";
            break;
        case MCTransitonAnimTypeRippleEffect:// 波纹
            trans.type = @"rippleEffect";
            break;
        case MCTransitonAnimTypeSuckEffect:// 像一块布被抽走
            trans.type = @"suckEffect";
            break;
        case MCTransitonAnimTypeCube:// 立方体
            trans.type = @"cube";
            break;
        case MCTransitonAnimTypeOglFlip:// 平面反转
            trans.type = @"oglFlip";
            break;
        case MCTransitonAnimTypeCameraIrisHollowOpen://摄像机开
            trans.type = @"cameraIrisHollowOpen";
            break;
        case MCTransitonAnimTypeCameraIrisHollowClose://摄像机关
            trans.type = @"cameraIrisHollowClose";
            break;
        default:
            break;
    }
    // 动画的速度变化
    switch (timingFunc) {
        case MCTransitonAnimTimingFuncLinear:
            trans.timingFunction =  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            break;
        case MCTransitonAnimTimingFuncEaseIn:
            trans.timingFunction =  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            break;
        case MCTransitonAnimTimingFuncEaseOut:
            trans.timingFunction =  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            break;
        case MCTransitonAnimTimingFuncEaseInEaseOut:
            trans.timingFunction =  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            break;
        default:
            break;
    }
    switch (subtype) {
        case MCTransitonAnimDirectionFromLeft:
            trans.subtype = kCATransitionFromLeft;
            break;
        case MCTransitonAnimDirectionFromRight:
            trans.subtype = kCATransitionFromRight;
            break;
        case MCTransitonAnimDirectionFromTop:
            trans.subtype = kCATransitionFromTop;
            break;
        case MCTransitonAnimDirectionFromBottom:
            trans.subtype = kCATransitionFromBottom;
            break;
        default:
            break;
    }
    [self.layer addAnimation:trans forKey:nil];
}
@end
