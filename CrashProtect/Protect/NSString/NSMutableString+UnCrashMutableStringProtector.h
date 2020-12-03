//
//  NSMutableString+UnCrashMutableStringProtector.h
//  UnCrashDemo001
//
//  Created by yan on 2020/9/2.
//  Copyright © 2020 yan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// 可变字符串防崩溃分类
@interface NSMutableString (UnCrashMutableStringProtector)

/// 防止 可变字符串 出现崩溃
+ (void)unCrash_protectorSwizzleMethod;

@end

NS_ASSUME_NONNULL_END
