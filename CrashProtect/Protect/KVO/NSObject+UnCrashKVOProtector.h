//
//  NSObject+UnCrashKVOProtector.h
//  UnCrashDemo001
//
//  Created by yan on 2020/8/28.
//  Copyright © 2020 yan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// KVO防崩溃分类
@interface NSObject (UnCrashKVOProtector)

/// 防止 KVO 出现崩溃，方法启用
+ (void)unCrash_KVOProtector;

@end

NS_ASSUME_NONNULL_END
