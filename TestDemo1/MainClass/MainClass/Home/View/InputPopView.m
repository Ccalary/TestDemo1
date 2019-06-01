//
//  InputPopView.m
//  TestDemo1
//
//  Created by caohouhong on 2018/12/26.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "InputPopView.h"

@implementation InputPopView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){
        [self initView];
    }
    return self;
}

- (void)initView {
    self.backgroundColor = [UIColor whiteColor];
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(50, 150, 100, 50)];
    textField.placeholder = @"请输入内容";
    textField.layer.borderWidth = 1;
    textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:textField];
    
    UITextField *textField1 = [[UITextField alloc] initWithFrame:CGRectMake(50, 250, 100, 50)];
    textField1.placeholder = @"请输入内容";
    textField1.layer.borderWidth = 1;
    textField1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:textField1];
    
    
    UITextField *textField2 = [[UITextField alloc] initWithFrame:CGRectMake(50, 350, 100, 50)];
    textField2.placeholder = @"请输入内容";
    textField2.layer.borderWidth = 1;
    textField2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:textField2];
    
    UITextField *textField3 = [[UITextField alloc] initWithFrame:CGRectMake(50, 450, 100, 50)];
    textField3.placeholder = @"请输入内容";
    textField3.layer.borderWidth = 1;
    textField3.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:textField3];
    
    UITextField *textField4 = [[UITextField alloc] initWithFrame:CGRectMake(50, 50, 100, 50)];
    textField4.placeholder = @"请输入内容";
    textField4.layer.borderWidth = 1;
    textField4.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:textField4];
    
    UITextField *textField5 = [[UITextField alloc] initWithFrame:CGRectMake(50, 550, 100, 50)];
    textField5.placeholder = @"请输入内容";
    textField5.layer.borderWidth = 1;
    textField5.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:textField5];
    
    UITextField *textField6 = [[UITextField alloc] initWithFrame:CGRectMake(50, 10, 100, 50)];
    textField6.placeholder = @"请输入内容";
    textField6.layer.borderWidth = 1;
    textField6.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:textField6];
}
@end
