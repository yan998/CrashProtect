//
//  NSDictionary+UnCrashDictionaryProtector.m
//  UnCrashDemo001
//
//  Created by yan on 2020/9/3.
//  Copyright © 2020 yan. All rights reserved.
//

#import "NSDictionary+UnCrashDictionaryProtector.h"
#import "NSObject+UnCrashTool.h"

@implementation NSDictionary (UnCrashDictionaryProtector)

/// 防止 字典 出现崩溃，方法启用
+ (void)unCrash_protectorSwizzleMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class cls = NSClassFromString(@"NSDictionary");
        
        [self unCrashTool_swizzleInstanceMethodImplementation:[cls class] originSelector:@selector(initWithDictionary:) swizzledSelector:@selector(unCrash_initWithDictionary:)];
    });
}

- (instancetype)unCrash_initWithDictionary:(NSDictionary *)otherDictionary {
    id result;
    @try {
        result = [self unCrash_initWithDictionary:otherDictionary];
    } @catch (NSException *exception) {
        // 报警
        [UnCrashToolReminder reminderExcepition:exception];
    } @finally {
        
    }
    return result;
}

@end
