//
//  NSObject+UnCrashUnrecognizedSelector.m
//  UnCrashDemo001
//
//  Created by yan on 2020/8/27.
//  Copyright © 2020 yan. All rights reserved.
//

#import "NSObject+UnCrashUnRecognizedSelector.h"
#import "NSObject+UnCrashTool.h"
#import <objc/runtime.h>

@implementation NSObject (UnCrashUnRecognizedSelector)

/// 防止 unrecognized selector 出现崩溃，方法启用
+ (void)unCrash_UnRecognizedSelectorProtectorSwizzleMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 对象方法
        // 交换 methodSignatureForSelector 方法
        [self unCrashTool_swizzleInstanceMethodImplementation:[self class] originSelector:@selector(forwardInvocation:) swizzledSelector:@selector(unCrash_forwardInvocation:)];
        
        [self unCrashTool_swizzleInstanceMethodImplementation:[self class] originSelector:@selector(methodSignatureForSelector:) swizzledSelector:@selector(unCrash_methodSignatureForSelector:)];
        
        // 交换 methodSignatureForSelector 方法
        [self unCrashTool_swizzleClassMethodImplementation:[self class] originSelector:@selector(forwardInvocation:) swizzledSelector:@selector(unCrash_forwardInvocation:)];
    });
}

#pragma mark- 对象方法找不到的处理
- (NSMethodSignature *)unCrash_methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *methodSignature = [self unCrash_methodSignatureForSelector:aSelector];
    if (methodSignature) return methodSignature;

    IMP originIMP = class_getMethodImplementation([NSObject class], @selector(methodSignatureForSelector:));
    IMP currentClassIMP = class_getMethodImplementation([self class],     @selector(methodSignatureForSelector:));
    // 如果子类重载了该方法，则返回nil
    if (originIMP != currentClassIMP) return nil;
    
    // - (void)xxxx
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

- (void)unCrash_forwardInvocation:(NSInvocation *)anInvocation {
    
    IMP originIMP = class_getMethodImplementation([NSObject class], @selector(forwardInvocation:));
    IMP currentClassIMP = class_getMethodImplementation([self class],@selector(forwardInvocation:));
    // 如果子类重载了该方法
    if (originIMP != currentClassIMP){
        // 交给子类自己处理
        return [self unCrash_forwardInvocation:anInvocation];
    }

    @try {
        [self unCrash_forwardInvocation:anInvocation];
    } @catch (NSException *exception) {
        [UnCrashToolReminder reminderExcepition:exception];
    } @finally {
        
    }
}

#pragma mark- 类方法找不到的处理
+ (void)unCrash_forwardInvocation:(NSInvocation *)anInvocation {
    IMP originIMP = class_getMethodImplementation([NSObject class], @selector(forwardInvocation:));
    IMP currentClassIMP = class_getMethodImplementation([self class],@selector(forwardInvocation:));
    // 如果子类重载了该方法
    if (originIMP != currentClassIMP){
        // 交给子类自己处理
        return [self unCrash_forwardInvocation:anInvocation];
    }
    
    @try {
        [self unCrash_forwardInvocation:anInvocation];
    } @catch (NSException *exception) {
         [UnCrashToolReminder reminderExcepition:exception];
    } @finally {
        
    }
}

@end
