//
//  SuperViewController.h
//  UnCrashDemo001
//
//  Created by yan on 2020/8/31.
//  Copyright © 2020 yan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SuperViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

/// dataSource
@property (nonatomic, strong) NSMutableArray *dataSource;
/// UITableView
@property (nonatomic, strong) UITableView *myTableView;

@end

NS_ASSUME_NONNULL_END
