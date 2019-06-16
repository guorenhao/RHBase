//
//  RHBTableViewController.h
//
//  Created by Abner_G on 2017/9/5.
//  Copyright © 2018年 Abner_G. All rights reserved.
//

#import "RHBViewController.h"
#import "RHBTableViewControllerProtocol.h"
#import "RHBTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface RHBTableViewController : RHBViewController <RHBTableViewControllerProtocol, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArr;


@end

NS_ASSUME_NONNULL_END
