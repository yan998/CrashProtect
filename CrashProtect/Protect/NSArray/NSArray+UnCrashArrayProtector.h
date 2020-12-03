//
//  NSArray+UnCrashArrayProtector.h
//  UnCrashDemo001
//
//  Created by yan on 2020/9/1.
//  Copyright © 2020 yan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 数组越界
#define UnCrashArrayBeyondBounds @"Array Beyond Bounds"
// 获取数组某一块元素越界崩溃
#define UnCrashSubArrayWithRangeBeyondBounds @"subarrayWithRange Beyond Bounds"

/// 数组防崩溃分类
@interface NSArray (UnCrashArrayProtector)

/// 防止 数组 出现崩溃，方法启用
+ (void)unCrash_protectorSwizzleMethod;

@end

NS_ASSUME_NONNULL_END
