//
//  NSArray+UnCrashArrayProtector.m
//  UnCrashDemo001
//
//  Created by yan on 2020/9/1.
//  Copyright © 2020 yan. All rights reserved.
//

#import "NSArray+UnCrashArrayProtector.h"
#import "NSObject+UnCrashTool.h"
#import <objc/runtime.h>

@implementation NSArray (UnCrashArrayProtector)
/// 防止 数组 出现崩溃，方法启用
+ (void)unCrash_protectorSwizzleMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 类方法
        [self unCrashTool_swizzleClassMethodImplementation:[self class] originSelector:@selector(arrayWithArray:) swizzledSelector:@selector(unCrash_arrayWithArray:)];
        
        // 空数组
        Class cls1 = NSClassFromString(@"__NSArray0");
        [self unCrashTool_swizzleInstanceMethodImplementation:cls1 originSelector:@selector(objectAtIndex:) swizzledSelector:@selector(unCrash_objectAtIndex:)];
        [self unCrashTool_swizzleInstanceMethodImplementation:cls1 originSelector:@selector(objectAtIndexedSubscript:) swizzledSelector:@selector(unCrash_objectAtIndexedSubscript:)];
        [self unCrashTool_swizzleInstanceMethodImplementation:cls1 originSelector:@selector(subarrayWithRange:) swizzledSelector:@selector(unCrash_subarrayWithRange:)];

        // 只有一个元素的数组
        Class cls2 = NSClassFromString(@"__NSSingleObjectArrayI");
        [self unCrashTool_swizzleInstanceMethodImplementation:cls2 originSelector:@selector(objectAtIndex:) swizzledSelector:@selector(unCrash_objectAtIndex:)];
        [self unCrashTool_swizzleInstanceMethodImplementation:cls2 originSelector:@selector(objectAtIndexedSubscript:) swizzledSelector:@selector(unCrash_objectAtIndexedSubscript:)];
        [self unCrashTool_swizzleInstanceMethodImplementation:cls2 originSelector:@selector(subarrayWithRange:) swizzledSelector:@selector(unCrash_subarrayWithRange:)];

        // 多个元素的数组
        Class cls3 = NSClassFromString(@"__NSArrayI");
        [self unCrashTool_swizzleInstanceMethodImplementation:cls3 originSelector:@selector(objectAtIndex:) swizzledSelector:@selector(unCrash_objectAtIndex:)];
        [self unCrashTool_swizzleInstanceMethodImplementation:cls3 originSelector:@selector(objectAtIndexedSubscript:) swizzledSelector:@selector(unCrash_objectAtIndexedSubscript:)];
        [self unCrashTool_swizzleInstanceMethodImplementation:cls3 originSelector:@selector(subarrayWithRange:) swizzledSelector:@selector(unCrash_subarrayWithRange:)];
    });
}

#pragma mark- 交换方法实现

- (id)unCrash_objectAtIndex:(NSUInteger)index {
    id instance = nil;
    @try {
        instance = [self unCrash_objectAtIndex:index];
    } @catch (NSException *exception) {
        // 越界 -- 报警
        [UnCrashToolReminder reminderExcepition:exception];
    } @finally {
        return instance;
    }
}

- (id)unCrash_objectAtIndexedSubscript:(NSUInteger)index {
    id instance = nil;
    @try {
        instance = [self unCrash_objectAtIndexedSubscript:index];
    } @catch (NSException *exception) {
        // 越界 -- 报警
        [UnCrashToolReminder reminderExcepition:exception];
    } @finally {
        return instance;
    }
}

- (NSArray *)unCrash_subarrayWithRange:(NSRange)range {
    
    NSArray *array;
    @try {
        array = [self unCrash_subarrayWithRange:range];
    } @catch (NSException *exception) {
        // 越界 -- 报警
        [UnCrashToolReminder reminderExcepition:exception];
    } @finally {
        return array;
    }
}

+ (instancetype)unCrash_arrayWithArray:(NSArray *)array {
    id instance = nil;
    @try {
        instance = [self unCrash_arrayWithArray:array];
    } @catch (NSException *exception) {
        [UnCrashToolReminder reminderExcepition:exception];
    } @finally {
        return instance;
    }
}

@end
