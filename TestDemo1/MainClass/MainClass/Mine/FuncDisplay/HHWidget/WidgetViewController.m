//
//  WidgetViewController.m
//  TestDemo1
//
//  Created by chh on 2017/11/21.
//  Copyright © 2017年 caohouhong. All rights reserved.
//  小控件展示

#import "WidgetViewController.h"
#import "HHPopSelectView.h"
#import "SendCodeButton.h"
#import "HHAlertController.h"

@interface WidgetViewController ()<SendCodeButtonDelegate>

@end

@implementation WidgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)initView{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"小控件";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜单" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    
    SendCodeButton *codeButton = [[SendCodeButton alloc] initWithFrame:CGRectMake(10, 30, 100, 40) title:@"倒计时" seconds:60];
    codeButton.delegate = self;
    [self.view addSubview:codeButton];
}

- (void)sendCodeButtonClick{
    HHAlertController *alert = [HHAlertController alertWithTitle:@"客服电话"
                                                         message:@"0510-10086"
                                                 sureButtonTitle:@"呼叫"
                                               cancelButtonTitle:@"取消"
                                                      sureHandel:nil
                                                    cancelHandel:nil];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)rightBarAction{
   HHPopSelectView *popSelectView = [[HHPopSelectView alloc] initWithOrigin:CGPointMake(ScreenWidth - 30, TopFullHeight) andCustomView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 200)]];
    [popSelectView popView];
}
@end
