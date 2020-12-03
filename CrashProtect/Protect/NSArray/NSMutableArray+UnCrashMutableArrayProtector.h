//
//  NSMutableArray+UnCrashMutableArrayProtector.h
//  UnCrashDemo001
//
//  Created by yan on 2020/9/1.
//  Copyright © 2020 yan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// 输入插入失败
#define UnCrashInsertObjectError @"insertObject:atIndex: error"
// 删除某个元素，越界访问
#define UnCrashRemoveObjectAtIndexBeyondBounds @"removeObjectAtIndex Beyond Bounds"
// 删除某段元素，越界访问
#define UnCrashRemoveObjectsInRangeBeyondBounds @"removeObjectsInRange Beyond Bounds"
/// 可变数组防崩溃分类
@interface NSMutableArray (UnCrashMutableArrayProtector)

/// 防止 可变数组 出现崩溃，方法启用
+ (void)unCrash_protectorSwizzleMethod;

@end

NS_ASSUME_NONNULL_END
