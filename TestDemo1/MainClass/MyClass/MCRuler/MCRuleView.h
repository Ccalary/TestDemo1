//
//  MCRuleView.h
//  MCRuleDemo
//
//  Created by caohouhong on 2018/5/31.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCRuleView : UIView
- (instancetype)initWithFrame:(CGRect)frame scrollBlock:(void(^)(float x)) block;
- (void)changePositonWithNum:(double)num;
@end
