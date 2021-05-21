//
//  MCCache.m
//  TestDemo1
//
//  Created by caohouhong on 2018/5/21.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "MCCache.h"
#import <CommonCrypto/CommonDigest.h>

@interface MCCache()
@property (nonatomic, strong) NSString *diskCachePath;
@property (nonatomic, strong) NSFileManager *fileManager;
@end

@implementation MCCache

- (instancetype)init {
    if (self = [super init]){
        _fileManager = [NSFileManager defaultManager];
        [self createFoler];
    }
    return self;
}

// 获取cache路径
- (NSString *)getCachePath {
    NSArray *doc = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = doc.firstObject;
    return path;
}

- (void)createFoler {
    NSString *path = [self getCachePath];
    self.diskCachePath = [path stringByAppendingPathComponent:@"MCImageCache"];
    BOOL isSuccess = [self.fileManager createDirectoryAtPath:self.diskCachePath withIntermediateDirectories:NO attributes:nil error:nil];
    if (isSuccess){
        NSLog(@"MCImageCache创建成功！");
    }else {
        NSLog(@"MCImageCache创建失败！");
    }
    NSLog(@"Path:%@",self.diskCachePath);
}

- (void)storeToDiskWithImageData:(NSData *)imageData andKey:(NSString *)key {
    if (!imageData || !key) {
        return;
    }
    if (![self.fileManager fileExistsAtPath:self.diskCachePath]){
        [self.fileManager createDirectoryAtPath:self.diskCachePath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    NSString *filePath = [self.diskCachePath stringByAppendingPathComponent:[self cachedFileNameForKey:key]];
    BOOL isSuccess = [imageData writeToFile:filePath atomically:YES];
    if (isSuccess){
        NSLog(@"写入成功");
    }else {
        NSLog(@"写入失败");
    }
}

- (NSString *)cachedFileNameForKey:(NSString *)key {
    const char *str = key.UTF8String;
    if (str == NULL){
        str = "";
    };
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSURL *keyURL = [NSURL URLWithString:key];
    NSString *ext = keyURL ? keyURL.pathExtension : key.pathExtension;
    NSString *filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%@",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10],
                          r[11], r[12], r[13], r[14], r[15], ext.length == 0 ? @"" : [NSString stringWithFormat:@".%@", ext]];
    return filename;
}

// 文件是否已经存储
- (BOOL)imageDataIsExitWithKey:(NSString *)key {
    if (!key){
        return NO;
    }
    NSString *filePath = [self.diskCachePath stringByAppendingPathComponent:[self cachedFileNameForKey:key]];
    return [self.fileManager fileExistsAtPath:filePath];
}

// 查询硬盘是否有缓存
- (UIImage *)diskImageForKey:(NSString *)key {
    if (!key || ![self imageDataIsExitWithKey:key]) return nil;
  
    NSString *filePath = [self.diskCachePath stringByAppendingPathComponent:[self cachedFileNameForKey:key]];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    if (fileData) {
         return [UIImage imageWithData:fileData];
    }else {
        return nil;
    }
}

@end
