//
//  HHRefreshNormalHeader.m
//  TestDemo1
//
//  Created by caohouhong on 17/4/25.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "HHRefreshNormalHeader.h"

@implementation HHRefreshNormalHeader

- (void)prepare{
    [super prepare];
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
}

@end
