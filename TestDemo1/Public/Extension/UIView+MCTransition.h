//
//  UIView+MCTransition.h
//  MCTransitionDemo
//
//  Created by caohouhong on 2018/4/27.
//  Copyright © 2018年 caohouhong. All rights reserved.
//  转场动画

#import <UIKit/UIKit.h>

@interface UIView (MCTransition)
/**
 动画效果
 */
typedef enum {
    MCTransitonAnimTypeFade,        //渐变，效果不明显
    MCTransitonAnimTypeMoveIn,      //新的移入
    MCTransitonAnimTypeReveal,      //旧的移出
    MCTransitonAnimTypePush,         //推入,新的推入旧的推出
    MCTransitonAnimTypePageCurl,    // 向上翻一页
    MCTransitonAnimTypePageUnCurl,  // 向下翻一页
    MCTransitonAnimTypeRippleEffect,// 波纹
    MCTransitonAnimTypeSuckEffect,  // 像一块布被抽走
    MCTransitonAnimTypeCube,        // 立方体
    MCTransitonAnimTypeOglFlip,     // 平面反转
    MCTransitonAnimTypeCameraIrisHollowOpen, //摄像机开
    MCTransitonAnimTypeCameraIrisHollowClose //摄像机关
 
} MCTransitonAnimType;

/**
 动画方向
 */
typedef enum {
    MCTransitonAnimDirectionFromLeft,
    MCTransitonAnimDirectionFromRight,
    MCTransitonAnimDirectionFromTop,
    MCTransitonAnimDirectionFromBottom
} MCTransitonAnimDirection;

/**
 动画的速度变化
 */
typedef enum {
    MCTransitonAnimTimingFuncLinear,      //线性
    MCTransitonAnimTimingFuncEaseIn,      //慢入
    MCTransitonAnimTimingFuncEaseOut,     //慢出
    MCTransitonAnimTimingFuncEaseInEaseOut//慢入慢出
} MCTransitonAnimTimingFunc;

/**
 *  设置动画
 *  默认Fade，FromLeft，1s,Linear
 */
- (void)setTransitionAnimationWithType;
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
                            timingFunc:(MCTransitonAnimTimingFunc)timingFunc;
@end
