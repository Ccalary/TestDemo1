//
//  DiscoverViewController.m
//  TestDemo1
//
//  Created by caohouhong on 17/4/26.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "DiscoverViewController.h"
#import "Draw2DView.h"
#import "UICountingLabel.h"
#import "HHCountingLabel.h"

@interface DiscoverViewController ()
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UIImageView *gifImageView;
@property (nonatomic, strong) HHCountingLabel *countingLabel;
@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUIStepperView];
    
    [self initToolBar];
    
    [self initGifImageView];
    
    [self init2DView];
    
    [self initCountingLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UIStepper(增加，减少按钮)
- (void)initUIStepperView{
    
    UIStepper *step = [[UIStepper alloc] initWithFrame:CGRectMake(100, 10, 100, 50)];
    step.maximumValue = 100;
    step.minimumValue = 1;
    //步数
    step.stepValue = 1;
    //颜色
    step.tintColor = [UIColor grayColor];
    //自定义减号按钮的图片
    [step setDecrementImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    //自定义加号按钮的图片
    [step setIncrementImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [step addTarget:self action:@selector(stepAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:step];
    
    _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 10, 100, 30)];
    _countLabel.text = @"1";
    _countLabel.layer.cornerRadius = 4.0;
    _countLabel.layer.borderWidth = 1;
    _countLabel.font = FONT_SYSTEM(15*UIRate);
    _countLabel.textAlignment = NSTextAlignmentCenter;
    _countLabel.textColor = COLOR_LIGHT_GRAY;
    [self.view addSubview:_countLabel];
}

- (void)stepAction:(UIStepper *)step{
    DLog(@"%.0f",step.value);
    _countLabel.text = [NSString stringWithFormat:@"%.0f",step.value];
}

#pragma mark - UIToolBar
- (void)initToolBar{
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 50)];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"开始" style:UIBarButtonItemStylePlain target:self action:@selector(barItemAction)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"结束" style:UIBarButtonItemStylePlain target:self action:@selector(backItemAction)];
    toolBar.barTintColor = COLOR_Background;
    toolBar.tintColor = COLOR_BLACK;
    
    toolBar.items = @[barButtonItem, space, backButtonItem];
    
    [self.view addSubview:toolBar];
}

- (void)barItemAction{
    [_gifImageView startAnimating];
    
    [_countingLabel countFrom:0 toValue:100 withDuration:10];
}

- (void)backItemAction{
    [_gifImageView stopAnimating];
    
}

#pragma mark - GifImageView(UIImageView 动画)
- (void)initGifImageView{
    
     _gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - 30*UIRate)/2.0, 110, 30*UIRate, 30*UIRate)];
    
    NSMutableArray *imageArray = [[NSMutableArray alloc] init];
    for(int i = 1; i < 60 ; i ++){
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%i",i]];
        [imageArray addObject:image];
    }
    _gifImageView.image = [UIImage imageNamed:@"dropdown_loading_01"];
//    _gifImageView.animationImages = imageArray;
    //这个代码会自动识别这个名字dropdown_anim__000开头的图片，然后按顺序展示他们，实现动画效果
    _gifImageView.image = [UIImage animatedImageNamed:@"dropdown_anim__000" duration:10];
    //    _gifImageView.animationImages = imageArray;
    [self.view addSubview:_gifImageView];
}

- (void)initCountingLabel{
    
//    _countingLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(0, 150, 100, 20)];
//    _countingLabel.format = @"%d";
//    _countLabel.text = @"0";
//    [_countingLabel countFrom:0 to:10000 withDuration:10];
//    [self.view addSubview:_countingLabel];
    
    
    _countingLabel = [[HHCountingLabel alloc] initWithFrame:CGRectMake(0, 150, 100, 20)];
    _countLabel.text = @"0";
    [_countingLabel countFrom:0 toValue:100 withDuration:10];
    [self.view addSubview:_countingLabel];
}

#pragma mark - Quartz 2D 绘图
- (void)init2DView{
    Draw2DView *drawView = [[Draw2DView alloc] initWithFrame:CGRectMake(0, 200, ScreenWidth, 100)];
    drawView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:drawView];
}

@end
