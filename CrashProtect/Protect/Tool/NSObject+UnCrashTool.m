//
//  NSObject+UnCrashTool.m
//  UnCrashDemo001
//
//  Created by yan on 2020/8/27.
//  Copyright © 2020 yan. All rights reserved.
//

#import "NSObject+UnCrashTool.h"
#import <objc/runtime.h>

@implementation NSObject (UnCrashTool)

#pragma mark- 方法交换
/// 使用runtime交换对象方法
+ (void)unCrashTool_swizzleInstanceMethodImplementation:(Class)cls originSelector:(SEL)originSelector swizzledSelector:(SEL)swizzledSelector {
    if (!cls) return;

    Method originalMethod = class_getInstanceMethod(cls, originSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);

    BOOL didAddMethod =  class_addMethod(cls,
                                         originSelector,
                                         method_getImplementation(swizzledMethod),
                                         method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        class_replaceMethod(cls,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        class_replaceMethod(cls,
                            swizzledSelector,
                            class_replaceMethod(cls,
                                                originSelector,
                                                method_getImplementation(swizzledMethod),
                                                method_getTypeEncoding(swizzledMethod)),
                            method_getTypeEncoding(originalMethod));
        // 用此方法引起未知崩溃，原因待查
        // method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

/// 使用runtime交换类方法
+ (void)unCrashTool_swizzleClassMethodImplementation:(Class)cls originSelector:(SEL)originSelector swizzledSelector:(SEL)swizzledSelector {
    
    if (!cls) return;

    Class metacls = objc_getMetaClass(NSStringFromClass(cls).UTF8String);

    Method originalMethod = class_getClassMethod(cls, originSelector);
    Method swizzledMethod = class_getClassMethod(cls, swizzledSelector);

    BOOL didAddMethod = class_addMethod(metacls,
                                        originSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(metacls,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));

    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

#pragma mark- 检查是不是系统的类
- (BOOL)isSystemClass:(Class)cls {
    BOOL isSystem = NO;
    NSString *className = NSStringFromClass(cls);
    if ([className hasPrefix:@"NS"] || [className hasPrefix:@"__NS"] || [className hasPrefix:@"OS_xpc"]) {
        isSystem = YES;
        return isSystem;
    }
    NSBundle *mainBundle = [NSBundle bundleForClass:cls];
    if (mainBundle == [NSBundle mainBundle]) {
        isSystem = NO;
    }else{
        isSystem = YES;
    }
    return isSystem;
}

@end
