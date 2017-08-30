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
#import "HHPopButton.h"
#import <pop/POP.h>
#import "CountdownLabel.h"
#import <AudioToolbox/AudioToolbox.h>
#import "NSObject+Common.h"
#import "DisTestViewController.h"

@interface DiscoverViewController ()
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UIImageView *gifImageView;
@property (nonatomic, strong) HHCountingLabel *countingLabel;
@property (nonatomic, strong) CountdownLabel *countdownLabel;
@property (nonatomic)CALayer *myCriLayer;
@property (nonatomic) BOOL animated;
@property (nonatomic, assign) CGFloat offsetX;
@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUIStepperView];
    
    [self initCountDownView];
    
    [self initShake];
    
    [self initToolBar];
    
    [self initGifImageView];
    
    [self init2DView];
    
    [self initCountingLabel];
    
    [self initCountdownLabel];
    
    [self initMoveView];
    
    [self initPopButton];
    
    [self partRunLabel];
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

#pragma mark - 倒计时
- (void)initCountDownView{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, ScreenWidth, 30)];
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"countdown" initializer:^(POPMutableAnimatableProperty *prop) {
        //修改后的值
        prop.writeBlock = ^(id obj, const CGFloat values[]) {
//            label.text = [NSString stringWithFormat:@"%02d:%02d:%02d",(int)values[0]/60,(int)values[0]%60,(int)(values[0]*100)%100];
            UILabel *lb = (UILabel *)obj;
            lb.text = [NSString stringWithFormat:@"跳过%d", (int)values[0]];
            lb.font = [UIFont systemFontOfSize:5*(int)values[0]];
        };
        

        prop.readBlock = ^(id obj, CGFloat value[]){
            DLog(@"readBlock%f",value[0]);
        };
        
        prop.threshold = 1.0f;
    }];
    
    POPBasicAnimation *anBasic = [POPBasicAnimation linearAnimation];   //秒表当然必须是线性的时间函数
    anBasic.property = prop;    //自定义属性
    anBasic.fromValue = @(5);   //开始
    anBasic.toValue = @(0);  //结束
    anBasic.duration = 5;    //持续时间
    anBasic.repeatForever = YES;
//    anBasic.repeatCount = 10; //重复次数
    anBasic.beginTime = CACurrentMediaTime() + 1.0f;    //延迟1秒开始
    [label pop_addAnimation:anBasic forKey:@"countdown"];
}

//倒计时动画
- (void)initCountdownLabel{
    _countdownLabel = [[CountdownLabel alloc] initWithFrame:CGRectMake(0, 350, ScreenWidth, 30)];
    _countdownLabel.textAlignment = NSTextAlignmentCenter;
    _countdownLabel.textColor = [UIColor blackColor];
    _countdownLabel.font = FONT_SYSTEM_BOLD(25);
    [self.view addSubview:_countdownLabel];
    
    //开始倒计时
    [_countdownLabel startCount];
}

#pragma mark - Shake动画
- (void)initShake{
    //8:初始化一个CALayer层
    if (self.myCriLayer==nil) {
        self.myCriLayer=[CALayer layer];
        [self.myCriLayer pop_removeAllAnimations];
        self.myCriLayer.opacity = 1.0;
        self.myCriLayer.transform = CATransform3DIdentity;
        [self.myCriLayer setMasksToBounds:YES];
        [self.myCriLayer setBackgroundColor:[UIColor colorWithRed:0.16 green:0.72 blue:1 alpha:1].CGColor];
        [self.myCriLayer setCornerRadius:15.0f];
        [self.myCriLayer setBounds:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)];
        self.myCriLayer.position = CGPointMake(50, 50);
        [self.view.layer addSublayer:self.myCriLayer];
    }
    
    //增加一个动画 类似心跳的效果
    [self performAnimation];
}

-(void)performAnimation
{
    [self.myCriLayer pop_removeAllAnimations];
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    
    if (self.animated) {
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
    }else{
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(2.0, 2.0)];
    }
    
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];  //不同的类型 心跳会不一样
    
    self.animated = !self.animated; //使每次都有区别
    
    anim.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        if (finished) {
            
            [self performAnimation];  //当动画结束后又递归调用，让它产生一种心跳的效果
        }
    };
    
    [self.myCriLayer pop_addAnimation:anim forKey:@"Animation"];
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
    
    [self performAnimation];
}

- (void)backItemAction{
    [_gifImageView stopAnimating];
    
    //移除心跳动画
    [self.myCriLayer pop_removeAllAnimations];
    
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

#pragma mark - 滚动数字
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

#pragma mark - 跑马灯
- (void)initMoveView{
    CADisplayLink *timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayAction)];
    timer.frameInterval = 2.0;
    [timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)displayAction{
//    
//    if (self.offsetX < -100){
//        self.offsetX = ScreenWidth;
//    }
//    self.offsetX -= 1.0;
//    _countingLabel.frame = CGRectMake(self.offsetX, 150, 100, 20);
}

#pragma mark - Quartz 2D 绘图
- (void)init2DView{
    Draw2DView *drawView = [[Draw2DView alloc] initWithFrame:CGRectMake(0, 200, ScreenWidth, 50)];
    drawView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:drawView];
}

- (void)initPopButton{
    
    HHPopButton *button = [[HHPopButton alloc] initWithFrame:CGRectMake((ScreenWidth - 254*UIRate)/2, 260, 254*UIRate, 44*UIRate)];
    
    [button setTitle:@"播放声音" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"button_254x44"] forState:UIControlStateNormal];
    __weak typeof (self) weakSelf = self;
    button.colicActionBlock = ^(){
        [LCProgressHUD showMessage:@"点击了按钮（回调结果）"];
        AudioServicesPlaySystemSound(1000);
        
        [weakSelf.navigationController pushViewController:[[DisTestViewController alloc] init] animated:YES];
        
    };
    //可以正常使用
//    [button addTarget:self action:@selector(buttonaction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)buttonaction{
     [LCProgressHUD showMessage:@"点击了按钮（正常）"];
}

#pragma mark - 局部跑马灯
- (void)partRunLabel{
    UIView *holdView = [[UIView alloc] initWithFrame:CGRectMake(10, 310, 100, 50)];
    holdView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:holdView];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 90, 40)];
    textLabel.textColor = [UIColor redColor];
    textLabel.backgroundColor = [UIColor greenColor];
    textLabel.text = @"这是一个跑马灯效果啊1234567890";
    textLabel.tag = 10000;
    
    [holdView addSubview:textLabel];
    [textLabel sizeToFit];
    holdView.clipsToBounds = YES;
     _offsetX = textLabel.frame.origin.x;
    CADisplayLink *timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLabelAction)];
    timer.frameInterval = 2.0;
    [timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)displayLabelAction{
    UILabel *label =(UILabel *)[self.view viewWithTag:10000];
   
    CGRect rect = label.frame;
    _offsetX -= 0.5;
    rect.origin.x = _offsetX;
    label.frame = rect;
    if (_offsetX < -90){
        _offsetX = 100;
    }
}

@end
