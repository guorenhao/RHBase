//
//  RHBTableViewControllerProtocol.h
//
//  Created by Abner_G on 2017/9/5.
//  Copyright © 2018年 Abner_G. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHBModel.h"
#import "RHBUtils.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RHBTableViewControllerProtocol <NSObject>

@optional

- (void)updateTableConstraint:(RHConstraintAttribute)attribute value:(CGFloat)value;

- (NSArray <NSString *>*)registerCells;

- (void)reloadData;

- (void)dropDownRefresh;

- (void)dropUpGetMore;

- (void)removeRefreshHeader;

- (void)removeRefreshFooter;

- (void)endRefreshing;

- (void)emptyDataAction;

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath model:(RHBModel *)model;

@end

NS_ASSUME_NONNULL_END
