//
//  HHCountingLabel.m
//  TestDemo1
//
//  Created by caohouhong on 17/5/25.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "HHCountingLabel.h"
@interface HHCountingLabel()
@property (nonatomic, assign) CGFloat startValue;
@property (nonatomic, assign) CGFloat endValue;
@property (nonatomic, assign) NSTimeInterval duration;
@property (nonatomic, strong) CADisplayLink *timer;
@end

@implementation HHCountingLabel

- (void)countFrom:(CGFloat)startVale toValue:(CGFloat)endValue withDuration:(NSTimeInterval)duration{
    
    self.startValue = startVale;
    self.endValue = endValue;
    self.duration = duration;
    [self.timer invalidate];
    self.timer = nil;
    
    _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateValue)];
    _timer.frameInterval = 10;//刷新频率，60Hz是60次／s, 设置为2 就是2帧走一次方法，即30次／s;
    [_timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)updateValue{
    
    self.startValue++;
    
    self.text = [NSString stringWithFormat:@"%.2f", self.startValue];
    
    self.textColor = [UIColor colorWithRed:arc4random() % 255/255.0 green:arc4random() % 255/255.0 blue:arc4random() % 255/255.0 alpha:1];
    
    if (self.startValue > self.endValue){
        [self.timer invalidate];
        self.timer = nil;
    }
    
//    DLog(@"%f",self.startValue);
}

- (void)willMoveToSuperview:(UIView *)newSuperview{
    //判断是新进入界面还是返回，如果是返回的话关闭timer,要不然会走完时间才执行dealloc
    if (!newSuperview) {
        [self.timer invalidate];
        self.timer = nil;
    }
    DLog(@"---moveToSuperview---");
}

- (void)dealloc{
    DLog(@"---dealloc---");
}

@end
