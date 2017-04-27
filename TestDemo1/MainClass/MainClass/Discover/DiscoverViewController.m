//
//  DiscoverViewController.m
//  TestDemo1
//
//  Created by caohouhong on 17/4/26.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "DiscoverViewController.h"

@interface DiscoverViewController ()
@property (nonatomic, strong) UILabel *countLabel;
@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUIStepperView];
    
    [self initToolBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UIStepper(增加，减少按钮)
- (void)initUIStepperView{
    
    UIStepper *step = [[UIStepper alloc] initWithFrame:CGRectMake(100, 10, 100, 50)];
    step.maximumValue = 100;
    step.minimumValue = 1;
    //步数
    step.stepValue = 1;
    //颜色
    step.tintColor = [UIColor grayColor];
    //自定义减号按钮的图片
    [step setDecrementImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    //自定义加号按钮的图片
    [step setIncrementImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [step addTarget:self action:@selector(stepAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:step];
    
    _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 10, 100, 30)];
    _countLabel.text = @"1";
    _countLabel.layer.cornerRadius = 4.0;
    _countLabel.layer.borderWidth = 1;
    _countLabel.font = FONT_SYSTEM(15*UIRate);
    _countLabel.textAlignment = NSTextAlignmentCenter;
    _countLabel.textColor = COLOR_LIGHT_GRAY;
    [self.view addSubview:_countLabel];
}

- (void)stepAction:(UIStepper *)step{
    DLog(@"%.0f",step.value);
    _countLabel.text = [NSString stringWithFormat:@"%.0f",step.value];
}

#pragma mark - UIToolBar
- (void)initToolBar{
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 50)];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"按钮1" style:UIBarButtonItemStylePlain target:self action:@selector(barItemAction)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"按钮2" style:UIBarButtonItemStylePlain target:self action:@selector(backItemAction)];
    toolBar.barTintColor = COLOR_Background;
    toolBar.tintColor = COLOR_BLACK;
    
    toolBar.items = @[barButtonItem, space, backButtonItem];
    
    [self.view addSubview:toolBar];
}

- (void)barItemAction{
    
}

- (void)backItemAction{
    
}

@end
