//
//  TakePhotoViewController.m
//  TestDemo1
//
//  Created by caohouhong on 2021/5/20.
//  Copyright © 2021 caohouhong. All rights reserved.
//

#import "TakePhotoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>
#import <Photos/PHPhotoLibrary.h>

@interface TakePhotoViewController ()<AVCaptureMetadataOutputObjectsDelegate,AVCapturePhotoCaptureDelegate>
//捕获设备，通常是前置摄像头，后置摄像头，麦克风（音频输入）
@property(nonatomic, strong) AVCaptureDevice *device;
//AVCaptureDeviceInput 代表输入设备，他使用AVCaptureDevice 来初始化
@property(nonatomic, strong) AVCaptureDeviceInput *input;
//当启动摄像头开始捕获输入
@property(nonatomic, strong) AVCaptureMetadataOutput *output;
@property (nonatomic, strong) AVCapturePhotoOutput *imageOutPut;
//session：由他把输入输出结合在一起，并开始启动捕获设备（摄像头）
@property(nonatomic, strong) AVCaptureSession *session;
//图像预览层，实时显示捕获的图像
@property(nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, strong) UIButton *takeButton, *flashButton, *libraryButton, *useButton;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *focusView, *resultHoldView;
@property (nonatomic, strong) UIImage *image;
@end

@implementation TakePhotoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.fd_interactivePopDisabled = YES;
    if ([self canUserCamear]) {
        [self customCamera];
        [self customUI];
    }
}
- (void)customUI{
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0.4];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(TabBarSafeBottomMargin + 100*UIRate);
    }];
    
    _takeButton = [[UIButton alloc] init];
    [_takeButton setImage:[UIImage imageNamed:@"photograph"] forState: UIControlStateNormal];
    [_takeButton addTarget:self action:@selector(shutterCamera) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_takeButton];
    [_takeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.width.height.mas_equalTo(60*UIRate);
        make.bottom.offset(-TabBarSafeBottomMargin-20*UIRate);
    }];
    
    _focusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    _focusView.layer.borderWidth = 1.0;
    _focusView.layer.borderColor =[UIColor greenColor].CGColor;
    _focusView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_focusView];
    _focusView.hidden = YES;
    
    UIButton *leftButton = [UIButton createBtnWithTitle:@"取消" color:[UIColor whiteColor] fontSize:15*UIRate];
    [leftButton addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.mas_equalTo(self.takeButton);
        make.width.mas_equalTo(80*UIRate);
        make.height.mas_equalTo(50*UIRate);
    }];
    
    _libraryButton = [UIButton createBtnWithTitle:@"" imageName:@"icon_library"];
    [_libraryButton addTarget:self action:@selector(libraryAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_libraryButton];
    [_libraryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(40*UIRate);
        make.right.offset(-10-20*UIRate);
        make.centerY.mas_equalTo(leftButton);
    }];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, TopFullHeight)];
    topView.backgroundColor = [UIColor colorWithHex:0x000000 alpha:0.4];
    [self.view addSubview:topView];
    
    UIButton *changeButton = [[UIButton alloc] init];
    [changeButton setImage:[UIImage imageNamed:@"icon_camera_turn"] forState:UIControlStateNormal];
    [changeButton addTarget:self action:@selector(changeCamera) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:changeButton];
    [changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(40);
        make.right.offset(-10);
        make.bottom.mas_equalTo(topView);
    }];
    
    _flashButton = [[UIButton alloc] init];
    [_flashButton setImage:[UIImage imageNamed:@"icon_flash_off"] forState:UIControlStateNormal];
    [_flashButton setImage:[UIImage imageNamed:@"icon_flash_on"] forState:UIControlStateSelected];
    [_flashButton addTarget:self action:@selector(FlashOn) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:_flashButton];
    [_flashButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.size.centerY.mas_equalTo(changeButton);
    }];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(focusGesture:)];
    [self.view addGestureRecognizer:tapGesture];
    
    _resultHoldView = [[UIView alloc] init];
    _resultHoldView.backgroundColor = [UIColor blackColor];
    _resultHoldView.hidden = YES;
    [self.view addSubview:_resultHoldView];
    [_resultHoldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    _imageView = [[UIImageView alloc] init];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.layer.masksToBounds = YES;
    [_resultHoldView addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(StatusBarHeight);
        make.bottom.offset(-TabBarSafeBottomMargin);
        make.left.right.mas_equalTo(self.resultHoldView);
    }];
    
    UIButton *cancelButton = [[UIButton alloc] init];
    [cancelButton setImage:[UIImage imageNamed:@"icon_cancel_48"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(retakeAction) forControlEvents:UIControlEventTouchUpInside];
    [_resultHoldView addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(30*UIRate);
        make.bottom.offset(-TabBarSafeBottomMargin - 50*UIRate);
        make.width.mas_equalTo(50*UIRate);
        make.height.mas_equalTo(50*UIRate);
    }];
    
    _useButton = [[UIButton alloc] init];
    [_useButton setImage:[UIImage imageNamed:@"icon_sure_48"] forState:UIControlStateNormal];
    [_useButton addTarget:self action:@selector(useAction) forControlEvents:UIControlEventTouchUpInside];
    [_resultHoldView addSubview:_useButton];
    [_useButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-30*UIRate);
        make.centerY.mas_equalTo(cancelButton);
        make.size.mas_equalTo(cancelButton);
    }];
}
- (void)customCamera{
    self.view.backgroundColor = [UIColor blackColor];
    //使用AVMediaTypeVideo 指明self.device代表视频，默认使用后置摄像头进行初始化
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //使用设备初始化输入
    self.input = [[AVCaptureDeviceInput alloc]initWithDevice:self.device error:nil];
    //生成输出对象
    self.output = [[AVCaptureMetadataOutput alloc]init];
    self.imageOutPut = [[AVCapturePhotoOutput alloc] init];
    //生成会话，用来结合输入输出
    self.session = [[AVCaptureSession alloc]init];
    // 不设置前后切换会自动适应
//    if ([self.session canSetSessionPreset:AVCaptureSessionPreset1920x1080]) {
//        self.session.sessionPreset = AVCaptureSessionPreset1920x1080;
//    }
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.imageOutPut]) {
        [self.session addOutput:self.imageOutPut];
    }
    //使用self.session，初始化预览层，self.session负责驱动input进行信息的采集，layer负责把图像渲染显示
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
//    self.previewLayer.frame = CGRectMake(0, TopFullHeight, ScreenWidth, ScreenHeight - TopFullHeight - TabBarSafeBottomMargin - 100*UIRate);
    self.previewLayer.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:self.previewLayer];
    
    //开始启动
    [self.session startRunning];
    if ([_device lockForConfiguration:nil]) {
        //自动白平衡
        if ([_device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
            [_device setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
        }
        [_device unlockForConfiguration];
    }
}
- (void)FlashOn{
    if ([_device lockForConfiguration:nil]) {
        _flashButton.selected = !_flashButton.selected;
        [_device unlockForConfiguration];
    }
}
- (void)changeCamera{
    if (![self.session isRunning])return;
    AVCaptureDeviceDiscoverySession *captureDeviceDiscoverySession = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInWideAngleCamera]
                                          mediaType:AVMediaTypeVideo
                                           position:AVCaptureDevicePositionUnspecified];
    NSArray *captureDevices = [captureDeviceDiscoverySession devices];
    NSUInteger cameraCount = [captureDevices count];
//    NSUInteger cameraCount = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
    
    if (cameraCount > 1) {
        NSError *error;
        CATransition *animation = [CATransition animation];
        animation.duration = .5f;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        
        animation.type = @"oglFlip";
        AVCaptureDevice *newCamera = nil;
        AVCaptureDeviceInput *newInput = nil;
        AVCaptureDevicePosition position = [[_input device] position];
        if (position == AVCaptureDevicePositionFront){
            newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
            animation.subtype = kCATransitionFromLeft;
        }else {
            newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
            animation.subtype = kCATransitionFromRight;
        }
        newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
        
        [self.previewLayer addAnimation:animation forKey:nil];
        if (newInput != nil) {
            [self.session beginConfiguration];
            //先移除原来的input
            [self.session removeInput:_input];
            if ([self.session canAddInput:newInput]) {
                [self.session addInput:newInput];
                self.input = newInput;
            }else {
                //如果不能加现在的input，就加原来的input
                [self.session addInput:self.input];
            }
            [self.session commitConfiguration];
        }else if (error) {
            NSLog(@"toggle carema failed, error = %@", error);
        }
    }
}
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position{
    AVCaptureDeviceDiscoverySession *captureDeviceDiscoverySession = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInWideAngleCamera]
                                          mediaType:AVMediaTypeVideo
                                           position:AVCaptureDevicePositionUnspecified];
    NSArray *devices = [captureDeviceDiscoverySession devices];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position ) return device;
    return nil;
}
- (void)focusGesture:(UITapGestureRecognizer*)gesture{
    CGPoint point = [gesture locationInView:gesture.view];
    [self focusAtPoint:point];
}
- (void)focusAtPoint:(CGPoint)point{
    CGSize size = self.view.bounds.size;
    CGPoint focusPoint = CGPointMake( point.y /size.height ,1-point.x/size.width );
    NSError *error;
    if ([self.device lockForConfiguration:&error]) {
        if ([self.device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
            [self.device setFocusPointOfInterest:focusPoint];
            [self.device setFocusMode:AVCaptureFocusModeAutoFocus];
        }
        if ([self.device isExposureModeSupported:AVCaptureExposureModeAutoExpose ]) {
            [self.device setExposurePointOfInterest:focusPoint];
            [self.device setExposureMode:AVCaptureExposureModeAutoExpose];
        }
        [self.device unlockForConfiguration];
        _focusView.center = point;
        _focusView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            _focusView.transform = CGAffineTransformMakeScale(1.25, 1.25);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                _focusView.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                _focusView.hidden = YES;
            }];
        }];
    }
}
#pragma mark - 拍摄照片
- (void)shutterCamera {
    // 这是输出流的设置参数AVVideoCodecJPEG参数表示以JPEG的图片格式输出图片
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecTypeJPEG,AVVideoCodecKey, nil];
    AVCapturePhotoSettings *setting = [AVCapturePhotoSettings
    photoSettingsWithFormat:outputSettings];
    if (_flashButton.selected) { // 闪光灯
        setting.flashMode =_flashButton.selected ? AVCaptureFlashModeOn : AVCaptureFlashModeOff;
    }
    // 设置闪光灯打开。注意，执行这句代码时闪光灯并不会打开，而是进行拍照时会自动打开，闪烁，然后关闭
//    setting.flashMode = AVCaptureFlashModeOn;
    // 拍照，照片在代理方法里获取
    [self.imageOutPut capturePhotoWithSettings:setting delegate:self];
}

#pragma mark AVCapturePhotoCaptureDelegate
- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(NSError *)error {
    if (error) {
        NSLog(@"获取图片错误 --- %@",error.localizedDescription);
    }
    if (photo) {
        CGImageRef cgImage = [photo CGImageRepresentation];
        UIImage *image = [UIImage imageWithCGImage:cgImage];
        //拍照会旋转180解决办法
        if (self.input.device.position == AVCaptureDevicePositionFront) {
            UIImageOrientation imgOrientation = UIImageOrientationLeftMirrored;
            image = [[UIImage alloc]initWithCGImage:cgImage scale:1.0f orientation:imgOrientation];
        }else {
            UIImageOrientation imgOrientation = UIImageOrientationRight;
            image = [[UIImage alloc]initWithCGImage:cgImage scale:1.0f orientation:imgOrientation];
        }
        self.image = image;
        [self.session stopRunning];
        self.imageView.image = _image;
        self.resultHoldView.hidden = NO;
        NSLog(@"image:%@",self.image);
    }
}

#pragma - 保存至相册
- (void)saveImageToPhotoAlbum:(UIImage*)savedImage {
    if (![self canUsePhotoLibrary]) return;
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
// 指定回调方法
- (void)image:(UIImage *)image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo {
    if(error != NULL){
        NSLog(@"保存图片失败");
    }else{
        NSLog(@"保存图片成功");
    }
}

- (void)retakeAction {
    self.resultHoldView.hidden = YES;
    [self.session startRunning];
}

-(void)cancle{
    if ([self.session isRunning]){
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self retakeAction];
    }
}

// 使用照片
- (void)useAction {
    NSLog(@"使用");
    [self saveImageToPhotoAlbum:self.image];
}

- (void)libraryAction {
    NSLog(@"打开相册");
}
#pragma mark - 检查相机权限
- (BOOL)canUserCamear{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请打开相机权限" message:@"请在设置-隐私-相机打开相机" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        UIAlertAction *queren = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *setingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:setingsURL options:@{} completionHandler:nil];
        }];
        [alert addAction:cancel];
        [alert addAction:queren];
        [self presentViewController:alert animated:YES completion:nil];
        return NO;
    }
    return YES;
}

// 相册权限
- (BOOL)canUsePhotoLibrary {
    //相册授权
    if ([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized){//用户之前已经授权
        //进行保存图片操作
        return YES;
    }else if([PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusDenied){//用户之前已经拒绝授权
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请打开相册权限" message:@"请在设置-隐私-相册允许访问相册" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        UIAlertAction *queren = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *setingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:setingsURL options:@{} completionHandler:nil];
        }];
        [alert addAction:cancel];
        [alert addAction:queren];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
        return NO;
    }else{//弹窗授权时监听
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized){//允许
               //进行保存图片操作
            }else{//拒绝
                
            }
        }];
    }
    return YES;
}
@end
