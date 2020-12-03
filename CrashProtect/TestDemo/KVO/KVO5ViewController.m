//
//  KVO5ViewController.m
//  UnCrashDemo001
//
//  Created by yan on 2020/8/31.
//  Copyright © 2020 yan. All rights reserved.
//

#import "KVO5ViewController.h"
#import "Person.h"

@interface KVO5ViewController ()

/// Person
@property (nonatomic, strong) Person *per;

@end

@implementation KVO5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    
    // Do any additional setup after loading the view.
    self.per = [[Person alloc] init];
    [self.per addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self.per addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)createUI {
    self.title = @"注册重复的keyPath";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.per.name = @"123";
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"keyPath = %@",keyPath);
    NSLog(@"object = %@",object);
    NSLog(@"change = %@",change);
}

- (void)dealloc {
    [self.per removeObserver:self forKeyPath:@"name"];
    [self.per removeObserver:self forKeyPath:@"name"];
}


@end
