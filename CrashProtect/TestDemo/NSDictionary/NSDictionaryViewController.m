//
//  NSDictionaryViewController.m
//  UnCrashDemo001
//
//  Created by yan on 2020/9/3.
//  Copyright © 2020 yan. All rights reserved.
//

#import "NSDictionaryViewController.h"

@interface NSDictionaryViewController ()

@end

@implementation NSDictionaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    
    
//    [NSDictionary alloc] initWithDictionary:<#(nonnull NSDictionary *)#>
//    [NSMutableDictionary alloc] initWithDictionary:<#(nonnull NSDictionary *)#>
    // Do any additional setup after loading the view.
    [self.dataSource addObjectsFromArray:@[@" --- initWithDictionary ---",
                                           @"NSMutableDictionary initWithDictionary",
                                           @"NSDictionary initWithDictionary",
                                           
                                           @" --- NSMutableDictionary dic[nil] = @\"123\" ---",
                                           @"NSDictionary dic[nil] = @\"123\"",
                                           
                                           @" --- setObject:forKey: ---",
                                           @"NSMutableDictionary setObject:forKey:  value为空",
                                           @"NSMutableDictionary setObject:forKey:  key为空",
                                           
                                           @" --- setValue:forKey: ---",
                                           @"NSMutableDictionary setValue:forKey:  key为空",
                                           
                                           @" --- removeObjectForKey ---",
                                           @"NSMutableDictionary removeObjectForKey:",
                                           @"NSMutableDictionary removeObjectForKeys:"]];
    [self.myTableView reloadData];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str = self.dataSource[indexPath.row];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    if ([str isEqualToString:@"NSMutableDictionary initWithDictionary"]) {
        [[NSMutableDictionary alloc] initWithDictionary:@""];
    } else if ([str isEqualToString:@"NSDictionary initWithDictionary"]) {
        [[NSDictionary alloc] initWithDictionary:@""];
    }
    
    else if ([str isEqualToString:@"NSDictionary dic[nil] = @\"123\""]) {
        NSString *key = nil;
        dic[key] = @"123";
    }
    
    else if ([str isEqualToString:@"NSMutableDictionary setObject:forKey:  value为空"]) {
        [dic setObject:nil forKey:@"123"];
    } else if ([str isEqualToString:@"NSMutableDictionary setObject:forKey:  key为空"]) {
        [dic setObject:@"123" forKey:nil];
    }
    
    else if ([str isEqualToString:@"NSMutableDictionary setValue:forKey:  key为空"]) {
        [dic setValue:nil forKey:nil];
    }
    
    else if ([str isEqualToString:@"NSMutableDictionary removeObjectForKey:"]) {
        [dic removeObjectForKey:nil];
    }
    
    else if ([str isEqualToString:@"NSMutableDictionary removeObjectForKeys:"]) {
        [dic removeObjectsForKeys:@""];
    }
    
    
}


@end
