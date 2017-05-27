//
//  HHPopButton.h
//  TestDemo1
//
//  Created by caohouhong on 17/5/27.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHPopButton : UIButton

@property (nonatomic, copy) void (^colicActionBlock)();
@end
