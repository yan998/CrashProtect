//
//  NSTimer+UnCrashNSTimerProtector.h
//  UnCrashDemo001
//
//  Created by yan on 2020/12/1.
//  Copyright © 2020 yan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// NSTimer防止循环引用分类
@interface NSTimer (UnCrashNSTimerProtector)

/// 防止 NSTimer 循环引用方法启用
+ (void)unCrash_protectorSwizzleMethod;

@end

NS_ASSUME_NONNULL_END
