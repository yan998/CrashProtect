//
//  UnCrashToolReminder.h
//  UnCrashDemo001
//
//  Created by yan on 2020/8/28.
//  Copyright © 2020 yan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, UnCrashShowType) {
    UnCrashShowTypeCrash,       // 会出现crash
    UnCrashShowTypeWarning      // 警告
};

/// 防崩溃异常信息提示
@interface UnCrashToolReminder : NSObject

/// 上报crash
/// @param exception exception
+ (void)reminderExcepition:(NSException *)exception;

/// 上报警告
/// @param exception exception
+ (void)reminderWarningExcepition:(NSException *)exception;


@end

NS_ASSUME_NONNULL_END
