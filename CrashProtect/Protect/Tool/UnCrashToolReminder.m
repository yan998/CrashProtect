//
//  UnCrashToolReminder.m
//  UnCrashDemo001
//
//  Created by yan on 2020/8/28.
//  Copyright © 2020 yan. All rights reserved.
//

#import "UnCrashToolReminder.h"
#import "UnCrashKVOProxy.h"

@implementation UnCrashToolReminder


/// 上报crash
/// @param exception exception
+ (void)reminderExcepition:(NSException *)exception {
    [self reminderExcepitionAndShow:exception type:UnCrashShowTypeCrash];
}

/// 上报警告
/// @param exception exception
+ (void)reminderWarningExcepition:(NSException *)exception {
    [self reminderExcepitionAndShow:exception type:UnCrashShowTypeWarning];
}

+ (void)reminderExcepitionAndShow:(NSException *)exception type:(UnCrashShowType)type {
    

    // 获取在哪个类的哪个方法中实例化的数组  字符串格式 -[类名 方法名]  或者 +[类名 方法名]
    NSString *mainCallStackSymbolMsg = @"";
    
    NSString *name = exception.name;
    // 因为KVO已经有相关信息了
    if (!([name isEqualToString:kUnCrashKVOErrorCrash] || [name isEqualToString:kUnCrashKVOErrorWaring])) {
        // 获取堆栈信息
        // 堆栈数据
        NSArray *callStackSymbolsArr = [NSThread callStackSymbols];
        mainCallStackSymbolMsg = [NSString stringWithFormat:@"当前触发位置%@",[self getMainCallStackSymbolMessageWithCallStackSymbols:callStackSymbolsArr]];
    }
    
    if (type == UnCrashShowTypeCrash) {
        name = [NSString stringWithFormat:@"💣%@💣",name];
    } else {
        name = [NSString stringWithFormat:@"⚠️%@⚠️",name];
    }
    NSString *reason = exception.reason;
    reason = [reason stringByReplacingOccurrencesOfString:@"unCrash_" withString:@""];
    
    
    reason = [NSString stringWithFormat:@"%@\n\n%@",reason,mainCallStackSymbolMsg];
    
    // 将报错位置上传到服务器
    [self uploadMessageToServerTitle:name message:reason];
    
#if DEBUG
    [self debugAlertTitle:name message:reason];
    
    NSLog(@"\n%@\n原因：%@",name,reason);
#else
#endif
    
}

+ (void)debugAlertTitle:(NSString *)title message:(NSString *)message {
    // 添加弹窗信息提示
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:action];
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window.rootViewController presentViewController:alertVC animated:YES completion:nil];
}

/// 将报错信息上传到服务器
+ (void)uploadMessageToServerTitle:(NSString *)title message:(NSString *)message {
    
}

/**
 简化堆栈信息

 @param callStackSymbols 详细堆栈信息
 @return 简化之后的堆栈信息
 */
+ (NSString *)getMainCallStackSymbolMessageWithCallStackSymbols:(NSArray<NSString *> *)callStackSymbols
{
    // mainCallStackSymbolMsg的格式为   +[类名 方法名]  或者 -[类名 方法名]
    __block NSString *mainCallStackSymbolMsg = nil;
    
    // 匹配出来的格式为 +[类名 方法名]  或者 -[类名 方法名]
    NSString *regularExpStr = @"[-\\+]\\[.+\\]";
    
    
    NSRegularExpression *regularExp = [[NSRegularExpression alloc] initWithPattern:regularExpStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    for (int index = 2; index < callStackSymbols.count; index++) {
        
        NSString *callStackSymbol = callStackSymbols[index];
        [regularExp enumerateMatchesInString:callStackSymbol
                                     options:NSMatchingReportProgress
                                       range:NSMakeRange(0, callStackSymbol.length)
                                  usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
                                      
                                      if (result) {
                                          NSString *tempCallStackSymbolMsg = [callStackSymbol substringWithRange:result.range];

                                          NSString *className = [tempCallStackSymbolMsg componentsSeparatedByString:@" "].firstObject;
                                          className           = [className componentsSeparatedByString:@"["].lastObject;
                                          
                                          NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(className)];
                                          if (![className hasSuffix:@")"] && bundle == [NSBundle mainBundle]) {
                                              mainCallStackSymbolMsg = tempCallStackSymbolMsg;
                                              
                                          }
                                          *stop = YES;
                                      }
                                      
                                  }];
        
        if (mainCallStackSymbolMsg.length) break;
        
    }
    
    return mainCallStackSymbolMsg;
}


@end
