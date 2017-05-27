//
//  NSDictionary+DLog.m
//  TestDemo1
//
//  Created by caohouhong on 17/5/27.
//  Copyright © 2017年 caohouhong. All rights reserved.
//  解决打印是Unicode的方法

#import "NSDictionary+DLog.h"

@implementation NSDictionary (DLog)

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)descriptionWithLocale:(id)locale{
    
    if (![self count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[self description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    
    [NSPropertyListSerialization propertyListWithData:tempData
                                              options:NSPropertyListImmutable
                                               format:NULL
                                                error:NULL];
    return str;

}

@end
