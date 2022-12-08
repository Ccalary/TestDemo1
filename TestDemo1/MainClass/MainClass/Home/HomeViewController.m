//
//  HomeViewController.m
//  TestDemo1
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "HomeViewController.h"
#import "TestDemo1-Swift.h"

@interface HomeViewController ()<ChartViewDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    SceneFlowView *flowView = [[SceneFlowView alloc] init];
    [self.view addSubview:flowView];
    [flowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo(300*UIRate);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    SceneFlowVC *vc = [[SceneFlowVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end

