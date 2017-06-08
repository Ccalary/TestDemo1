//
//  DemoHelper.m
//  TestDemo1
//
//  Created by caohouhong on 17/6/7.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "DemoHelper.h"
static NSString *const kAreaRequestTimeStamp    = @"areaRequestTimeStamp";

@implementation DemoHelper
/**
 获取、保存地址请求时间
 */
+ (int)getAreaRequestTimeStamp{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    int time = [[defaults objectForKey:kAreaRequestTimeStamp] intValue];
    return time;
    
}

+ (void)setAreaRequestTimeStamp:(int)timeStamp{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setValue:@(timeStamp) forKey:kAreaRequestTimeStamp];
    [defaults synchronize];
}

@end
