//
//  HomeViewController.m
//  TestDemo1
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "HomeViewController.h"
#import "FirstViewController.h"
#import "HHPopButton.h"
#import "UIView+MCTransition.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    [self initView];
}


- (void)initView{
    UIView *holdView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    holdView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:holdView];
    
    HHPopButton *nextMonthBtn = [[HHPopButton alloc] initWithFrame:CGRectMake(50, 150, 100, 50)];
    [nextMonthBtn setTitle:@"按钮" forState:UIControlStateNormal];
    [nextMonthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    nextMonthBtn.colicActionBlock = ^(){
        [self nextMonthBtnAction];
    };
    nextMonthBtn.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:nextMonthBtn];
}
- (void)nextMonthBtnAction{
    FirstViewController *viewVC = [[FirstViewController alloc] init];
    [self.navigationController pushViewController:viewVC animated:YES];
}

@end
