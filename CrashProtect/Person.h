//
//  Person.h
//  UnCrashDemo001
//
//  Created by yan on 2020/8/27.
//  Copyright © 2020 yan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject<StudentDelegate>

+ (instancetype)share;

/// name
@property (nonatomic, strong) NSString *name;
- (void)run;


@end

NS_ASSUME_NONNULL_END
