//
//  FPSTools.m
//  TestDemo1
//
//  Created by caohouhong on 2018/5/10.
//  Copyright © 2018年 caohouhong. All rights reserved.
//  测试界面流畅度的工具

#import "FPSTools.h"
@interface FPSTools ()
{
    NSInteger _count;
    NSTimeInterval _lastTime;
    CADisplayLink *link;
}
@end

@implementation FPSTools

- (instancetype)init{
    if (self = [super init]) {

        link = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLink:)];
        [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (void)displayLink:(CADisplayLink *)link{
    if (_lastTime == 0){
        _lastTime = link.timestamp;
        return;
    }
    //每秒刷新帧率
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    float fps = _count / delta;
    _count = 0;
    NSString *fpsStr = [NSString stringWithFormat:@"%d FPS",(int)round(fps)];
    if (self.block){
        self.block(fpsStr);
    }
}

- (void)finish {
    [link invalidate];
    link = nil;
}
@end
