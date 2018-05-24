//
//  ExceptionViewController.m
//  TestDemo1
//
//  Created by caohouhong on 17/5/26.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "ExceptionViewController.h"

@interface ExceptionViewController ()

@end

@implementation ExceptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self catchTheCrash];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - 异常捕获 只能捕获部分能检测到的异常，很多异常是捕获不到的
- (void)catchTheCrash{
    
    @try {
        NSMutableArray *array = [NSMutableArray array];
        NSString *str = nil;
        [array addObject:str];
        
        NSLog(@"走不到这里了");
        
    } @catch (NSException *exception) {
        
        //        @throw exception;
        
        NSLog(@"数组越界拉");
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"捕获异常" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *done = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:done];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    } @finally {
        
        DLog(@"捕获结束");
    }
}

@end
