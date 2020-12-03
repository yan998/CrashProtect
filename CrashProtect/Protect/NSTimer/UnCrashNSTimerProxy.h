//
//  UnCrashNSTimerProxy.h
//  UnCrashDemo001
//
//  Created by yan on 2020/12/1.
//  Copyright © 2020 yan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UnCrashNSTimerProxy : NSProxy

/// 初始化方法
/// @param object 对象
- (instancetype)initWithObjc:(id)object;

/// object对象死亡之后的回调
@property (nonatomic, copy) void (^deallocBlock)(void);

@end

NS_ASSUME_NONNULL_END
