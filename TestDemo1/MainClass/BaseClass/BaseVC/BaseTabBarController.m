//
//  BaseTabBarController.m
//  TestDemo1
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "BaseTabBarController.h"
#import "HomeViewController.h"
#import "BaseNavigationController.h"
#import "MineViewController.h"
#import "DiscoverViewController.h"
#import "UIImage+IconFont.h"
#import "TouchViewController.h"
#import "TestDemo1-Swift.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITabBar *tabbar = [UITabBar appearance];
    tabbar.tintColor = [UIColor blueColor];
    // iOS15适配
    if (@available(iOS 13.0, *)) {
        UITabBarAppearance *appearance = [[UITabBarAppearance alloc] init];
        //背景色
        appearance.backgroundColor = [UIColor whiteColor];
        self.tabBar.standardAppearance = appearance;
        if(@available(iOS 15.0,*)) {
            self.tabBar.scrollEdgeAppearance = appearance;
        }
    }
    [self addChildViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//添加子控制器
- (void)addChildViewControllers{
    [self addChildrenViewController:[[ChartsLineVC alloc] init] andTitle:@"Test" andImageName:@"tab_me" andSelectImage:@"tab_me_pre"];
    [self addChildrenViewController:[[HomeViewController alloc] init] andTitle:@"首页" andImageName:@"tab_me" andSelectImage:@"tab_me_pre"];
    [self addChildrenViewController:[[DiscoverViewController alloc] init] andTitle:@"发现" andImageName:@"tab_me" andSelectImage:@"tab_me_pre"];
    [self addChildrenViewController:[[MineViewController alloc] init] andTitle:@"我" andImageName:@"tab_me" andSelectImage:@"tab_me_pre"];
//    [self addChildrenViewController:homeVC andTitle:@"首页" andImageName:@"\U0000e6ba"];
//    [self addChildrenViewController:[[DiscoverViewController alloc] init] andTitle:@"发现" andImageName:@"\U0000e705"];
//    [self addChildrenViewController:[[MineViewController alloc] init] andTitle:@"我" andImageName:@"\U0000e6b8"];
    
}

- (void)addChildrenViewController:(UIViewController *)childVC andTitle:(NSString *)title andImageName:(NSString *)imageName andSelectImage:(NSString *)selectedImage{
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage =  [UIImage imageNamed:selectedImage];
    childVC.title = title;

    BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:childVC];

    [self addChildViewController:baseNav];
}
@end
