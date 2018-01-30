//
//  DisTestViewController.m
//  TestDemo1
//
//  Created by chh on 2017/8/30.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "DisTestViewController.h"
#import "RunLabelView.h"
#import "HHPopButton.h"
@interface DisTestViewController ()

@end

@implementation DisTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"发现测试";
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)dealloc{
    DLog(@"DisTestViewController 释放了");
}

- (void)initView{
    RunLabelView *runLabel = [[RunLabelView alloc] initWithFrame:CGRectMake(10, 50, 100, 50)];
    runLabel.backgroundColor = [UIColor grayColor];
    runLabel.textColor = [UIColor redColor];
    runLabel.text = @"这是一个可以移动的label，你看看就知道了";
    [self.view addSubview:runLabel];
    
    HHPopButton *nextMonthBtn = [[HHPopButton alloc] initWithFrame:CGRectMake(50, 150, 100, 50)];
    [nextMonthBtn setTitle:@"按钮" forState:UIControlStateNormal];
    [nextMonthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    nextMonthBtn.colicActionBlock = ^(){
        [self.navigationController popViewControllerAnimated:YES];
    };
    nextMonthBtn.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:nextMonthBtn];
}

@end
