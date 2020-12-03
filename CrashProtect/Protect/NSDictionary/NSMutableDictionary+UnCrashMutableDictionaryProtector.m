//
//  NSMutableDictionary+UnCrashMutableDictionaryProtector.m
//  UnCrashDemo001
//
//  Created by yan on 2020/9/3.
//  Copyright © 2020 yan. All rights reserved.
//

#import "NSMutableDictionary+UnCrashMutableDictionaryProtector.h"
#import "NSObject+UnCrashTool.h"

@implementation NSMutableDictionary (UnCrashMutableDictionaryProtector)

/// 防止 可变字典 出现崩溃，方法启用
+ (void)unCrash_protectorSwizzleMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = NSClassFromString(@"__NSDictionaryM");
      
        [self unCrashTool_swizzleInstanceMethodImplementation:[cls class] originSelector:@selector(setObject:forKey:) swizzledSelector:@selector(unCrash_setObject:forKey:)];
        [self unCrashTool_swizzleInstanceMethodImplementation:[cls class] originSelector:@selector(setValue:forKey:) swizzledSelector:@selector(unCrash_setValue:forKey:)];
        [self unCrashTool_swizzleInstanceMethodImplementation:[cls class] originSelector:@selector(removeObjectForKey:) swizzledSelector:@selector(unCrash_removeObjectForKey:)];
        [self unCrashTool_swizzleInstanceMethodImplementation:[cls class] originSelector:@selector(removeObjectsForKeys:) swizzledSelector:@selector(unCrash_removeObjectsForKeys:)];
        [self unCrashTool_swizzleInstanceMethodImplementation:[cls class] originSelector:@selector(setObject:forKeyedSubscript:) swizzledSelector:@selector(unCrash_setObject:forKeyedSubscript:)];
        
    });
}

- (void)unCrash_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    @try {
        [self unCrash_setObject:anObject forKey:aKey];
    } @catch (NSException *exception) {
        // 报警
        [UnCrashToolReminder reminderExcepition:exception];
    } @finally {
        
    }
}

- (void)unCrash_setValue:(id)value forKey:(NSString *)key {
    @try {
        [self unCrash_setValue:value forKey:key];
    } @catch (NSException *exception) {
        // 报警
        [UnCrashToolReminder reminderExcepition:exception];
    } @finally {
        
    }
}

- (void)unCrash_removeObjectForKey:(id)aKey {
    @try {
        [self unCrash_removeObjectForKey:aKey];
    } @catch (NSException *exception) {
        // 报警
        [UnCrashToolReminder reminderExcepition:exception];
    } @finally {
        
    }
}

- (void)unCrash_removeObjectsForKeys:(NSArray *)keyArray {
    @try {
        [self unCrash_removeObjectsForKeys:keyArray];
    } @catch (NSException *exception) {
        // 报警
        [UnCrashToolReminder reminderExcepition:exception];
    } @finally {
        
    }
}

- (void)unCrash_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    @try {
        [self unCrash_setObject:obj forKeyedSubscript:key];
    } @catch (NSException *exception) {
        // 报警
        [UnCrashToolReminder reminderExcepition:exception];
    } @finally {
        
    }
}


@end
