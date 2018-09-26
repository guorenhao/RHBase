//
//  RHBCollectionViewController.h
//
//  Created by Abner_G on 2017/9/5.
//  Copyright © 2018年 Abner_G. All rights reserved.
//

#import "RHBViewController.h"
#import "RHBCollectionViewControllerProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface RHBCollectionViewController : RHBViewController <RHBCollectionViewControllerProtocol, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView * collection;
@property (nonatomic, strong) NSMutableArray * dataArr;

@property (nonatomic, assign) CGFloat minLineSpacing;
@property (nonatomic, assign) CGFloat minInteritemSpacing;
@property (nonatomic, assign) UIEdgeInsets sectionInset;

@end

NS_ASSUME_NONNULL_END