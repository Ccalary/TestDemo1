//
//  ShowHUDViewController.m
//  TestDemo1
//
//  Created by caohouhong on 17/5/26.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "ShowHUDViewController.h"

@interface ShowHUDViewController ()

@end

@implementation ShowHUDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showHUD];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - HUD
- (void)showHUD{
    [LCProgressHUD showLoading:@""];
    
    //延时
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LCProgressHUD hide];
    });
    
}

@end
