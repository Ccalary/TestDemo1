//
//  LoadingAnimation.h
//  LoadingDemo
//
//  Created by caohouhong on 2018/12/13.
//  Copyright © 2018年 chh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadingAnimation : NSObject
+ (instancetype)sharedInstance;
- (void)show;
- (void)dismiss;
@end
