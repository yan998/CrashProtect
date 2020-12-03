//
//  UnRecognizedSelectorViewController.m
//  UnCrashDemo001
//
//  Created by yan on 2020/8/31.
//  Copyright © 2020 yan. All rights reserved.
//

#import "UnRecognizedSelectorViewController.h"
#import "Person.h"
@interface UnRecognizedSelectorViewController ()

@end

@implementation UnRecognizedSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.dataSource addObjectsFromArray:@[@"对象方法没有实现",@"类方法没有实现"]];
    [self.myTableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str = self.dataSource[indexPath.row];
    if ([str isEqualToString:@"对象方法没有实现"]) {
        Person *per = [[Person alloc] init];
        [per run];
    } else if ([str isEqualToString:@"类方法没有实现"]) {
        [Person printStudentName];
    }
}



@end
