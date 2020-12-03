//
//  NSObject+UnCrashKVOProtector.m
//  UnCrashDemo001
//
//  Created by yan on 2020/8/28.
//  Copyright © 2020 yan. All rights reserved.
//

#import "NSObject+UnCrashKVOProtector.h"
#import "NSObject+UnCrashTool.h"
#import <objc/runtime.h>
#import "UnCrashKVOProxy.h"

@interface NSObject()

/// 代理工具
@property (nonatomic, strong) UnCrashKVOProxy *unCrashKVOProxy;
/// 是不是使用了KVO代理工具，或者说，是不是非系统类使用了KVO
@property (nonatomic, assign) BOOL isUsedKVOProxy;
@end

@implementation NSObject (UnCrashKVOProtector)


#pragma mark- 方法交换
/// 防止 KVO 出现崩溃，方法启用
+ (void)unCrash_KVOProtector {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 交换 addObserver:forKeyPath:options:context: 方法
        [self unCrashTool_swizzleInstanceMethodImplementation:[self class] originSelector:@selector(addObserver:forKeyPath:options:context:) swizzledSelector:@selector(unCrashAddObserver:forKeyPath:options:context:)];
        
        // 交换移除KVO操作方法
        [self unCrashTool_swizzleInstanceMethodImplementation:[self class] originSelector:@selector(removeObserver:forKeyPath:context:) swizzledSelector:@selector(unCrashRemoveObserver:forKeyPath:context:)];
        
        // 交换移除KVO操作方法
        [self unCrashTool_swizzleInstanceMethodImplementation:[self class] originSelector:@selector(removeObserver:forKeyPath:) swizzledSelector:@selector(unCrashRemoveObserver:forKeyPath:)];
        
        // 交换dealloc方法
         [self unCrashTool_swizzleInstanceMethodImplementation:[self class] originSelector:NSSelectorFromString(@"dealloc") swizzledSelector:@selector(unCrashRemoveObserverDealloc)];
    });
}

#pragma mark- 交换方法操作
#pragma mark- 添加observer
- (void)unCrashAddObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    if (![self isSystemClass:[self class]]) {
        // 打标记
        self.isUsedKVOProxy = YES;
        // 被观察者
        self.unCrashKVOProxy.observed = self;
        // 不是系统的类，搞起
        if ([self.unCrashKVOProxy proxyAddInfoToMapWithObserver:observer forKeyPath:keyPath options:options context:context]) {
            // 安全，调用之前的方法
            [self unCrashAddObserver:self.unCrashKVOProxy forKeyPath:keyPath options:options context:context];
        }
    } else {
        // 系统的类，老实儿的调用原来的方法
        [self unCrashAddObserver:observer forKeyPath:keyPath options:options context:context];
    }
}

#pragma mark- 删除observer
- (void)unCrashRemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context {
    if (![self isSystemClass:[self class]]) {
        // 被观察者
        self.unCrashKVOProxy.observed = self;
        // 不是系统的类，搞起
        if ([self.unCrashKVOProxy proxyRemoveObserver:observer forKeyPath:keyPath context:context]) {
            // 移除成功，调用系统方法进行移除
            [self unCrashRemoveObserver:self.unCrashKVOProxy forKeyPath:keyPath context:context];
        }
    } else {
        // 老实儿的调用原来的方法
        [self unCrashRemoveObserver:observer forKeyPath:keyPath context:context];
    }
}

- (void)unCrashRemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    if (![self isSystemClass:[self class]]) {
        // 被观察者
        self.unCrashKVOProxy.observed = self;
        // 不是系统的类，搞起
        if ([self.unCrashKVOProxy proxyRemoveObserver:observer forKeyPath:keyPath]) {
            // 移除成功，调用系统方法进行移除
            [self unCrashRemoveObserver:self.unCrashKVOProxy forKeyPath:keyPath];
        }
    } else {
        // 老实儿的调用原来的方法
        [self unCrashRemoveObserver:observer forKeyPath:keyPath];
    }
}

#pragma mark- dealloc方法
- (void)unCrashRemoveObserverDealloc {
    
    if (![self isSystemClass:[self class]] && self.isUsedKVOProxy) {
        // 查看是否有剩下未移除的Observer
        NSArray *allObserverKeys = [self.unCrashKVOProxy getAllObserverKeys];
        if (allObserverKeys.count) {
            // 报警，并且自动移除
            NSString *finalStr = [[self.unCrashKVOProxy getAllObserverKeys] componentsJoinedByString:@","];
            NSString *reason = [NSString stringWithFormat:@"%@ \n已经dealloc了，注册的keyPath【%@】没有被仍然没有被remove",[self class],finalStr];
            NSException *exception = [[NSException alloc] initWithName:kUnCrashKVOErrorCrash reason:reason userInfo:nil];
            [UnCrashToolReminder reminderExcepition:exception];
            
            // 容错释放
            for (NSString *keyPath in allObserverKeys) {
                [self unCrashRemoveObserver:self.unCrashKVOProxy forKeyPath:keyPath];
            }
        }
    }
    [self unCrashRemoveObserverDealloc];
}

#pragma mark- 创建关联对象
- (void)setUnCrashKVOProxy:(UnCrashKVOProxy *)unCrashKVOProxy {
    objc_setAssociatedObject(self, @selector(unCrashKVOProxy), unCrashKVOProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UnCrashKVOProxy *)unCrashKVOProxy {
    UnCrashKVOProxy *unCrashKVOProxy = objc_getAssociatedObject(self, @selector(unCrashKVOProxy));
    
    if (!unCrashKVOProxy) {
        unCrashKVOProxy = [[UnCrashKVOProxy alloc] init];
        self.unCrashKVOProxy = unCrashKVOProxy;
    }
    return unCrashKVOProxy;
}

- (void)setIsUsedKVOProxy:(BOOL)isUsedKVOProxy {
    objc_setAssociatedObject(self, @selector(isUsedKVOProxy), @(isUsedKVOProxy), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isUsedKVOProxy {
    BOOL isUsed = [objc_getAssociatedObject(self, @selector(isUsedKVOProxy)) boolValue];
    return isUsed;
}


@end
