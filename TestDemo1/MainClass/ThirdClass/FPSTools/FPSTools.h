//
//  FPSTools.h
//  TestDemo1
//
//  Created by caohouhong on 2018/5/10.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^fpsBlock)(NSString *fpsStr);
@interface FPSTools : NSObject
@property (nonatomic, copy) fpsBlock block;
- (instancetype)init;
- (void)finish;
@end
