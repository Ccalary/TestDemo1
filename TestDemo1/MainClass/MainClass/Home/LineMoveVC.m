//
//  LineMoveVC.m
//  TestDemo1
//
//  Created by chh on 2017/7/27.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "LineMoveVC.h"

@interface LineMoveVC ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *mScrollView;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation LineMoveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initView{

    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth/2.0 - 100, 50, 100, 40)];
    button1.backgroundColor = [UIColor yellowColor];
    [button1 setTitle:@"关注" forState:UIControlStateNormal];
    [self.view addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth/2.0, 50, 100, 40)];
    button2.backgroundColor = [UIColor grayColor];
    [button2 setTitle:@"热门" forState:UIControlStateNormal];
    [self.view addSubview:button2];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth/2.0 - 75, 88, 50, 2)];
    _lineView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_lineView];
    
    _mScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 90, ScreenWidth, 200)];
    _mScrollView.delegate = self;
    _mScrollView.backgroundColor = [UIColor blueColor];
    _mScrollView.pagingEnabled = YES;
    _mScrollView.contentSize = CGSizeMake(ScreenWidth * 2, 200);
    [self.view addSubview:_mScrollView];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat scale = offsetX/ScreenWidth;
    
    if (offsetX < ScreenWidth/2.0){
        _lineView.frame = CGRectMake(ScreenWidth/2.0 - 75 , 88  , 50 + 100*scale*2, 2);
    }else if (offsetX > ScreenWidth/2.0 ){
        
         CGSize rect = _lineView.frame.size;
        
         _lineView.frame = CGRectMake(ScreenWidth/2.0 - 75 + 100*(scale-0.5)*2, 88  , rect.width - 100*(scale-0.5)*2, 2);
    }
//    _lineView.frame = CGRectMake(ScreenWidth/2.0 - 75 + 100*scale, 88, 50, 2);
    
}



@end
