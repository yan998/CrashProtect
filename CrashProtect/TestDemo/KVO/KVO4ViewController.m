//
//  KVO4ViewController.m
//  UnCrashDemo001
//
//  Created by yan on 2020/8/31.
//  Copyright © 2020 yan. All rights reserved.
//

#import "KVO4ViewController.h"
#import "Person.h"

@interface KVO4ViewController ()

/// Person
@property (nonatomic, strong) Person *per;

@end

@implementation KVO4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    
    // Do any additional setup after loading the view.
    self.per = [[Person alloc] init];
}

- (void)createUI {
    self.title = @"remove未注册的keyPath";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)dealloc {
    [self.per removeObserver:self forKeyPath:@"name"];
}

@end
