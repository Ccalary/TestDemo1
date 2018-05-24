//
//  MakeExpViewController.m
//  TestDemo1
//
//  Created by caohouhong on 17/5/26.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "MakeExpViewController.h"

@interface MakeExpViewController ()

@end

@implementation MakeExpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self throwException];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - 抛出异常
- (void)throwException{
    
    //异常的名称
    NSString *exceptionName = @"自定义异常";
    //异常的原因
    NSString *exceptionReason = @"我长得太帅了，所以程序崩溃了";
    //异常的信息
    NSDictionary *exceptionUserInfo = @{@"e_info":@"这是异常信息"};
    
    NSException *exception = [NSException exceptionWithName:exceptionName reason:exceptionReason userInfo:exceptionUserInfo];
    
    NSString *aboutMe = @"太帅了";
    
    if ([aboutMe isEqualToString:@"太帅了"]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"捕获异常,是否抛出？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *done = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //抛异常
            @throw exception;
        }];
        [alertController addAction:done];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

@end
