//
//  RHBCollectionViewController.m
//
//  Created by Abner_G on 2017/9/5.
//  Copyright © 2018年 Abner_G. All rights reserved.
//

#import "RHBCollectionViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "Masonry.h"
#import "RHBCollectionViewCell.h"

@interface RHBCollectionViewController ()

@property (nonatomic, strong) NSMutableArray * cellArr;

@end

@implementation RHBCollectionViewController

- (void)viewDidLoad {
    [self addCollectionView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - add collectionView

- (void)addCollectionView {
    
    [self.view addSubview:self.collection];
//    [self judgeEmptyDataWithCollectionView:self.collection];
    [self makeConstraintsForCollectionView];
}

#pragma mark - make constraints

- (void)makeConstraintsForCollectionView {
    
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_offset(0);
        make.right.mas_offset(0);
    }];
    [self addMj_header];
    [self addMj_footer];
}

#pragma mark - protocol

- (void)registerCells:(NSArray<NSString *> *)cellArr {
    
    [self.cellArr removeAllObjects];
    for (NSString * clsStr in cellArr) {
        
        [self.cellArr addObject:clsStr];
        [self.collection registerClass:NSClassFromString(clsStr) forCellWithReuseIdentifier:clsStr];
    }
}

- (void)reloadData {
    
    [self.collection reloadData];
    [self judgeEmptyDataWithCollectionView:self.collection];
}

- (void)dropDownRefresh {
    
}

- (void)dropUpGetMore {
    
}

- (void)removeRefreshHeader {
    
    if (self.collection.mj_header) {
        
        self.collection.mj_header = nil;
    }
}

- (void)removeRefreshFooter {
    
    if (self.collection.mj_footer) {
        
        self.collection.mj_footer = nil;
    }
}

- (void)endRefreshing {
    
    [self.collection.mj_header endRefreshing];
    [self.collection.mj_footer endRefreshing];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath model:(RHBModel *)model {
    
}

#pragma mark - refresh

- (void)addMj_header {
    
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.collection.mj_footer) {
            
            [strongSelf.collection.mj_footer resetNoMoreData];
        }
        [strongSelf dropDownRefresh];
    }];
    self.collection.mj_header = header;
}

- (void)addMj_footer {
    
    __weak typeof(self) weakSelf = self;
    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf dropUpGetMore];
    }];
    self.collection.mj_footer = footer;
}

#pragma mark - collection dataSource and delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * cellIdentifier = NSStringFromClass(RHBCollectionViewCell.class);
    if (self.cellArr.count > 0) {
        
        cellIdentifier = self.cellArr.firstObject;
    }
    RHBCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (indexPath.row < self.dataArr.count) {
        
        RHBModel * model = [self.dataArr objectAtIndex:indexPath.row];
        [cell configCellWithModel:model indexPath:indexPath];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RHBModel * model = [self.dataArr objectAtIndex:indexPath.row];
    return model.itemSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return self.minLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return self.minInteritemSpacing;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return self.sectionInset;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RHBModel * model = [self.dataArr objectAtIndex:indexPath.row];
    [self collectionView:collectionView didSelectItemAtIndexPath:indexPath model:model];
}

#pragma mark - setter and getter

- (UICollectionView *)collection {
    
    if (!_collection) {
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView * collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collection.backgroundColor = [UIColor whiteColor];
        collection.delegate = self;
        collection.dataSource = self;
        [collection registerClass:RHBCollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(RHBCollectionViewCell.class)];
        _collection = collection;
    }
    return _collection;
}

- (NSMutableArray *)dataArr {
    
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray new];
    }
    return _dataArr;
}

- (NSMutableArray *)cellArr {
    
    if (!_cellArr) {
        
        _cellArr = [NSMutableArray new];
    }
    return _cellArr;
}


@end
