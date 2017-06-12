//
//  LoadingAnimationVC.m
//  TestDemo1
//
//  Created by caohouhong on 17/6/8.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "LoadingAnimationVC.h"
#import "LoadingViewForOC.h"

@interface LoadingAnimationVC ()
@property (nonatomic, strong)LoadingViewForOC *loadingView;
@end

@implementation LoadingAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _loadingView = [LoadingViewForOC showLoadingWith:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
