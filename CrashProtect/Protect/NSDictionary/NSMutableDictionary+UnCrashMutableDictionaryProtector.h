//
//  NSMutableDictionary+UnCrashMutableDictionaryProtector.h
//  UnCrashDemo001
//
//  Created by yan on 2020/9/3.
//  Copyright © 2020 yan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 可变字典防崩溃分类
@interface NSMutableDictionary (UnCrashMutableDictionaryProtector)

/// 防止 可变字典 出现崩溃，方法启用
+ (void)unCrash_protectorSwizzleMethod;

@end

NS_ASSUME_NONNULL_END
