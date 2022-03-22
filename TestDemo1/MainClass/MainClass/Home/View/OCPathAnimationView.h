//
//  PathAnimationView.h
//  TestDemo1
//
//  Created by caohouhong on 2022/3/18.
//  Copyright © 2022 caohouhong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OCPathAnimationView : UIView
/*
  NSStringFromCGPoint(CGPointMake(50, 50)) 此种类型数组
 */
@property (nonatomic, strong) NSArray *pointArray;
/**
  路径的转角半径，默认是5.0
*/
@property (nonatomic, assign) CGFloat pathCornerRadius;
@end

NS_ASSUME_NONNULL_END
