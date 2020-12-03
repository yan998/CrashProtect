//
//  NSTimer+UnCrashNSTimerProtector.m
//  UnCrashDemo001
//
//  Created by yan on 2020/12/1.
//  Copyright © 2020 yan. All rights reserved.
//

#import "NSTimer+UnCrashNSTimerProtector.h"
#import "NSObject+UnCrashTool.h"
#import "UnCrashNSTimerProxy.h"

@implementation NSTimer (UnCrashNSTimerProtector)

+ (void)unCrash_protectorSwizzleMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [self unCrashTool_swizzleClassMethodImplementation:[self class] originSelector:@selector(scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:) swizzledSelector:@selector(unCrash_scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:)];
    });
}

+ (NSTimer *)unCrash_scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo {
    if (yesOrNo && aTarget) {
        UnCrashNSTimerProxy *proxy = [[UnCrashNSTimerProxy alloc] initWithObjc:aTarget];
        NSTimer *timer = [self unCrash_scheduledTimerWithTimeInterval:ti target:proxy selector:aSelector userInfo:userInfo repeats:yesOrNo];
        __weak __block NSTimer *tempTimer = timer;
        proxy.deallocBlock = ^{
            [tempTimer invalidate];
            tempTimer = nil;
        };
        return timer;
    } else {
        return [self unCrash_scheduledTimerWithTimeInterval:ti target:aTarget selector:aSelector userInfo:userInfo repeats:yesOrNo];
    }
}

@end

