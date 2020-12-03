//
//  ViewController.m
//  UnCrashDemo001
//
//  Created by yan on 2020/8/27.
//  Copyright © 2020 yan. All rights reserved.
//

#import "ViewController.h"
#import "KVOViewController.h"
#import "UnRecognizedSelectorViewController.h"
#import "NSArrayViewController.h"
#import "NSStringViewController.h"
#import "NSDictionaryViewController.h"
#import "TimerViewController.h"
#import "ZYCrashProtectTool.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [ZYCrashProtectTool configAllProtectTypes];
//    [ZYCrashProtectTool configProtectTypes:@[UnCrashSelector]];
    
    [self createUI];
    [self createData];
}

- (void)createUI {
    self.title = @"崩溃容错";
}

- (void)createData {
    NSArray *array = @[@"KVO",@"unRecognized Selector",@"NSArray",@"NSString",@"NSDictionary",@"NSTimer循环引用"];
    [self.dataSource addObjectsFromArray:array];
    [self.myTableView reloadData];
}

#pragma mark- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = self.dataSource[indexPath.row];
    if ([text isEqualToString:@"KVO"]) {
        KVOViewController *kvoVC = [[KVOViewController alloc] init];
        [self.navigationController pushViewController:kvoVC animated:YES];
        
    } else if ([text isEqualToString:@"unRecognized Selector"]) {
        UnRecognizedSelectorViewController *vc = [[UnRecognizedSelectorViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([text isEqualToString:@"NSArray"]) {
        NSArrayViewController *vc = [[NSArrayViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([text isEqualToString:@"NSString"]) {
        NSStringViewController *vc = [[NSStringViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([text isEqualToString:@"NSDictionary"]) {
        NSDictionaryViewController *vc = [[NSDictionaryViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([text isEqualToString:@"NSTimer循环引用"]) {
        TimerViewController *vc = [[TimerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
