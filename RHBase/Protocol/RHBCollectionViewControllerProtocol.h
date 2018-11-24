//
//  RHBCollectionViewControllerProtocol.h
//
//  Created by Abner_G on 2017/9/5.
//  Copyright © 2018年 Abner_G. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHBModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RHBCollectionViewControllerProtocol <NSObject>

@optional

- (void)registerCells:(NSArray<NSString *> *)cellArr;

- (void)reloadData;

- (void)dropDownRefresh;

- (void)dropUpGetMore;

- (void)removeRefreshHeader;

- (void)removeRefreshFooter;

- (void)endRefreshing;

- (void)emptyDataAction;

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath model:(RHBModel *)model;


@end

NS_ASSUME_NONNULL_END
