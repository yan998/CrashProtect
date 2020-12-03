//
//  NSMutableArray+UnCrashMutableArrayProtector.m
//  UnCrashDemo001
//
//  Created by yan on 2020/9/1.
//  Copyright © 2020 yan. All rights reserved.
//

#import "NSMutableArray+UnCrashMutableArrayProtector.h"
#import "NSArray+UnCrashArrayProtector.h"
#import "NSObject+UnCrashTool.h"
#import <objc/runtime.h>

@implementation NSMutableArray (UnCrashMutableArrayProtector)

/// 防止 可变数组 出现崩溃，方法启用
+ (void)unCrash_protectorSwizzleMethod {
    // 动态数组
    Class cls5 = NSClassFromString(@"__NSArrayM");
    [self unCrashTool_swizzleInstanceMethodImplementation:cls5 originSelector:@selector(objectAtIndex:) swizzledSelector:@selector(unCrash_objectAtIndex:)];
    [self unCrashTool_swizzleInstanceMethodImplementation:cls5 originSelector:@selector(objectAtIndexedSubscript:) swizzledSelector:@selector(unCrash_objectAtIndexedSubscript:)];
    [self unCrashTool_swizzleInstanceMethodImplementation:cls5 originSelector:@selector(subarrayWithRange:) swizzledSelector:@selector(unCrash_subarrayWithRange:)];
    
    // 修改数据的场景
    [self unCrashTool_swizzleInstanceMethodImplementation:cls5 originSelector:@selector(insertObject:atIndex:) swizzledSelector:@selector(unCrash_insertObject:atIndex:)];
    
    // 删除元素
    [self unCrashTool_swizzleInstanceMethodImplementation:cls5 originSelector:@selector(removeObjectAtIndex:) swizzledSelector:@selector(unCrash_removeObjectAtIndex:)];
    [self unCrashTool_swizzleInstanceMethodImplementation:cls5 originSelector:@selector(removeObjectsInRange:) swizzledSelector:@selector(unCrash_removeObjectsInRange:)];
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
    NSArray *array = nil;
    @try {
        array = [self unCrash_subarrayWithRange:range];
    } @catch (NSException *exception) {
        // 越界 -- 报警
        [UnCrashToolReminder reminderExcepition:exception];
    } @finally {
        return array;
    }
}

- (void)unCrash_insertObject:(id)anObject atIndex:(NSUInteger)index {
    @try {
        [self unCrash_insertObject:anObject atIndex:index];
    } @catch (NSException *exception) {
        [UnCrashToolReminder reminderExcepition:exception];
    } @finally {
        
    }
}

#pragma mark- 删除元素
- (void)unCrash_removeObjectAtIndex:(NSUInteger)index {
    @try {
        [self unCrash_removeObjectAtIndex:index];
    } @catch (NSException *exception) {
        // 越界 -- 报警
        [UnCrashToolReminder reminderExcepition:exception];
    } @finally {
        
    }
}

- (void)unCrash_removeObjectsInRange:(NSRange)range {
    @try {
        [self unCrash_removeObjectsInRange:range];
    } @catch (NSException *exception) {
        [UnCrashToolReminder reminderExcepition:exception];
    } @finally {
        
    }
}

@end
