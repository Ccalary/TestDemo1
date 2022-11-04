//
//  TestViewController.m
//  TestDemo1
//
//  Created by caohouhong on 2022/9/27.
//  Copyright © 2022 caohouhong. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    self.navigationItem.title = @"Test";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton createBtnWithTitle:@"执行" color:[UIColor fontColorBlue] fontSize:15];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(45);
        make.centerX.mas_equalTo(self.view);
    }];
}

- (void)buttonAction {
    NSLog(@"---主线程---%@", [NSThread mainThread]);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        while (true) {
            [self uploadData];
            [NSThread sleepForTimeInterval:10];
        }
    });
}

- (void)uploadData {
    NSLog(@"上传数据。。。");
    [self requestData:^(id response) {
        NSLog(@"结果：%@----%@", response, [NSThread currentThread]);
    }];
}

- (void)requestData:(void(^)(id response))success {
    [NSThread sleepForTimeInterval:0.5];
    if (success) {
        success(@"success");
    }
}
@end
