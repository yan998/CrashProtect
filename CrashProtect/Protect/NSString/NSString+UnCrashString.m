//
//  NSString+UnCrashString.m
//  UnCrashDemo001
//
//  Created by yan on 2020/9/2.
//  Copyright © 2020 yan. All rights reserved.
//

#import "NSString+UnCrashString.h"
#import "NSObject+UnCrashTool.h"
#import <objc/runtime.h>

/**
    __NSCFConstantString --> __NSCFString -->NSMutableString
    NSTaggedPointerString --> NSString
 */

@implementation NSString (UnCrashString)

/// 防止 字符串 出现崩溃
+ (void)unCrash_protectorSwizzleMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 不可变字符串
        // __NSCFConstantString  __NSCFString
        Class cls1 = NSClassFromString(@"NSMutableString");
        [self unCrashTool_swizzleInstanceMethodImplementation:cls1 originSelector:@selector(substringFromIndex:) swizzledSelector:@selector(unCrash_substringFromIndex:)];
        [self unCrashTool_swizzleInstanceMethodImplementation:cls1 originSelector:@selector(substringToIndex:) swizzledSelector:@selector(unCrash_substringToIndex:)];
        
        
        // NSTaggedPointerString的父类是NSString
        Class cls2 = NSClassFromString(@"NSString");
        [self unCrashTool_swizzleInstanceMethodImplementation:cls2 originSelector:@selector(substringFromIndex:) swizzledSelector:@selector(unCrash_substringFromIndex:)];
        [self unCrashTool_swizzleInstanceMethodImplementation:cls2 originSelector:@selector(substringToIndex:) swizzledSelector:@selector(unCrash_substringToIndex:)];
        
        // NSTaggedPointerString 单独拦截
        Class cls3 = NSClassFromString(@"NSTaggedPointerString");
        [self unCrashTool_swizzleInstanceMethodImplementation:cls3 originSelector:@selector(substringWithRange:) swizzledSelector:@selector(unCrash_substringWithRange:)];
        
        // __NSCFConstantString 单独拦截
        Class cls4 = NSClassFromString(@"__NSCFConstantString");
        [self unCrashTool_swizzleInstanceMethodImplementation:cls4 originSelector:@selector(substringWithRange:) swizzledSelector:@selector(unCrash_substringWithRange:)];
        
        // __NSCFString 单独拦截
        Class cls5 = NSClassFromString(@"__NSCFString");
        [self unCrashTool_swizzleInstanceMethodImplementation:cls5 originSelector:@selector(substringWithRange:) swizzledSelector:@selector(unCrash_substringWithRange:)];
    });
}

#pragma mark- 交换的方法实现
#pragma mark- 不可变字符串
- (NSString *)unCrash_substringFromIndex:(NSUInteger)from {
    NSString *str = nil;
    @try {
        str = [self unCrash_substringFromIndex:from];
    } @catch (NSException *exception) {
        // 越界 -- 报警
        [UnCrashToolReminder reminderExcepition:exception];
    } @finally {
        return str;
    }
}

- (NSString *)unCrash_substringToIndex:(NSUInteger)to {
    NSString *str = nil;
    @try {
        str = [self unCrash_substringToIndex:to];
    } @catch (NSException *exception) {
        // 越界 -- 报警
        [UnCrashToolReminder reminderExcepition:exception];
        
    } @finally {
        return str;
    }
}

- (NSString *)unCrash_substringWithRange:(NSRange)range {
    NSString *str = nil;
    @try {
        str = [self unCrash_substringWithRange:range];
    } @catch (NSException *exception) {
        // 越界 -- 报警
        [UnCrashToolReminder reminderExcepition:exception];
        
    } @finally {
        return str;
    }
}


@end
