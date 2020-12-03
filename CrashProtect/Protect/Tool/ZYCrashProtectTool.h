//
//  ZYCrashProtectTool.h
//  UnCrashDemo001
//
//  Created by yan on 2020/12/2.
//  Copyright © 2020 yan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString * ZYUnCrashType;

/// UnRecognizedSelector防护
extern ZYUnCrashType const _Nullable UnCrashSelector;
/// KVO防护
extern ZYUnCrashType const _Nullable UnCrashKVO;
/// 数组防护
extern ZYUnCrashType const _Nullable UnCrashArray;
/// 字典防护
extern ZYUnCrashType const _Nullable UnCrashDictionary;
/// 字符串防护
extern ZYUnCrashType const _Nullable UnCrashString;
/// NSTimer避免循环引用
extern ZYUnCrashType const _Nullable UnCrashTimer;

NS_ASSUME_NONNULL_BEGIN

@interface ZYCrashProtectTool : NSObject


/// 设置所有的类型开启防护
+ (void)configAllProtectTypes;

/// 设置防护类型
/// @param types 防护类型
+ (void)configProtectTypes:(NSArray<ZYUnCrashType> *)types;


@end

NS_ASSUME_NONNULL_END
