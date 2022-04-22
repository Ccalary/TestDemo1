//
//  AutoLayoutVC.m
//  TestDemo1
//
//  Created by caohouhong on 2022/4/21.
//  Copyright © 2022 caohouhong. All rights reserved.
//  使用Masonry实现两个label内容单行显示过长，省略号显示——两个label的挤压缩关系
//  简书文章： https://www.jianshu.com/p/63e9765feb3f

#import "AutoLayoutVC.h"

@interface AutoLayoutVC ()

@end

@implementation AutoLayoutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"label布局";
    
    [self initContentHugging];
    [self initContentCompression];
}

- (void)initContentHugging{
    UILabel *leftLabel = [[UILabel alloc] init];
    leftLabel.backgroundColor = [UIColor redColor];
    leftLabel.text = @"左侧文字";
    leftLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:leftLabel];
    
    UILabel *rightLabel = [[UILabel alloc] init];
    rightLabel.backgroundColor = [UIColor blueColor];
    rightLabel.text = @"右侧文字";
    rightLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:rightLabel];
    
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(50);
    }];
    
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftLabel.mas_right).offset(10);
        make.right.offset(-10);
        make.centerY.mas_equalTo(leftLabel);
    }];
    
    //setContentCompressionResistancePriority(抗压缩)，这个值越低，就会在宽度不够的情况下，被压缩，默认是750，若是多个视图是默认值，会被系统认为更早被addSubview的视图该值更小！
    
    //setContentHuggingPriority(抗拉伸)，这个值越低，就会在宽度多余的情况下，被拉伸，默认250，若是多个视图是默认值，会被系统认为更早被addSubview的值更小！
    [leftLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [rightLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)initContentCompression {
    UILabel *leftLabel = [[UILabel alloc] init];
    leftLabel.backgroundColor = [UIColor redColor];
    leftLabel.text = @"左侧文字一二三四五六七八九十"; // 一二三四五六七八九十
    leftLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:leftLabel];
    
    UILabel *rightLabel = [[UILabel alloc] init];
    rightLabel.backgroundColor = [UIColor blueColor];
    rightLabel.text = @"右侧文字一二三四五六七八九十";// 一二三四五六七八九十
    rightLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:rightLabel];
    
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.top.offset(150);
    }];
    
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftLabel.mas_right).offset(10);
        make.right.offset(-10);
        make.centerY.mas_equalTo(leftLabel);
        make.width.mas_lessThanOrEqualTo(@(150));
    }];
    
    //setContentCompressionResistancePriority(抗压缩)，这个值越低，就会在宽度不够的情况下，被压缩，默认是750，若是多个视图是默认值，会被系统认为更早被addSubview的视图该值更小！

    
    //setContentHuggingPriority(抗拉伸)，这个值越低，就会在宽度多余的情况下，被拉伸，默认250，若是多个视图是默认值，会被系统认为更早被addSubview的值更小！
    
    [leftLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [rightLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}
@end
