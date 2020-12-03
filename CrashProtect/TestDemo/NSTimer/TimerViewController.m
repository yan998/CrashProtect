//
//  TimerViewController.m
//  UnCrashDemo001
//
//  Created by yan on 2020/9/3.
//  Copyright © 2020 yan. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"点击返回我能正常销毁";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 300, 100);
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"点我开启一个定时器" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:btn];
    
}


- (void)clickBtn:(UIButton *)sender {
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timeFunc:) userInfo:@"123" repeats:YES];
}

- (void)timeFunc:(NSTimer *)timer {
    NSLog(@"userInfo == %@",timer.userInfo);
}

- (void)dealloc {
    NSLog(@"正常释放 -- %s",__func__);
}


@end
