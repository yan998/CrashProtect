//
//  NSMutableString+UnCrashMutableStringProtector.m
//  UnCrashDemo001
//
//  Created by yan on 2020/9/2.
//  Copyright © 2020 yan. All rights reserved.
//

#import "NSMutableString+UnCrashMutableStringProtector.h"
#import "NSObject+UnCrashTool.h"

@implementation NSMutableString (UnCrashMutableStringProtector)

/// 防止 可变字符串 出现崩溃
+ (void)unCrash_protectorSwizzleMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls1 = NSClassFromString(@"NSMutableString");
        [self unCrashTool_swizzleInstanceMethodImplementation:cls1 originSelector:@selector(appendString:) swizzledSelector:@selector(unCrash_appendString:)];
        [self unCrashTool_swizzleInstanceMethodImplementation:cls1 originSelector:@selector(insertString:atIndex:) swizzledSelector:@selector(unCrash_insertString:atIndex:)];
        [self unCrashTool_swizzleInstanceMethodImplementation:cls1 originSelector:@selector(deleteCharactersInRange:) swizzledSelector:@selector(unCrash_deleteCharactersInRange:)];
        
    });
}

#pragma mark- 交换的方法实现
- (void)unCrash_appendString:(NSString *)aString {
    @try {
        [self unCrash_appendString:aString];
    } @catch (NSException *exception) {
        // 报警
        [UnCrashToolReminder reminderExcepition:exception];
    } @finally {
        
    }
}

- (void)unCrash_insertString:(NSString *)aString atIndex:(NSUInteger)loc {
    @try {
        [self unCrash_insertString:aString atIndex:loc];
    } @catch (NSException *exception) {
        [UnCrashToolReminder reminderExcepition:exception];
        
    } @finally {
        
    }
}

- (void)unCrash_deleteCharactersInRange:(NSRange)range {
    @try {
        [self unCrash_deleteCharactersInRange:range];
    } @catch (NSException *exception) {
        [UnCrashToolReminder reminderExcepition:exception];
    } @finally {
        
    }
}

- (NSString *)unCrash_substringWithRange:(NSRange)range {
    NSString *str = nil;
    @try {
        str = [self unCrash_substringWithRange:range];
    } @catch (NSException *exception) {
        [UnCrashToolReminder reminderExcepition:exception];
    } @finally {
        return str;
    }
}

@end
