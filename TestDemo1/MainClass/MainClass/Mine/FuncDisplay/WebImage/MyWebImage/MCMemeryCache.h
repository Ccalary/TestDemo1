//
//  MCMemeryCache.h
//  TestDemo1
//
//  Created by caohouhong on 2018/5/14.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCMemeryCache<KeyType, ObjectType> : NSCache <KeyType, ObjectType>
- (void)setObject:(id)obj forKey:(id)key cost:(NSUInteger)g;
- (id)objectForKey:(id)key;
@end
