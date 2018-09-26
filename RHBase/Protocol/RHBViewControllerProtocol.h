//
//  RHBViewControllerProtocol.h
//
//  Created by Abner_G on 2017/9/5.
//  Copyright © 2018年 Abner_G. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RHBViewControllerProtocol <NSObject>

@optional
- (void)setNavigation;

- (void)initBaseData;

- (void)addSubviews;

- (void)makeConstraintsForUI;

- (void)loadCacheData;

- (void)loadData;

- (void)keyboardWillShow:(CGFloat)height;

- (void)keyboardWillHide;

- (void)judgeEmptyDataWithTableView:(UITableView *)tableView;

- (void)judgeEmptyDataWithCollectionView:(UICollectionView *)collection;

@end

NS_ASSUME_NONNULL_END
