//
//  HomeViewController.m
//  TestDemo1
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "HomeViewController.h"
#import "FirstViewController.h"
#import "HHPopButton.h"
#import "UIView+MCTransition.h"
#import <AGGeometryKit/AGGeometryKit.h>

@interface HomeViewController ()
@property (nonatomic, strong) UIImageView *agImageView;
@property (nonatomic, strong) UIView *agHoldView;
@property (nonatomic, strong) UIView *snapView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initView];
}


- (void)initView{
    UIView *holdView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    holdView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:holdView];
    
    HHPopButton *nextMonthBtn = [[HHPopButton alloc] initWithFrame:CGRectMake(50, 150, 100, 50)];
    [nextMonthBtn setTitle:@"按钮" forState:UIControlStateNormal];
    [nextMonthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    nextMonthBtn.colicActionBlock = ^(){
        [self nextMonthBtnAction];
    };
    nextMonthBtn.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:nextMonthBtn];
    
    HHPopButton *screenBtn = [[HHPopButton alloc] initWithFrame:CGRectMake(180, 150, 100, 50)];
    [screenBtn setTitle:@"截图" forState:UIControlStateNormal];
    [screenBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    screenBtn.colicActionBlock = ^(){
        [self screenAction];
    };
    screenBtn.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:screenBtn];
    
//    for (int i = 0; i < 3; i++){
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 300+i*40, 250, 25)];
//        imageView.layer.borderWidth = 1;
//        imageView.layer.borderColor = [UIColor blackColor].CGColor;
//        [self.view addSubview:imageView];
//        UIImage *image = [UIImage imageNamed:@"line_25x250"];
//        imageView.image = [self image:image rotatedByDegrees:45*i];
//    }
    
    [self initAGKView];
}

- (void)initAGKView {
   
    _agHoldView = [[UIView alloc] initWithFrame:CGRectMake(150, 450, 100, 100)];
    _agHoldView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_agHoldView];
    
   UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)]; // create a view
    view.image = [UIImage imageNamed:@"img_190"];
   [self.agHoldView addSubview:view];
   [view.layer ensureAnchorPointIsSetToZero]; // set the anchor point to [0, 0] (this method keeps the same position)

    self.agImageView = view;
   AGKQuad quad = view.layer.quadrilateral;
   quad.br.x += 80; // shift bottom right x-value with 20 pixels
   quad.br.y += 80; // shift bottom right y-value with 50 pixels
   quad.tr.x += 100;
   quad.tr.y -= 30;
   quad.bl.y += 50;
    
   view.layer.quadrilateral = quad; // the quad is converted to CATransform3D and applied
}

- (void)nextMonthBtnAction{
//    FirstViewController *viewVC = [[FirstViewController alloc] init];
//    [self.navigationController pushViewController:viewVC animated:YES];
    
//    UIGraphicsBeginImageContextWithOptions(self.snapView.frame.size, NO, [[UIScreen mainScreen] scale]);
//         [self.snapView.layer renderInContext:UIGraphicsGetCurrentContext()]; // 此方法，除却iOS8以外其他系统都OK
////    [self.snapView drawViewHierarchyInRect:self.snapView.bounds afterScreenUpdates:YES];
//    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    NSLog(@"snapShot:%@", snapshot);
//
//    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 0, 100, 100)];
//    bgImageView.backgroundColor = [UIColor redColor];
//    bgImageView.image = snapshot;
//    [self.view addSubview:bgImageView];
    
    
//    [self withCoolImage:^(UIImage *image) {
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 0, 100, 100)];
        bgImageView.backgroundColor = [UIColor redColor];
    bgImageView.image = [self imageFromView:self.agHoldView];
        [self.view addSubview:bgImageView];
//    }];
}

- (void)withCoolImage:(void (^)(UIImage *))block {
    UIView *composite = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_190"]]; //This is a valid image - can be viewed when debugger stops here
    [composite addSubview:imgView];

    UIView *snapshotView = [composite snapshotViewAfterScreenUpdates:YES];

    // give it a chance to update the screen…
    dispatch_async(dispatch_get_main_queue(), ^
    {
        // … and now it'll be a valid snapshot in here
        if(block)
        {
            block([self imageFromView:composite]);
        }
    });
}

//针对有用过OpenGL渲染过的视图截图
- (UIImage *)imageFromView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0.0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return img;
}

- (void)screenAction {
    UIView *snapView = [self.agHoldView snapshotViewAfterScreenUpdates:YES];
    snapView.frame = CGRectMake(0, 0, 100, 100);
    [self.view addSubview:snapView];
    self.snapView = snapView;
}

- (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = - M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

/** 将图片旋转弧度radians */
- (UIImage *)image:(UIImage *)image rotatedByRadians:(CGFloat)radians
{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,image.size.width, image.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(radians);
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, radians);
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-image.size.width / 2, -image.size.height / 2, image.size.width, image.size.height), [image CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

/** 将图片旋转角度degrees */
- (UIImage *)image:(UIImage *)image rotatedByDegrees:(CGFloat)degrees
{
    return [self image:image rotatedByRadians:(M_PI * (degrees) / 180.0)];
}

@end
