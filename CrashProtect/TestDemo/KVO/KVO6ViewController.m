//
//  KVO6ViewController.m
//  UnCrashDemo001
//
//  Created by yan on 2020/8/31.
//  Copyright © 2020 yan. All rights reserved.
//

#import "KVO6ViewController.h"
#import "Person.h"

@interface KVO6ViewController ()

/// <#注释#>
@property (nonatomic, strong) Person *per;

@end

@implementation KVO6ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    self.per = [[Person alloc] init];
    // Do any additional setup after loading the view.
    [self.per addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self.per addObserver:self forKeyPath:@"height" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    self.per.name = @"123";
    self.per = nil;
}

- (void)createUI {
    self.title = @"被观察者已经挂了，但是还注册着KVO";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"keyPath == %@",keyPath);
    NSLog(@"object == %@",object);
    NSLog(@"change == %@",change);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [Person share].name = @"张三";
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}


@end
