//
//  RHBTableViewController.m
//
//  Created by Abner_G on 2017/9/5.
//  Copyright © 2018年 Abner_G. All rights reserved.
//

#import "RHBTableViewController.h"
#import <MJRefresh/MJRefresh.h>

@interface RHBTableViewController () <RHEmptyViewDelegate>

@property (nonatomic) NSLayoutConstraint *tableTopConstraint;
@property (nonatomic) NSLayoutConstraint *tableLeftConstraint;
@property (nonatomic) NSLayoutConstraint *tableBottomConstraint;
@property (nonatomic) NSLayoutConstraint *tableRightConstraint;

@property (nonatomic, strong) NSMutableArray * cellArr;
@property (nonatomic, assign) UITableViewStyle style;
@end

@implementation RHBTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    
    self = [super init];
    if (self) {
        
        self.style = style;
    }
    return self;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        self.style = UITableViewStylePlain;
    }
    return self;
}

- (void)viewDidLoad {
    [self addTableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - add tableView

- (void)addTableView {
    
    [self.view addSubview:self.tableView];
    self.emptyView.delegate = self;
    [self makeConstraintsForTableView];
}

#pragma mark - make constraints

- (void)makeConstraintsForTableView {
    
    if (self.navigationController && self.navigationController.navigationBar.translucent) {
        
        self.tableTopConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.navHeight];
    } else {
        
        self.tableTopConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    }
    self.tableLeftConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    self.tableBottomConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    self.tableRightConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    [self.view addConstraint:self.tableTopConstraint];
    [self.view addConstraint:self.tableLeftConstraint];
    [self.view addConstraint:self.tableBottomConstraint];
    [self.view addConstraint:self.tableRightConstraint];
    [self addMj_header];
    [self addMj_footer];
}

#pragma mark - protocol

- (void)updateTableConstraint:(RHBConstraintAttribute)attribute value:(CGFloat)value {
    
    switch (attribute) {
        case RHBConstraintAttributeTop:
        {
            [self.view removeConstraint:self.tableTopConstraint];
            self.tableTopConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:value];
            [self.view addConstraint:self.tableTopConstraint];
        }
            break;
        case RHBConstraintAttributeLeft:
        {
            [self.view removeConstraint:self.tableLeftConstraint];
            self.tableLeftConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:value];
            [self.view addConstraint:self.tableLeftConstraint];
        }
            break;
        case RHBConstraintAttributeBottom:
        {
            [self.view removeConstraint:self.tableBottomConstraint];
            self.tableBottomConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:value];
            [self.view addConstraint:self.tableBottomConstraint];
        }
            break;
        case RHBConstraintAttributeRight:
        {
            [self.view removeConstraint:self.tableRightConstraint];
            self.tableRightConstraint = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:value];
            [self.view addConstraint:self.tableRightConstraint];
        }
            break;
        default:
            break;
    }
    [self.view layoutIfNeeded];
}

- (void)reloadData {
    
    [self.tableView reloadData];
    [self judgeEmptyDataWithTableView:self.tableView];
}

- (void)removeRefreshHeader {
    
    if (self.tableView.mj_header) {
        
        self.tableView.mj_header = nil;
    }
}

- (void)removeRefreshFooter {
    
    if (self.tableView.mj_footer) {
        
        self.tableView.mj_footer = nil;
    }
}

- (void)endRefreshing {
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)emptyDataAction {
    
    [self dropDownRefresh];
}


#pragma mark - refresh

- (void)addMj_header {
    
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.tableView.mj_footer) {
            
            [strongSelf.tableView.mj_footer resetNoMoreData];
        }
        if ([strongSelf respondsToSelector:@selector(dropDownRefresh)]) {
            
            [strongSelf dropDownRefresh];
        } else {
            
            [strongSelf.tableView.mj_header endRefreshing];
        }
    }];
    self.tableView.mj_header = header;
}

- (void)addMj_footer {
    
    __weak typeof(self) weakSelf = self;
    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if ([strongSelf respondsToSelector:@selector(dropUpGetMore)]) {
            
            [strongSelf dropUpGetMore];
        } else {
            
            [strongSelf.tableView.mj_footer endRefreshing];
        }
    }];
    self.tableView.mj_footer = footer;
}

#pragma mark - empty delegate

- (void)emptyViewDidReloadData {
    
    [self emptyDataAction];
}

#pragma mark - tableView dataSource and delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * cellIdentifier = NSStringFromClass(RHBTableViewCell.class);
    if (self.cellArr.count > 0) {
        
        cellIdentifier = self.cellArr.firstObject;
    }
    RHBTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (indexPath.row < self.dataArr.count) {
        
        RHBModel * model = [self.dataArr objectAtIndex:indexPath.row];
        [cell configWithModel:model indexPath:indexPath];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row < self.dataArr.count) {
        
        RHBModel * model = [self.dataArr objectAtIndex:indexPath.row];
        return model.cellHeight;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:model:)]) {
        
        if (indexPath.row < self.dataArr.count) {
            
            RHBModel * model = [self.dataArr objectAtIndex:indexPath.row];
            [self tableView:tableView didSelectRowAtIndexPath:indexPath model:model];
        }
    }
}

#pragma mark - setter and getter

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        UITableView * table = [[UITableView alloc] initWithFrame:CGRectZero style:self.style];
        table.dataSource = self;
        table.delegate = self;
        table.backgroundColor = [UIColor whiteColor];
        table.translatesAutoresizingMaskIntoConstraints = NO;
        table.estimatedRowHeight = 0;
        table.estimatedSectionHeaderHeight = 0;
        table.estimatedSectionFooterHeight = 0;
        table.tableFooterView = [[UIView alloc] init];
        if (self.cellArr.count > 0) {
            
            for (NSString * cls in self.cellArr) {
                
                [table registerClass:NSClassFromString(cls) forCellReuseIdentifier:cls];
            }
        } else {
            
            [table registerClass:[RHBTableViewCell class] forCellReuseIdentifier:NSStringFromClass(RHBTableViewCell.class)];
        }
        if (@available(iOS 11.0, *)) {
            
            table.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
            table.scrollIndicatorInsets = table.contentInset;
        }
        _tableView = table;
    }
    return _tableView;
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
