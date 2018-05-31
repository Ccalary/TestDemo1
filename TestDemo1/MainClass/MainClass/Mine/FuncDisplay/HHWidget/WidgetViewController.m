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
#import "MCRuleView.h"

@interface WidgetViewController ()<SendCodeButtonDelegate, UITextFieldDelegate>
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) MCRuleView *ruleView;
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
    
    [self initSendCode];
    [self initRuleView];
}

#pragma mark - 标尺
- (void)initRuleView {
    __weak typeof (self) weakSelf = self;
    _ruleView = [[MCRuleView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 40) scrollBlock:^(float x) {
        weakSelf.textField.text = [NSString stringWithFormat:@"%.0f",x];
    }];
    [self.view addSubview:_ruleView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.0, 95, 1, 25)];
    lineView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:lineView];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2.0 - 50, 60, 100, 20)];
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    _textField.delegate = self;
    [_textField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_textField];
}

- (void)textFieldChanged:(UITextField *)textField {
    NSLog(@"输入内容:%@",textField.text);
    
    double num = [textField.text doubleValue];
    NSLog(@"输入内容转化为数字:%f",num);
    
    [_ruleView changePositonWithNum:num];
}


//限制7位和对删除字符的判断
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@""] && range.length > 0) {//输入删除字符
        return YES;
    }
    if (textField.text.length >= 7) {
        return NO;
    }
    return YES;
}

#pragma mark 倒计时
- (void)initSendCode {
    SendCodeButton *codeButton = [[SendCodeButton alloc] initWithFrame:CGRectMake(10, 30, 100, 40) title:@"倒计时" seconds:60];
    codeButton.center = self.view.center;
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
