//
//  BaseNavigationController.m
//  TestDemo1
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationBar.translucent = NO; //设置了之后自动下沉64
//    self.navigationBar.tintColor = [UIColor whiteColor];
//    self.navigationBar.barTintColor = [UIColor mainColor];
    
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg"] forBarMetrics:UIBarMetricsDefault];
    
    //处理6p上面显示不全的bug
//    UIImage *bgImage = [[UIImage imageNamed:@"bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
//    [self.navigationBar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    
    self.navigationBar.translucent = NO; //设置了之后自动下沉navbar的高度
        self.navigationBar.barTintColor = [UIColor mainColor];
        self.navigationBar.tintColor = [UIColor whiteColor]; // 左右颜色
        // 中间title颜色
        [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18*UIRate],
                                                     NSForegroundColorAttributeName:[UIColor whiteColor]}];
        //去除导航栏下方的横线
        [self.navigationBar setBackgroundImage:[[UIImage alloc]init]
                                                      forBarMetrics:UIBarMetricsDefault];
        [self.navigationBar setShadowImage:[[UIImage alloc]init]];

        if (@available(iOS 15.0, *)) { // iOS15之后导航栏变白色问题修复
            UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
            [appearance configureWithOpaqueBackground];
            appearance.backgroundColor = [UIColor mainColor];
            appearance.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18*UIRate],
                                               NSForegroundColorAttributeName:[UIColor whiteColor]};
            self.navigationBar.standardAppearance = appearance;
            self.navigationBar.scrollEdgeAppearance = appearance;
        } else {

        }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self.viewControllers count] > 0){
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
        viewController.navigationItem.leftBarButtonItem = backItem;
    }
    //一定要写在最后，要不然无效
    [super pushViewController:viewController animated:animated];
    
    //解决iPhone X push页面时 tabBar上移的问题
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}

- (void)backAction{
    [self popViewControllerAnimated:YES];
}
@end
