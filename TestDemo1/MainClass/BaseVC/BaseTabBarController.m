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

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITabBar *tabbar = [UITabBar appearance];
    tabbar.tintColor = [UIColor blueColor];
    
    [self addChildViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//添加子控制器
- (void)addChildViewControllers{
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    homeVC.tabBarItem.badgeValue = @"1";
    
    [self addChildrenViewController:homeVC andTitle:@"首页" andImageName:@"tab_me" andSelectImage:@"tab_me_pre"];
    [self addChildrenViewController:[[HomeViewController alloc] init] andTitle:@"发现" andImageName:@"tab_me" andSelectImage:@"tab_me_pre"];
    [self addChildrenViewController:[[MineViewController alloc] init] andTitle:@"我" andImageName:@"tab_me" andSelectImage:@"tab_me_pre"];
}

- (void)addChildrenViewController:(UIViewController *)childVC andTitle:(NSString *)title andImageName:(NSString *)imageName andSelectImage:(NSString *)selectedImage{
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage =  [UIImage imageNamed:selectedImage];
    childVC.title = title;
    
    BaseNavigationController *baseNav = [[BaseNavigationController alloc] initWithRootViewController:childVC];
    
    [self addChildViewController:baseNav];
}
@end
