//
//  NSStringViewController.m
//  UnCrashDemo001
//
//  Created by yan on 2020/9/2.
//  Copyright © 2020 yan. All rights reserved.
//

#import "NSStringViewController.h"

@interface NSStringViewController ()

@end

@implementation NSStringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.dataSource addObjectsFromArray:@[@" --- substringFromIndex ---",
                                           @"__NSCFConstantString substringFromIndex",
                                           @"__NSCFString substringFromIndex",
                                           @"NSTaggedPointerString substringFromIndex",
                                           @"NSMutableString substringFromIndex",
                                           
                                           @" --- substringToIndex ---",
                                           @"__NSCFConstantString substringToIndex",
                                           @"__NSCFString substringToIndex",
                                           @"NSTaggedPointerString substringToIndex",
                                           @"NSMutableString substringToIndex",
                                           
                                           @" --- substringToIndex ---",
                                           @"__NSCFConstantString substringWithRange",
                                           @"__NSCFString substringWithRange",
                                           @"NSTaggedPointerString substringWithRange",
                                           @"NSMutableString substringWithRange"]];
    [self.myTableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str = self.dataSource[indexPath.row];
    
    // __NSCFConstantString
    NSString *str1 = @"";
    // __NSCFString
    NSString *str2 = [NSString stringWithFormat:@"1nxjsaxnajkxnajxsnaxj"];
    // NSTaggedPointerString
    NSString *str3 = [NSString stringWithFormat:@"1"];
    // NSMutableString
    NSMutableString *str4 = [[NSMutableString alloc] initWithString:@"12121211212"];
    
    if ([str isEqualToString:@"__NSCFConstantString substringFromIndex"]) {
        [str1 substringFromIndex:101];
    } else if ([str isEqualToString:@"__NSCFString substringFromIndex"]) {
        [str2 substringFromIndex:100];
    } else if ([str isEqualToString:@"NSTaggedPointerString substringFromIndex"]) {
        [str3 substringFromIndex:101];
    } else if ([str isEqualToString:@"NSMutableString substringFromIndex"]) {
        [str4 substringFromIndex:101];
    }
    
    else if ([str isEqualToString:@"__NSCFConstantString substringToIndex"]) {
        [str1 substringToIndex:10];
    } else if ([str isEqualToString:@"__NSCFString substringToIndex"]) {
        [str2 substringToIndex:100];
    } else if ([str isEqualToString:@"NSTaggedPointerString substringToIndex"]) {
        [str3 substringToIndex:10];
    } else if ([str isEqualToString:@"NSMutableString substringToIndex"]) {
        [str4 substringToIndex:101];
    }
    
    else if ([str isEqualToString:@"__NSCFConstantString substringWithRange"]) {
        [str1 substringWithRange:NSMakeRange(0, 101)];
    } else if ([str isEqualToString:@"__NSCFString substringWithRange"]) {
        [str2 substringWithRange:NSMakeRange(0, 101)];
    } else if ([str isEqualToString:@"NSTaggedPointerString substringWithRange"]) {
        [str3 substringWithRange:NSMakeRange(0, 101)];
    } else if ([str isEqualToString:@"NSMutableString substringWithRange"]) {
        [str4 substringWithRange:NSMakeRange(0, 100)];
    }
}

@end
