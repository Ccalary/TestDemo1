//
//  IconfontViewController.m
//  TestDemo1
//
//  Created by chh on 2018/4/4.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "IconfontViewController.h"
#import "UIImage+IconFont.h"

@interface IconfontViewController ()

@end

@implementation IconfontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageWithIcon:@"\U0000e6b8" size:30*UIRate color:[UIColor purpleColor]];
    imageView.layer.borderWidth = 1;
    imageView.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.mas_equalTo(50*UIRate);
        make.centerX.equalTo(self.view);
        make.top.offset(20);
    }];
    
    UILabel *imageLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width-40, 50)];
    imageLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    imageLabel.font = [UIFont systemFontOfSize:15];
    imageLabel.textColor = [UIColor greenColor];
    imageLabel.text = @"你好\U0000e6ba，欢迎你";
    [self.view addSubview:imageLabel];
    
    NSString *result = @"我就是喜欢这个平台\U0000e6ba";
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:result];
    NSRange redRange = NSMakeRange([[attributeStr string] rangeOfString:@"\U0000e6ba"].location, [[attributeStr string] rangeOfString:@"\U0000e6ba"].length);
    
    [attributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRange];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"iconfont" size:30] range:redRange];
    imageLabel.attributedText = attributeStr;
    
    UIButton *imageBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 50)];
    [imageBtn setImage:[UIImage imageWithIcon:@"\U0000e705" size:30*UIRate color:[UIColor purpleColor]] forState:UIControlStateNormal];
    imageBtn.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:imageBtn];

    UIButton *textBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 270, 100, 50)];
    [textBtn setImage:[UIImage imageWithIcon:@"\U0000e705" size:30*UIRate color:[UIColor blueColor]] forState:UIControlStateNormal];
    [textBtn setTitle:@"按钮" forState:UIControlStateNormal];
    textBtn.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:textBtn];
}

@end
