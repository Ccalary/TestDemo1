//
//  NSObject+Description.m
//  TestDemo1
//
//  Created by chh on 2017/8/4.
//  Copyright © 2017年 caohouhong. All rights reserved.
//  解决打印model类只打印出地址的信息，这样的话可以打印出所有属性

#import "NSObject+Description.h"
#import <objc/runtime.h>

@implementation NSObject (Description)
//NSLog 打印
- (NSString *)description{

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
//    unsigned int count;
//    objc_property_t *properties = class_copyPropertyList([self class], &count);
//    for (int i = 0; i < count; i++){//遍历拿到每一个属性
//        objc_property_t property = properties[i];
//        const char *char_p = property_getName(property);
//        //获得属性名
//        NSString *name = [NSString stringWithUTF8String:char_p];
//        id propertyValue = [self valueForKey:name]?:@"nil";//默认值为nil
//        
//        [dictionary setValue:propertyValue forKey:name];
//        
//    }
//    //释放
//    free(properties);
    //返回
    return [NSString stringWithFormat:@"<%@: %p> -- %@",[self class],self,dictionary];
}

//LLDB po 打印
- (NSString *)debugDescription{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++){//遍历拿到每一个属性
        objc_property_t property = properties[i];
        const char *char_p = property_getName(property);
        //获得属性名
        NSString *name = [NSString stringWithUTF8String:char_p];
        id propertyValue = [self valueForKey:name]?:@"nil";//默认值为nil
        
        [dictionary setValue:propertyValue forKey:name];
        
    }
    //释放
    free(properties);
    //返回
    return [NSString stringWithFormat:@"<%@: %p> -- %@",[self class],self,dictionary];
}

@end
