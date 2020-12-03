//
//  NSObject+UnCrashTool.h
//  UnCrashDemo001
//
//  Created by yan on 2020/8/27.
//  Copyright © 2020 yan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UnCrashToolReminder.h"
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

/// 防止崩溃的NSObjectCategory
@interface NSObject (UnCrashTool)

/// 使用runtime交换对象方法
/// @param cls 类
/// @param originSelector 原来的方法
/// @param swizzledSelector 交换的方法
+ (void)unCrashTool_swizzleInstanceMethodImplementation:(Class)cls originSelector:(SEL)originSelector swizzledSelector:(SEL)swizzledSelector;

/// 使用runtime交换类方法
/// @param cls 类
/// @param originSelector 原来的方法
/// @param swizzledSelector 交换的方法
+ (void)unCrashTool_swizzleClassMethodImplementation:(Class)cls originSelector:(SEL)originSelector swizzledSelector:(SEL)swizzledSelector;

#pragma mark- 检查是不是系统的类

/// 检查是不是系统的类
/// @param cls 当前需要检查的类
- (BOOL)isSystemClass:(Class)cls;


@end

NS_ASSUME_NONNULL_END
