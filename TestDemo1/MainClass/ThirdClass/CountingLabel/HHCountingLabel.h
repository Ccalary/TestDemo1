//
//  HHCountingLabel.h
//  TestDemo1
//
//  Created by caohouhong on 17/5/25.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHCountingLabel : UILabel
- (void)countFrom:(CGFloat)startVale toValue:(CGFloat)endValue withDuration:(NSTimeInterval)duration;
@end
