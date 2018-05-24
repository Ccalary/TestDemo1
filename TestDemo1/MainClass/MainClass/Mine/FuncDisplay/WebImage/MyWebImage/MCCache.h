//
//  MCCache.h
//  TestDemo1
//
//  Created by caohouhong on 2018/5/21.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MCCache : NSObject
- (void)storeToDiskWithImageData:(NSData *)imageData andKey:(NSString *)key;
// 查询硬盘是否有缓存
- (UIImage *)diskImageForKey:(NSString *)key;
@end
