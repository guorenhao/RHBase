//
//  RHBCollectionViewController.m
//
//  Created by Abner_G on 2017/9/5.
//  Copyright © 2018年 Abner_G. All rights reserved.
//

#import "RHBCollectionViewController.h"
#import <MJRefresh/MJRefresh.h>

@interface RHBCollectionViewController () <RHEmptyViewDelegate>

@property (nonatomic) NSLayoutConstraint *collectionTopConstraint;
@property (nonatomic) NSLayoutConstraint *collectionLeftConstraint;
@property (nonatomic) NSLayoutConstraint *collectionBottomConstraint;
@property (nonatomic) NSLayoutConstraint *collectionRightConstraint;

@property (nonatomic, strong) NSMutableArray * cellArr;
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;
@end

@implementation RHBCollectionViewController

- (instancetype)initWithScrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    
    self = [super init];
    if (self) {
        
        self.scrollDirection = scrollDirection;
    }
    return self;
}

- (instancetype)init {
    
    return [[[self class] alloc] initWithScrollDirection:UICollectionViewScrollDirectionVertical];
}

- (void)viewDidLoad {
    [self addCollectionView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - add collectionView

- (void)addCollectionView {
    
    [self.view addSubview:self.collection];
    self.emptyView.delegate = self;
//    [self judgeEmptyDataWithCollectionView:self.collection];
    [self makeConstraintsForCollectionView];
}

#pragma mark - make constraints

- (void)makeConstraintsForCollectionView {
    
    self.collectionTopConstraint = [NSLayoutConstraint constraintWithItem:self.collection attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    self.collectionLeftConstraint = [NSLayoutConstraint constraintWithItem:self.collection attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    self.collectionBottomConstraint = [NSLayoutConstraint constraintWithItem:self.collection attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    self.collectionRightConstraint = [NSLayoutConstraint constraintWithItem:self.collection attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    [self.view addConstraint:self.collectionTopConstraint];
    [self.view addConstraint:self.collectionLeftConstraint];
    [self.view addConstraint:self.collectionBottomConstraint];
    [self.view addConstraint:self.collectionRightConstraint];
    [self addMj_header];
    [self addMj_footer];
}

#pragma mark - protocol

- (void)updateCollectionConstraint:(RHBConstraintAttribute)attribute value:(CGFloat)value {
    
    switch (attribute) {
        case RHBConstraintAttributeTop:
        {
            [self.view removeConstraint:self.collectionTopConstraint];
            self.collectionTopConstraint = [NSLayoutConstraint constraintWithItem:self.collection attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:value];
            [self.view addConstraint:self.collectionTopConstraint];
        }
            break;
        case RHBConstraintAttributeLeft:
        {
            [self.view removeConstraint:self.collectionLeftConstraint];
            self.collectionLeftConstraint = [NSLayoutConstraint constraintWithItem:self.collection attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:value];
            [self.view addConstraint:self.collectionLeftConstraint];
        }
            break;
        case RHBConstraintAttributeBottom:
        {
            [self.view removeConstraint:self.collectionBottomConstraint];
            self.collectionBottomConstraint = [NSLayoutConstraint constraintWithItem:self.collection attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:value];
            [self.view addConstraint:self.collectionBottomConstraint];
        }
            break;
        case RHBConstraintAttributeRight:
        {
            [self.view removeConstraint:self.collectionRightConstraint];
            self.collectionRightConstraint = [NSLayoutConstraint constraintWithItem:self.collection attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:value];
            [self.view addConstraint:self.collectionRightConstraint];
        }
            break;
        default:
            break;
    }
    [self.view layoutIfNeeded];
}

- (void)reloadData {
    
    [self.collection reloadData];
    [self judgeEmptyDataWithCollectionView:self.collection];
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

- (void)emptyDataAction {
    
    if ([self respondsToSelector:@selector(dropDownRefresh)]) {
        
        [self dropDownRefresh];
    }
}

#pragma mark - refresh

- (void)addMj_header {
    
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.collection.mj_footer) {
            
            [strongSelf.collection.mj_footer resetNoMoreData];
        }
        if ([strongSelf respondsToSelector:@selector(dropDownRefresh)]) {
            
            [strongSelf dropDownRefresh];
        } else {
            
            [strongSelf.collection.mj_header endRefreshing];
        }
    }];
    self.collection.mj_header = header;
}

- (void)addMj_footer {
    
    __weak typeof(self) weakSelf = self;
    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if ([strongSelf respondsToSelector:@selector(dropUpGetMore)]) {
            
            [strongSelf dropUpGetMore];
        } else {
            
            [strongSelf.collection.mj_footer endRefreshing];
        }
    }];
    self.collection.mj_footer = footer;
}

#pragma mark - empty delegate

- (void)emptyViewDidReloadData {
    
    [self emptyDataAction];
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
        [cell configWithModel:model indexPath:indexPath];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row < self.dataArr.count) {
        
        RHBModel * model = [self.dataArr objectAtIndex:indexPath.row];
        return model.itemSize;
    }
    return CGSizeZero;
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
    
    if ([self respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:model:)]) {
        
        if (indexPath.row < self.dataArr.count) {
            
            RHBModel * model = [self.dataArr objectAtIndex:indexPath.row];
            [self collectionView:collectionView didSelectItemAtIndexPath:indexPath model:model];
        }
    }
}

#pragma mark - setter and getter

- (UICollectionView *)collection {
    
    if (!_collection) {
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = self.scrollDirection;
        UICollectionView * collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collection.backgroundColor = [UIColor whiteColor];
        collection.delegate = self;
        collection.dataSource = self;
        collection.translatesAutoresizingMaskIntoConstraints = NO;
        if (self.cellArr.count > 0) {
            
            for (NSString * cls in self.cellArr) {
                
                [collection registerClass:NSClassFromString(cls) forCellWithReuseIdentifier:cls];
            }
        } else {
            
            [collection registerClass:RHBCollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(RHBCollectionViewCell.class)];
        }
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
        if ([self respondsToSelector:@selector(registerCells)]) {
            
            [_cellArr addObjectsFromArray:[self registerCells]];
        }
    }
    return _cellArr;
}


@end
