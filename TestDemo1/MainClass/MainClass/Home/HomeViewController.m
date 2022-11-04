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
#import "TestViewController.h"

@interface HomeViewController ()<ChartViewDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    LayoutVC *vc = [[LayoutVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end

