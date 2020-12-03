//
//  KVO1ViewController.m
//  UnCrashDemo001
//
//  Created by yan on 2020/8/31.
//  Copyright © 2020 yan. All rights reserved.
//

#import "KVO1ViewController.h"
#import "Person.h"

@interface KVO1ViewController ()

/// Person
@property (nonatomic, strong) Person *per;

@end

@implementation KVO1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    
    // Do any additional setup after loading the view.
    self.per = [[Person alloc] init];
    [self.per addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self.per addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)createUI {
    self.title = @"add次数大于remove次数";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"keyPath == %@",keyPath);
    NSLog(@"object == %@",object);
    NSLog(@"change == %@",change);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.per.name = @"123";
}

@end
