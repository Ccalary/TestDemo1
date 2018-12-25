//
//  BezierPathVC.m
//  TestDemo1
//
//  Created by caohouhong on 17/6/8.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "BezierPathVC.h"
#import "BezierPathViewBase.h"
#import "BezierPathViewSquare.h"
#import "BezierPathViewRound.h"
#import "BezierPathQuadCurve.h"

@interface BezierPathVC ()
@property (nonatomic, strong) BezierPathViewBase *baseView;
@property (nonatomic, strong) BezierPathViewSquare *squareView;
@property (nonatomic, strong) BezierPathViewRound *roundView;
@property (nonatomic, strong) BezierPathQuadCurve *quadCurveView;

@property (nonatomic, strong) UIImageView *wipeImageView; // 擦除
@property (nonatomic, assign) CGPoint startPoint; // 开始的点
@property (nonatomic, strong) UIImageView *rectImageView;
@property (nonatomic, strong) UIImageView *customerImageView;
@end

@implementation BezierPathVC


- (void)loadView{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _baseView = [BezierPathViewBase addViewTo:self.view];
    _squareView = [BezierPathViewSquare addViewTo:self.view];
    _roundView = [BezierPathViewRound addViewTo:self.view];
    _quadCurveView = [BezierPathQuadCurve addViewTo:self.view];
    
    self.rectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    
    [self initGraphicsView];
    
}

- (void)initGraphicsView {
    UIView *gView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, ScreenWidth, ScreenHeight - 200)];
    gView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [self.view addSubview:gView];
    
    CGFloat imageWidth = ScreenWidth/3.0;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageWidth, imageWidth)];
    imageView.image = [self getGraphicsImage];
    [gView addSubview:imageView];
    
    UIImageView *waterImageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageWidth, 0, imageWidth, imageWidth)];
    waterImageView.image = [self waterImageToAnotherImage];
    [gView addSubview:waterImageView];
    
    UIImageView *circleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageWidth*2, 0, imageWidth, imageWidth)];
    circleImageView.image = [self clipCircleImageWithImage];
    [gView addSubview:circleImageView];
    
    UIImageView *borderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, imageWidth, imageWidth, imageWidth)];
    borderImageView.image = [self clipBorderCircleImage];
    [gView addSubview:borderImageView];
    
    UIImageView *screenImageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageWidth, imageWidth, imageWidth, imageWidth)];
    screenImageView.contentMode = UIViewContentModeScaleAspectFit;
    screenImageView.image = [self screenShoot];
    [gView addSubview:screenImageView];
    
    _wipeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(imageWidth*2, imageWidth, imageWidth, imageWidth)];
    _wipeImageView.userInteractionEnabled = YES;
    _wipeImageView.image = [UIImage imageNamed:@"img_160"];
    [gView addSubview:_wipeImageView];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(wipePanGesture:)];
    [self.wipeImageView addGestureRecognizer:panGesture];
    
    _customerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, imageWidth*2, imageWidth, imageWidth)];
    [gView addSubview:_customerImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// 1、图形上下文
- (UIImage *)getGraphicsImage {
    // 1、获取图片
    UIImage *image = [UIImage imageNamed:@"img_160"];
    // 2、开启上下文
    UIGraphicsBeginImageContext(image.size);
    // 3、绘制到图形上下文中
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    // 4.从上下文中获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 5.关闭图形上下文
    UIGraphicsEndImageContext();
    return newImage;
}

// 2、给图片添加文字水印
- (UIImage *)waterImageToAnotherImage {
    // 1、获取图片
    UIImage *image = [UIImage imageNamed:@"img_190"];
    // 2、开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 1);
    // 3、绘制图片
    [image drawInRect:CGRectMake(0, 0, image.size.width/2.0, image.size.height/2.0)];
    // 4、添加水印文字
    [@"logo" drawAtPoint:CGPointMake(10, 10) withAttributes:@{NSBackgroundColorAttributeName: [UIColor redColor], NSFontAttributeName:[UIFont systemFontOfSize:30]}];
    // 图片水印
//    UIImage *waterImg = [UIImage imageNamed:@"icon_xin_s"];
//    [waterImg drawInRect:CGRectMake(0, 0, 10, 10)];
    // 5、获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 6、关闭上下文
    UIGraphicsEndImageContext();
    return newImage;
}

// 3、裁剪圆形图片
- (UIImage *)clipCircleImageWithImage {
    // 1、获取图片
    UIImage *image = [UIImage imageNamed:@"img_190"];
    NSData *data = UIImageJPEGRepresentation(image, 1);
    NSLog(@"原始大小：%lu",(unsigned long)data.length);
    // 2、开启上下文 size, 是否透明， 缩放比例 如果是0 表示原始尺寸， [UIScreen mainScreen].scale 就是为0时当前的缩放比例，8上是2 8P是3
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 1);
    // 3、设置裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0,image.size.width, image.size.height)];
    [path addClip];
    // 4、绘制图片
    [image drawAtPoint:CGPointZero];
    // 5、获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    NSData *newData = UIImageJPEGRepresentation(newImage, 1);
    NSLog(@"更改后JPEG大小：%lu",(unsigned long)newData.length);
    NSData *newPng = UIImagePNGRepresentation(newImage);
    NSLog(@"更改后PNG大小：%lu",(unsigned long)newPng.length);
    // 6、关闭绘制
    UIGraphicsEndImageContext();
    return newImage;
}

// 4、裁剪带边框的圆形图片
- (UIImage *)clipBorderCircleImage {
    // 1、获取图片
    UIImage *image = [UIImage imageNamed:@"img_160"];
    // 2、开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    // 3、绘制边框
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, image.size.width - 20, image.size.height - 20)];
    borderPath.lineWidth = 6.0;
    [[UIColor redColor] set]; // 设置边框颜色
    [borderPath stroke];
    [borderPath addClip]; // 裁剪
    // 4、绘制图片
    [image drawInRect:CGRectMake(10, 10, image.size.width - 20, image.size.height - 20)];
    // 5、获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

// 5、截屏
- (UIImage *)screenShoot {
    // 1、开启上下文
    UIGraphicsBeginImageContext(self.view.frame.size);
    // 2、获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 3、截屏
    [self.view.layer renderInContext:ctx];
    // 4、获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 5、关闭上下文
    UIGraphicsEndImageContext();
    return newImage;
}

// 6、擦除
- (void)wipePanGesture:(UIPanGestureRecognizer *)panGesture {
    //1、计算位置
    CGPoint nowPoint = [panGesture locationInView:self.wipeImageView];
    CGFloat offsetX = nowPoint.x - 10;
    CGFloat offsetY = nowPoint.y - 10;
    CGRect clipRect = CGRectMake(offsetX, offsetY, 20, 20);
    //2、开启上下文
    UIGraphicsBeginImageContextWithOptions(self.wipeImageView.frame.size, NO, 0);
    //3、获取当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //4、把图片绘制上去
    [self.wipeImageView.layer renderInContext:ctx];
    //5、把这一块设置为透明
    CGContextClearRect(ctx, clipRect);
    //6、获取新的图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //7、关闭上下文
    UIGraphicsEndImageContext();
    //8、重新赋值图片
    self.wipeImageView.image = newImage;
}

// 选择特定的框
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    self.startPoint = [touch locationInView:self.view];
    [self.view addSubview:self.rectImageView];
   
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    CGPoint nowPoint = [touch locationInView:self.view];

    UIGraphicsBeginImageContextWithOptions(self.rectImageView.bounds.size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.startPoint];
    [path addLineToPoint:CGPointMake(self.startPoint.x, nowPoint.y)];
    [path addLineToPoint:nowPoint];
    [path addLineToPoint:CGPointMake(nowPoint.x, self.startPoint.y)];
    [path closePath];
    
    path.lineWidth = 2.0;
    [[UIColor redColor] set];
    [path stroke];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.rectImageView.image = newImage;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.rectImageView.image = nil;
    [self.rectImageView removeFromSuperview];
    
    UITouch *touch = touches.anyObject;
    CGPoint endPoint = [touch locationInView:self.view];
    // 偏移量
    CGFloat offsetX = endPoint.x - self.startPoint.x;
    CGFloat offsetY = endPoint.y - self.startPoint.y;
    
    CGFloat originalX = (offsetX > 0) ? self.startPoint.x : endPoint.x;
    CGFloat originalY = (offsetY > 0) ? self.startPoint.y : endPoint.y;
    
    CGRect frame = CGRectMake(originalX, originalY, fabs(offsetX), fabs(offsetY));
    // 1、开启上下文
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, 0);
    // 2、获取当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 3、添加裁剪区域
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:frame];
    [path addClip];
    // 4、渲染
    [self.view.layer renderInContext:ctx];
    // 第一次裁剪后得到的图片是一张在整个View上的图片，要想得到单独的图片还需进行二次裁剪
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
   
    
    /***二次裁剪****/
    // 开启上下文，这个时候的大小就是我们最终要显示图片的大小
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0);
    // 将图片位置向左上移动
    [newImage drawAtPoint:CGPointMake(-frame.origin.x, -frame.origin.y)];
    UIImage *fImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.customerImageView.image = fImage;
}
@end
