//
//  NSObject+UnCrashUnrecognizedSelector.h
//  UnCrashDemo001
//
//  Created by yan on 2020/8/27.
//  Copyright © 2020 yan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// 报错类型
// 对象方法找不到
#define UnCrashInstanceUnrecognizedSelector @"Instance Unrecognized Selector"
// 类方法找不到
#define UnCrashClassUnrecognizedSelector @"Class Unrecognized Selector"
/// 防止 unrecognized selector 出现崩溃
@interface NSObject (UnCrashUnRecognizedSelector)

/// 防止 unrecognized selector 出现崩溃，方法启用
+ (void)unCrash_UnRecognizedSelectorProtectorSwizzleMethod;

@end

NS_ASSUME_NONNULL_END
