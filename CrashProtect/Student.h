//
//  Student.h
//  UnCrashDemo001
//
//  Created by yan on 2020/8/27.
//  Copyright © 2020 yan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol StudentDelegate <NSObject>

- (void)showStudentName;
+ (void)printStudentName;

@end

@interface Student : NSObject

@end

NS_ASSUME_NONNULL_END
