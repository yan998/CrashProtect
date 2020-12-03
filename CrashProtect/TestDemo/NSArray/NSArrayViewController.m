//
//  NSArrayViewController.m
//  UnCrashDemo001
//
//  Created by yan on 2020/9/1.
//  Copyright © 2020 yan. All rights reserved.
//

#import "NSArrayViewController.h"

@interface NSArrayViewController ()

@end

@implementation NSArrayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    //    [array removeObjectsInRange:NSMakeRange(0, 0)];
    //    array subarrayWithRange:<#(NSRange)#>
    
    //    [NSArray arrayWithArray:@"123"];
    //    NSMutableArray arrayWithArray:<#(nonnull NSArray<ObjectType> *)#>
    
    [self.dataSource addObjectsFromArray:@[@" --- arrayWithArray --- ",
                                           @"NSArray arrayWithArray:",
                                           @"__NSArrayM arrayWithArray:",
                                           
                                           @" --- [array objectAtIndex:3] 这种形式获取--- ",
                                           @"__NSArray0  objectAtIndex 越界",
                                           @"__NSSingleObjectArrayI  objectAtIndex 越界",
                                           @"__NSArrayI  objectAtIndex 越界",
                                           @"__NSArrayM  objectAtIndex 越界",
                                           
                                           @" --- array[3] 这种形式获取--- ",
                                           @"__NSArray0  objectAtIndexedSubscript 越界",
                                           @"__NSSingleObjectArrayI  objectAtIndexedSubscript 越界",
                                           @"__NSArrayI  objectAtIndexedSubscript 越界",
                                           @"__NSArrayM  objectAtIndexedSubscript 越界",
                                           
                                           @" --- subarrayWithRange 这种形式获取 --- ",
                                           @"__NSArrayI  subarrayWithRange 越界",
                                           @"__NSArrayM  subarrayWithRange 越界",
                                           
                                           @" --- insertObject:atIndex: --- ",
                                           @"__NSArrayM insertObject:atIndex: object为空",
                                           @"__NSArrayM insertObject:atIndex: index越界",
                                           
                                           @" --- removeObjectAtIndex: --- ",
                                           @"__NSArrayM removeObjectAtIndex: index越界",
                                           
                                           @" --- removeObjectsInRange: --- ",
                                           @"__NSArrayM removeObjectsInRange: Range越界"]];
    [self.myTableView reloadData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str = self.dataSource[indexPath.row];
    NSArray *array1 = [[NSArray alloc] init];
    NSArray *array2 = @[@"1"];
    NSArray *array3 = @[@"1",@"2"];
    NSMutableArray *array4 = [[NSMutableArray alloc] initWithArray:@[@1,@2]];
    
    if ([str isEqualToString:@"NSArray arrayWithArray:"]) {
        [NSArray arrayWithArray:@"123"];
    } else if ([str isEqualToString:@"__NSArrayM arrayWithArray:"]) {
        [NSMutableArray arrayWithArray:@"123"];
    }
    
    else if ([str isEqualToString:@"__NSArray0  objectAtIndex 越界"]) {
        [array1 objectAtIndex:3];
    } else if ([str isEqualToString:@"__NSSingleObjectArrayI  objectAtIndex 越界"]) {
        [array2 objectAtIndex:3];
    } else if ([str isEqualToString:@"__NSArrayI  objectAtIndex 越界"]) {
        [array3 objectAtIndex:3];
    } else if ([str isEqualToString:@"__NSArrayM  objectAtIndex 越界"]) {
        [array4 objectAtIndex:3];
    }
    
    else if ([str isEqualToString:@"__NSArray0  objectAtIndexedSubscript 越界"]) {
        array1[3];
    } else if ([str isEqualToString:@"__NSSingleObjectArrayI  objectAtIndexedSubscript 越界"]) {
        array2[3];
    } else if ([str isEqualToString:@"__NSArrayI  objectAtIndexedSubscript 越界"]) {
        array3[3];
    } else if ([str isEqualToString:@"__NSArrayM  objectAtIndexedSubscript 越界"]) {
        array4[3];
    }
    
    else if([str isEqualToString:@"__NSArrayI  subarrayWithRange 越界"]){
        [array3 subarrayWithRange:NSMakeRange(0, 3)];
    } else if([str isEqualToString:@"__NSArrayM  subarrayWithRange 越界"]){
        [array4 subarrayWithRange:NSMakeRange(0, 3)];
    }
    
    
    else if ([str isEqualToString:@"__NSArrayM insertObject:atIndex: object为空"]) {
        [array4 insertObject:nil atIndex:1];
    } else if ([str isEqualToString:@"__NSArrayM insertObject:atIndex: index越界"]) {
        [array4 insertObject:@3 atIndex:3];
    }
    
    else if ([str isEqualToString:@"__NSArrayM removeObjectAtIndex: index越界"]) {
        [array4 removeObjectAtIndex:3];
    }
    
    else if ([str isEqualToString:@"__NSArrayM removeObjectsInRange: Range越界"]) {
        [array4 removeObjectsInRange:NSMakeRange(1, 3)];
    }
}


@end
