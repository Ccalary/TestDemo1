//
//  HomeViewController.m
//  TestDemo1
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "HomeViewController.h"
#import "HHPopButton.h"
#import "OCPathAnimationView.h"
#import "TestDemo1-Swift.h"

@interface HomeViewController ()<ChartViewDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    
    NSString *a = @"a";
    NSString *b = a;
    a = @"c";
    
    NSLog(@"a-%p,b-%p", a, b);
}
@end

