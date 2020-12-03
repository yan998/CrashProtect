//
//  KVO3ViewController.m
//  UnCrashDemo001
//
//  Created by yan on 2020/8/31.
//  Copyright © 2020 yan. All rights reserved.
//

#import "KVO3ViewController.h"
#import "Person.h"

@interface KVO3ViewController ()

/// Person
@property (nonatomic, strong) Person *per;

@end

@implementation KVO3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    
    // Do any additional setup after loading the view.
    self.per = [[Person alloc] init];
    [self.per addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)createUI {
    self.title = @"remove次数大于add次数";
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.per.name = @"123";
}

- (void)dealloc {
    [self.per removeObserver:self forKeyPath:@"name"];
}

@end
