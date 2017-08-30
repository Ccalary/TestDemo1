//
//  NSMutableArray+Extension.m
//  TestDemo1
//
//  Created by caohouhong on 17/4/20.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

//利用runtime对array的异常进行捕获，例如越界什么的，但是不建议这样使用，因为有了问题很难排查

#import "NSMutableArray+Extension.h"
#import "objc/runtime.h"

@implementation NSMutableArray (Extension)

+ (void)load
{
    Class arrayMClass = NSClassFromString(@"__NSArrayM");
    
    //获取系统的添加元素的方法
    Method addObject = class_getInstanceMethod(arrayMClass, @selector(addObject:));
    
    //获取我们自定义添加元素的方法
    Method avoidCrashAddObject = class_getInstanceMethod(arrayMClass, @selector(avoidCrashAddObject:));
    
    //将两个方法进行交换
    //当你调用addObject,其实就是调用avoidCrashAddObject
    //当你调用avoidCrashAddObject，其实就是调用addObject
    method_exchangeImplementations(addObject, avoidCrashAddObject);
}

- (void)avoidCrashAddObject:(id)object{
    
    @try {
        [self avoidCrashAddObject:object]; //其实就是调用addObject
    } @catch (NSException *exception) {
        //能来到这里,说明可变数组添加元素的代码有问题
        //你可以在这里进行相应的操作处理
        
        NSLog(@"出现异常了==名称:  %@,  原因:  %@",exception.name, exception.reason);
        
    } @finally {
        //在这里的代码一定会执行，你也可以进行相应的操作
    }
}

@end
