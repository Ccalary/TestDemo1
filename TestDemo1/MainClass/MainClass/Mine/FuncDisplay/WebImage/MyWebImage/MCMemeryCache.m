//
//  MCMemeryCache.m
//  TestDemo1
//
//  Created by caohouhong on 2018/5/14.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "MCMemeryCache.h"

// 计算图片大小-内联函数
static inline NSUInteger MCCacheCostForImage(UIImage *image) {
    return image.size.width * image.size.height * image.scale * image.scale;
}

@interface MCMemeryCache<KeyType, ObjectType> ()
@property (nonatomic, strong, nonnull) NSMapTable<KeyType, ObjectType> *weakCache; // strong-weak cache
@property (nonatomic, strong, nonnull) dispatch_semaphore_t weakCacheLock; // a lock to keep the access to `weakCache` thread-safe
@end

@implementation MCMemeryCache
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // Use a strong-weak maptable storing the secondary cache. Follow the doc that NSCache does not copy keys
        // This is useful when the memory warning, the cache was purged. However, the image instance can be retained by other instance such as imageViews and alive.
        // At this case, we can sync weak cache back and do not need to load from disk cache
        self.weakCache = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsWeakMemory capacity:0];
        // 创建信号量，参数：信号量的初值，如果小于0则会返回NULL
        self.weakCacheLock = dispatch_semaphore_create(1);
        // 监听内存情况，如果收到内存警告则清空
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveMemoryWarning:)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
    }
    return self;
}

- (void)didReceiveMemoryWarning:(NSNotification *)notification {
    // Only remove cache, but keep weak cache
    [super removeAllObjects];
}

// `setObject:forKey:` just call this with 0 cost. Override this is enough
- (void)setObject:(id)obj forKey:(id)key cost:(NSUInteger)g {
    [super setObject:obj forKey:key cost:g];
    if (key && obj) {
        // Store weak cache
        // 等待降低信号量
        dispatch_semaphore_wait(self.weakCacheLock, DISPATCH_TIME_FOREVER);
        [self.weakCache setObject:obj forKey:key];
        // 提高信号量
        dispatch_semaphore_signal(self.weakCacheLock);
    }
}

- (id)objectForKey:(id)key {
    id obj = [super objectForKey:key];
    if (key && !obj) {
        // Check weak cache
        dispatch_semaphore_wait(self.weakCacheLock, DISPATCH_TIME_FOREVER);
        obj = [self.weakCache objectForKey:key];
        dispatch_semaphore_signal(self.weakCacheLock);
        if (obj) {
            // Sync cache
            NSUInteger cost = 0;
            if ([obj isKindOfClass:[UIImage class]]) {
                cost = MCCacheCostForImage(obj);
                NSLog(@"imageCost:%lu",(unsigned long)cost);
            }
            [super setObject:obj forKey:key cost:cost];
        }
    }
    return obj;
}

- (void)removeObjectForKey:(id)key {
    [super removeObjectForKey:key];
    if (key) {
        // Remove weak cache
        dispatch_semaphore_wait(self.weakCacheLock, DISPATCH_TIME_FOREVER);
        [self.weakCache removeObjectForKey:key];
        dispatch_semaphore_signal(self.weakCacheLock);
    }
}

- (void)removeAllObjects {
    [super removeAllObjects];
    // Manually remove should also remove weak cache
    dispatch_semaphore_wait(self.weakCacheLock, DISPATCH_TIME_FOREVER);
    [self.weakCache removeAllObjects];
    dispatch_semaphore_signal(self.weakCacheLock);
}

@end
