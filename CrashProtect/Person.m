//
//  Person.m
//  UnCrashDemo001
//
//  Created by yan on 2020/8/27.
//  Copyright © 2020 yan. All rights reserved.
//

#import "Person.h"
#import "Student.h"

@implementation Person

+ (instancetype)share {
    static Person *per = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        per = [[Person alloc] init];
    });
    return per;
}

//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    return [super resolveInstanceMethod:sel];
//}
//
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    id temp = [super forwardingTargetForSelector:aSelector];
//    return temp;
//}
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//    NSMethodSignature *methodSignature = [super methodSignatureForSelector:aSelector];
//    return methodSignature;
//}
//
//+ (void)forwardInvocation:(NSInvocation *)anInvocation {
//    
//}

@end
