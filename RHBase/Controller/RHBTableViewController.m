//
//  RHBTableViewController.m
//
//  Created by Abner_G on 2017/9/5.
//  Copyright © 2018年 Abner_G. All rights reserved.
//

#import "RHBTableViewController.h"
#import <Masonry.h>
#import <MJRefresh/MJRefresh.h>
#import "RHBTableViewCell.h"

@interface RHBTableViewController ()

@property (nonatomic, strong) NSMutableArray * cellArr;
@end

@implementation RHBTableViewController

- (void)viewDidLoad {
    [self addTableView];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - add tableView

- (void)addTableView {
    
    [self.view addSubview:self.tableView];
    [self judgeEmptyDataWithTableView:self.tableView];
    [self makeConstraintsForTableView];
}

#pragma mark - make constraints

- (void)makeConstraintsForTableView {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
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
        [self.tableView registerClass:NSClassFromString(clsStr) forCellReuseIdentifier:clsStr];
    }
}

- (void)reloadData {
    
    [self.tableView reloadData];
    [self judgeEmptyDataWithTableView:self.tableView];
}

- (void)dropDownRefresh {
    
}

- (void)dropUpGetMore {
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath model:(RHBModel *)model {
    
}


#pragma mark - refresh

- (void)addMj_header {
    
    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.tableView.mj_footer) {
            
            [strongSelf.tableView.mj_footer resetNoMoreData];
        }
        [strongSelf dropDownRefresh];
    }];
    self.tableView.mj_header = header;
}

- (void)addMj_footer {
    
    __weak typeof(self) weakSelf = self;
    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf dropUpGetMore];
    }];
    self.tableView.mj_footer = footer;
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
        [cell configCellWithModel:model indexPath:indexPath];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RHBModel * model = [self.dataArr objectAtIndex:indexPath.row];
    return model.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RHBModel * model = [self.dataArr objectAtIndex:indexPath.row];
    [self tableView:tableView didSelectRowAtIndexPath:indexPath model:model];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationEndEditing object:nil userInfo:nil];
}

#pragma mark - setter and getter

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        UITableView * table = [[UITableView alloc] init];
        table.dataSource = self;
        table.delegate = self;
        table.backgroundColor = [UIColor whiteColor];
        table.estimatedRowHeight = 0;
        table.estimatedSectionHeaderHeight = 0;
        table.estimatedSectionFooterHeight = 0;
        table.tableFooterView = [[UIView alloc] init];
        [table registerClass:[RHBTableViewCell class] forCellReuseIdentifier:NSStringFromClass(RHBTableViewCell.class)];
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
    }
    return _cellArr;
}


@end
