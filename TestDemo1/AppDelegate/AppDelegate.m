//
//  AppDelegate.m
//  TestDemo1
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import "HomeViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface AppDelegate ()
@property (nonatomic, strong) AFNetworkReachabilityManager *netManager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = [[BaseTabBarController alloc] init];
    
    [self listeningTheNetChange];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 监听网络变化
- (void)listeningTheNetChange{
    
    _netManager = [AFNetworkReachabilityManager sharedManager];
    [_netManager startMonitoring];
    [_netManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            DLog(@"未知网络");
            break;
            case AFNetworkReachabilityStatusNotReachable:
            DLog(@"无网络");
            break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            DLog(@"网络数据连接");
            break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            DLog(@"wifi连接");
            break;
            default:
            break;
        }
    }];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options API_AVAILABLE(ios(9.0)){
    NSString *strUrl=url.absoluteString;
    NSLog(@"%@",strUrl);
    
    NSLog(@"options:%@",options);
    
    return YES;
}

@end
