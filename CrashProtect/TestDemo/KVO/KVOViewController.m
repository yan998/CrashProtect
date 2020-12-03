//
//  KVOViewController.m
//  UnCrashDemo001
//
//  Created by yan on 2020/8/31.
//  Copyright © 2020 yan. All rights reserved.
//

#import "KVOViewController.h"
#import "KVO1ViewController.h"
#import "KVO2ViewController.h"
#import "KVO3ViewController.h"
#import "KVO4ViewController.h"
#import "KVO5ViewController.h"
#import "KVO6ViewController.h"
#import "Person.h"

@interface KVOViewController ()

/// Person
@property (nonatomic, strong) Person *per;

@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.per = [[Person alloc] init];
    [self createUI];
    [self createData];
}

- (void)createUI {
    self.title = @"KVO相关崩溃";
}

- (void)createData {
    NSArray *array = @[@"KVO add次数大于remove次数",@"add次数小于remove次数",@"没有实现observer方法",@"remove未注册的keyPath",@"注册重复的keyPath",@"添加的keyPath为空",@"删除的keyPath为空",@"被观察者已经挂了，但是还注册着KVO",@"监听对象为空"];
    [self.dataSource addObjectsFromArray:array];
    [self.myTableView reloadData];
}

#pragma mark- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = self.dataSource[indexPath.row];
    if ([text isEqualToString:@"KVO add次数大于remove次数"]) {
        KVO1ViewController *kvoVC = [[KVO1ViewController alloc] init];
        [self.navigationController pushViewController:kvoVC animated:YES];
        
    } else if ([text isEqualToString:@"add次数小于remove次数"]) {
        KVO2ViewController *kvoVC = [[KVO2ViewController alloc] init];
        [self.navigationController pushViewController:kvoVC animated:YES];
        
    } else if ([text isEqualToString:@"没有实现observer方法"]) {
        KVO3ViewController *kvoVC = [[KVO3ViewController alloc] init];
        [self.navigationController pushViewController:kvoVC animated:YES];
        
    } else if ([text isEqualToString:@"remove未注册的keyPath"]) {
        KVO4ViewController *kvoVC = [[KVO4ViewController alloc] init];
        [self.navigationController pushViewController:kvoVC animated:YES];
    } else if ([text isEqualToString:@"注册重复的keyPath"]) {
        KVO5ViewController *kvoVC = [[KVO5ViewController alloc] init];
        [self.navigationController pushViewController:kvoVC animated:YES];
    } else if ([text isEqualToString:@"添加的keyPath为空"]) {
        
        [self.per addObserver:self forKeyPath:@"" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        
    } else if ([text isEqualToString:@"删除的keyPath为空"]) {
        
        [self.per removeObserver:self forKeyPath:@""];
        
    } else if ([text isEqualToString:@"被观察者已经挂了，但是还注册着KVO"]) {
        KVO6ViewController *kvoVC = [[KVO6ViewController alloc] init];
        [self.navigationController pushViewController:kvoVC animated:YES];
    } else if ([text isEqualToString:@"监听对象为空"]) {
        [self.per addObserver:nil forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
}


@end
