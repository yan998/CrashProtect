//
//  UnCrashKVOProxy.h
//  UnCrashDemo001
//
//  Created by yan on 2020/8/28.
//  Copyright © 2020 yan. All rights reserved.
//

#import <Foundation/Foundation.h>

// 记录KVO的操作类型
// 添加操作
#define kUnCrashKVOAddOperateType @"addObserver"
// 移除操作
#define kUnCrashKVORemoveOperateType @"removeObserver"

// 报错类型
// crash
#define kUnCrashKVOErrorCrash @"KVO Crash"
// waring
#define kUnCrashKVOErrorWaring @"KVO Waring"

@interface UnCrashKVOProxy : NSObject

/// 被观察者
@property (nonatomic, weak) id observed;

/// 将KVO相关添加到map中
/// @param observer observer
/// @param keyPath keyPath
/// @param options options
/// @param context context
- (BOOL)proxyAddInfoToMapWithObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;

/// 移除kvo监听
/// @param observer observer
/// @param keyPath keyPath
/// @param context context
- (BOOL)proxyRemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context;

/// 移除kvo监听
/// @param observer observer
/// @param keyPath keyPath
- (BOOL)proxyRemoveObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

/// 查看当前还有几个在注册的keyPath
- (NSArray<NSString *> *)getAllObserverKeys;


@end


