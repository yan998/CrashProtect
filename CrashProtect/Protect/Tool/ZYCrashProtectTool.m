//
//  ZYCrashProtectTool.m
//  UnCrashDemo001
//
//  Created by yan on 2020/12/2.
//  Copyright © 2020 yan. All rights reserved.
//

#import "ZYCrashProtectTool.h"
#import "NSObject+UnCrashUnrecognizedSelector.h"
#import "NSObject+UnCrashKVOProtector.h"
#import "NSArray+UnCrashArrayProtector.h"
#import "NSMutableArray+UnCrashMutableArrayProtector.h"
#import "NSString+UnCrashString.h"
#import "NSMutableString+UnCrashMutableStringProtector.h"
#import "NSMutableDictionary+unCrashMutableDictionaryProtector.h"
#import "NSDictionary+UnCrashDictionaryProtector.h"
#import "NSTimer+UnCrashNSTimerProtector.h"
#import "UnCrashKVOProxy.h"

ZYUnCrashType const UnCrashSelector = @"Selector";
ZYUnCrashType const UnCrashKVO = @"KVO";
ZYUnCrashType const UnCrashArray = @"Array";
ZYUnCrashType const UnCrashDictionary = @"Dictionary";
ZYUnCrashType const UnCrashString = @"String";
ZYUnCrashType const UnCrashTimer = @"Timer";

@implementation ZYCrashProtectTool

+ (void)configAllProtectTypes {
    NSArray *types = @[UnCrashSelector,UnCrashKVO,UnCrashArray,UnCrashDictionary,UnCrashString,UnCrashTimer];
    [self configProtectTypes:types];
}
+ (void)configProtectTypes:(NSArray<ZYUnCrashType> *)types {
    for (NSInteger i = 0; i < types.count; i++) {
        ZYUnCrashType type = types[i];
        if ([type isKindOfClass:[NSString class]]) {
            if ([type isEqualToString:UnCrashSelector]) {
                // 方法调用不到保护
                [NSObject unCrash_UnRecognizedSelectorProtectorSwizzleMethod];
            } else if ([type isEqualToString:UnCrashKVO]) {
                // KVO防护
                [NSObject unCrash_KVOProtector];
            } else if ([type isEqualToString:UnCrashArray]) {
                // 数组防护
                [NSArray unCrash_protectorSwizzleMethod];
                [NSMutableArray unCrash_protectorSwizzleMethod];
            } else if ([type isEqualToString:UnCrashDictionary]) {
                // 字典防护
                [NSMutableDictionary unCrash_protectorSwizzleMethod];
                [NSDictionary unCrash_protectorSwizzleMethod];
            } else if ([type isEqualToString:UnCrashString]) {
                // 字符串防护
                [NSString unCrash_protectorSwizzleMethod];
                [NSMutableString unCrash_protectorSwizzleMethod];
            } else if ([type isEqualToString:UnCrashTimer]) {
                // NSTimer防止循环引用
                [NSTimer unCrash_protectorSwizzleMethod];
            }
        }
    }
}

@end
