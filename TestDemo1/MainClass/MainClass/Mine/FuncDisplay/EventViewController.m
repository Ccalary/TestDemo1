//
//  EventViewController.m
//  TestDemo1
//
//  Created by caohouhong on 17/5/31.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "EventViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface EventViewController ()
@property (nonatomic, strong) UIView *roundView;
@property (nonatomic, strong) UILabel *stepLabel;
@property (nonatomic, assign) int num;
@property (nonatomic, strong) UIImageView *shotImageView;
@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenShot) name:UIApplicationUserDidTakeScreenshotNotification object:nil];

    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initView{
    _roundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _roundView.backgroundColor = [UIColor greenColor];
    _roundView.layer.cornerRadius = 50;
    [self.view addSubview:_roundView];
    
    _stepLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    _stepLabel.textAlignment = NSTextAlignmentCenter;
    _stepLabel.text = @"步数：0";
    [self.view addSubview:_stepLabel];
    
    _shotImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 80, 0, 80, 100)];
    _shotImageView.backgroundColor = [UIColor grayColor];
    _shotImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_shotImageView];
    
    /*为imageView添加边框和阴影，以突出显示*/
    //给imageView添加边框
    CALayer * layer = [_shotImageView layer];
    layer.borderColor = [[UIColor whiteColor] CGColor];
    layer.borderWidth = 5.0f;
    
    //添加四个边阴影
    _shotImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    _shotImageView.layer.shadowOffset = CGSizeMake(0, 0);
    _shotImageView.layer.shadowOpacity = 0.5;
    _shotImageView.layer.shadowRadius = 10.0;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [_roundView becomeFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_roundView resignFirstResponder];
}

#pragma mark - 视图控制器的触摸事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    DLog(@"touch begin");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //取得一个触摸对象（对于多点触摸可能有多个对象）
    UITouch *touch=[touches anyObject];
    //NSLog(@"%@",touch);
    
    //取得当前位置
    CGPoint current=[touch locationInView:self.view];
    //取得前一个位置
    CGPoint previous=[touch previousLocationInView:self.view];
    
    //移动前的中点位置
    CGPoint center=_roundView.center;
    //移动偏移量
    CGPoint offset=CGPointMake(current.x-previous.x, current.y-previous.y);
    
    //重新设置新位置
    _roundView.center=CGPointMake(center.x+offset.x, center.y+offset.y);
    
    NSLog(@"touch moving...");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    DLog(@"touch end");
}

#pragma mark - 运动事件
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
    
    if (motion == UIEventSubtypeMotionShake){ //摇晃事件
        _num++;
        _stepLabel.text = [NSString stringWithFormat:@"步数: %d",_num];
    }
    
   }

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    //摇晃结束后手机抖动
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

#pragma mark - 截屏
- (void)screenShot{
    NSLog(@"截屏了。。。");
    
    self.shotImageView.image = [self imageWithScreenshot];
    
}

- (UIImage *)imageWithScreenshot
{
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
        imageSize = [UIScreen mainScreen].bounds.size;
    else
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }
        else
        {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImagePNGRepresentation(image);
    return [UIImage imageWithData:imageData];
}


@end
