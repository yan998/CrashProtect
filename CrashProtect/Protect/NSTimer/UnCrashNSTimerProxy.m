//
//  UnCrashNSTimerProxy.m
//  UnCrashDemo001
//
//  Created by yan on 2020/12/1.
//  Copyright © 2020 yan. All rights reserved.
//

#import "UnCrashNSTimerProxy.h"

@interface UnCrashNSTimerProxy()

@property (nonatomic, weak) id object;

@end

@implementation UnCrashNSTimerProxy

- (instancetype)initWithObjc:(id)object {
    self.object = object;
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    if (self.object == nil) {
        // 这个时候object已经被销毁了
        if (self.deallocBlock) {
            self.deallocBlock();
        }
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [self.object methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    if ([self.object respondsToSelector:invocation.selector]) {
        [invocation invokeWithTarget:self.object];
    }
}

@end
