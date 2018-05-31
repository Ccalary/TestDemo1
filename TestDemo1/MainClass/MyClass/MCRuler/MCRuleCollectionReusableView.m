//
//  MCRuleCollectionReusableView.m
//  MCRuleDemo
//
//  Created by caohouhong on 2018/5/31.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "MCRuleCollectionReusableView.h"

@implementation MCRuleCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){
        [self initView];
    }
    return self;
}

- (void)initView {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height/2.0 + 1, self.frame.size.width, 1)];
    lineView.backgroundColor = [UIColor redColor];
    [self addSubview:lineView];
}
@end
