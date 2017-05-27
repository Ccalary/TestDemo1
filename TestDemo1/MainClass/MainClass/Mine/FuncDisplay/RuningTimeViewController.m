//
//  RuningTimeViewController.m
//  TestDemo1
//
//  Created by caohouhong on 17/5/26.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "RuningTimeViewController.h"

@interface RuningTimeViewController ()

@end

@implementation RuningTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showRunningTime];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - runningTime
- (void)showRunningTime{
    
    id obj = self;
    if ([obj respondsToSelector:@selector(nextMonthBtnAction)]){
        
    }
    
    if ([obj isKindOfClass:[NSArray class]]){
        
    }
    
    NSArray *array = @[@"1",@"2"];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSLog(@"--%@--",obj);
        
    }];
}

- (void)nextMonthBtnAction{
    NSLog(@"runtime开始了");
}


@end
