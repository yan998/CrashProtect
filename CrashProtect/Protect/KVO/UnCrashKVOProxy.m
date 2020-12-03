//
//  UnCrashKVOProxy.m
//  UnCrashDemo001
//
//  Created by yan on 2020/8/28.
//  Copyright © 2020 yan. All rights reserved.
//

#import "UnCrashKVOProxy.h"
#import "UnCrashToolReminder.h"
#import "NSObject+UnCrashTool.h"

typedef NS_ENUM(NSUInteger, UnCrashKVOProxyOperateType) {
    UnCrashKVOProxyOperateTypeAdd,
    UnCrashKVOProxyOperateTypeRemove
};

@interface UnCrashKVOProxy()

/// 用来保存KVO相关信息的字典
/// {key1:[obj1,obj2 .....],  key2:[obj1,obj2 .....]}
@property (nonatomic, strong) NSMutableDictionary<NSString *,NSHashTable<NSObject *>*> *kvoDic;

@end

@implementation UnCrashKVOProxy


/// 校验相关参数是否合法,不合法进行相关的报错
/// @param observer observer
/// @param keyPath keyPath
/// @param operateType 操作类型，是add还是remove
- (BOOL)checkObserver:(NSObject *)observer keyPath:(NSString *)keyPath operateType:(UnCrashKVOProxyOperateType)operateType {
    
    NSString *reason = nil;
    BOOL isLegal = YES;
    NSString *nameTitle = kUnCrashKVOErrorCrash;
    NSString *operateTypeStr = kUnCrashKVOAddOperateType;
    // 当前操作类型
    if (operateType == UnCrashKVOProxyOperateTypeRemove) {
        operateTypeStr = kUnCrashKVORemoveOperateType;
    }
    
    // 判断 observer
    if (!observer) {
        isLegal = NO;
        reason = [NSString stringWithFormat:@"%@\n%@操作\n%@ 的监听对象是空,keyPath是【%@】",kUnCrashKVOErrorWaring,operateTypeStr,[self.observed class],keyPath];
        nameTitle = kUnCrashKVOErrorWaring;
    } else if (![keyPath isKindOfClass:[NSString class]]) {
        isLegal = NO;
        reason = [NSString stringWithFormat:@"%@\n%@操作\n%@ \n的keyPath【%@】不是字符串类型",kUnCrashKVOErrorCrash,operateTypeStr,[self.observed class],keyPath];
    } else if (keyPath.length == 0) {
        isLegal = NO;
        reason = [NSString stringWithFormat:@"%@\n%@操作\n%@ \n的keyPath【%@】长度为0",kUnCrashKVOErrorCrash,operateTypeStr,[self.observed class],keyPath];
    }
    
    if (isLegal == NO) {
        // 不符合规范
        NSException *ex = [[NSException alloc] initWithName:nameTitle reason:reason userInfo:nil];
        [UnCrashToolReminder reminderExcepition:ex];
        return NO;
    }
    return YES;
}

/// 将KVO相关添加到map中
- (BOOL)proxyAddInfoToMapWithObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    
    @synchronized (self) {
        
        if (![self checkObserver:observer keyPath:keyPath operateType:UnCrashKVOProxyOperateTypeAdd]) {
            // 不符合规范
            return NO;
        }
        
        NSHashTable *table = self.kvoDic[keyPath];
        if (table.allObjects.count == 0) {
            // 之前一个也木有
            table = [[NSHashTable alloc] initWithOptions:NSPointerFunctionsWeakMemory capacity:0];
            [table addObject:observer];
            self.kvoDic[keyPath] = table;
            return YES;
        }
        
        // 之前没有存储过这个值
        if (![table.allObjects containsObject:observer]) {
            [table addObject:observer];
            return YES;
        }
        
        // 报警
        NSString *reason = [NSString stringWithFormat:@"重复添加keyPath\n%@操作\n%@ \n重复给%@添加keyPath【%@】",kUnCrashKVOAddOperateType,[self.observed class],[observer class],keyPath];
        NSException *ex = [[NSException alloc] initWithName:kUnCrashKVOErrorWaring reason:reason userInfo:nil];
        [UnCrashToolReminder reminderWarningExcepition:ex];
        // 重复添加了
        return NO;
    }
}

/// 移除kvo监听
- (BOOL)proxyRemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context {
    @synchronized (self) {
        if (![self checkObserver:observer keyPath:keyPath operateType:UnCrashKVOProxyOperateTypeRemove]) {
            // 不符合规范
            return NO;
        }
        NSHashTable *table = self.kvoDic[keyPath];
        if (table.allObjects.count == 0) {
            [self removeObserverError:observer forKeyPath:keyPath];
            return NO;
        }
        // 正常删除
        [table removeObject:observer];
        
        // 清空keyPath对应的table
        if (table.count == 0) {
            [self.kvoDic removeObjectForKey:keyPath];
            return YES;
        }
        
        [self removeObserverError:observer forKeyPath:keyPath];
        return NO;
    }
}


/// 移除异常报错
/// @param observer observer
/// @param keyPath keyPath
- (void)removeObserverError:(NSObject *)observer forKeyPath:(NSString *)keyPath  {
    // 报警
    NSString *reason = [NSString stringWithFormat:@"%@操作\n%@ \n移除%@的keyPath【%@】异常，keyPath重复移除或者没有注册过",kUnCrashKVORemoveOperateType,[self.observed class],[observer class],keyPath];
    NSException *ex = [[NSException alloc] initWithName:kUnCrashKVOErrorCrash reason:reason userInfo:nil];
    [UnCrashToolReminder reminderExcepition:ex];
}

/// 移除kvo监听
- (BOOL)proxyRemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
    return [self proxyRemoveObserver:observer forKeyPath:keyPath context:nil];
}

/// 获取当前有多少注册着的keyath
- (NSArray<NSString *> *)getAllObserverKeys {
    return self.kvoDic.allKeys;
}

#pragma mark- 响应observer，然后进行事件分发
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isKindOfClass:[NSString class]] && keyPath.length > 0) {
        NSHashTable *table = self.kvoDic[keyPath];
        for (id observer in table.allObjects) {
        
            // 因为 [observer respondsToSelector:@selector(observeValueForKeyPath:ofObject:change:context:)] 恒等于YES，所以这里通过try Cache进行拦截
            @try {
               [observer observeValueForKeyPath:keyPath ofObject:object change:change context:context];
            } @catch (NSException *exception) {
                // 吹哨，报警，某个observer没有实现observeValueForKeyPath:ofObject:change:context:方法
                // 报警，并且自动移除
                NSString *reason = [NSString stringWithFormat:@"%@ 木有实现\n observeValueForKeyPath:ofObject:change:context:",[observer class]];
                NSException *ex = [[NSException alloc] initWithName:kUnCrashKVOErrorCrash reason:reason userInfo:nil];
                [UnCrashToolReminder reminderExcepition:ex];
            }
        }
    }
}

#pragma mark- lazy load
- (NSMutableDictionary *)kvoDic {
    if (_kvoDic == nil) {
        _kvoDic = [[NSMutableDictionary alloc] init];
    }
    return _kvoDic;
}


@end
