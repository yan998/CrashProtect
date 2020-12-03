//
//  NSDictionary+UnCrashDictionaryProtector.h
//  UnCrashDemo001
//
//  Created by yan on 2020/9/3.
//  Copyright © 2020 yan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// 字典防崩溃分类
@interface NSDictionary (UnCrashDictionaryProtector)

/// 防止 字典 出现崩溃，方法启用
+ (void)unCrash_protectorSwizzleMethod;

@end

NS_ASSUME_NONNULL_END
