//
//  RHBViewController.m
//
//  Created by Abner_G on 2017/9/5.
//  Copyright © 2018年 Abner_G. All rights reserved.
//

#import "RHBViewController.h"
#import "Masonry.h"

@interface RHBViewController ()

@end

@implementation RHBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addKeyboardNotification];
    [self setNavigation];
    [self initBaseData];
    [self addSubviews];
    [self makeConstraintsForUI];
    [self loadCacheData];
}

#pragma mark - keyboard noti

- (void)addKeyboardNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShowNotification:(NSNotification *)noti {
    
    CGRect frame = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [self keyboardWillShow:frame.size.height];
}

- (void)keyboardWillHideNotification:(NSNotification *)noti {
    
    [self keyboardWillHide];
}

- (void)dealloc {
    
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - public

- (void)setNavigation {
    
}

- (void)initBaseData {
    
}

- (void)addSubviews {
    
}

- (void)makeConstraintsForUI {
    
}

- (void)loadCacheData {
    
}

- (void)loadData {
    
}

- (void)keyboardWillShow:(CGFloat)height {
    
}

- (void)keyboardWillHide {
    
}


- (void)judgeEmptyDataWithTableView:(UITableView *)tableView {
    
    CGFloat headerHeight = tableView.tableHeaderView.frame.size.height;
    CGFloat insetTop = tableView.contentInset.top;
    CGFloat offsetY = (headerHeight - insetTop)/2;
    
    NSInteger count = 0;
    for (int i = 0; i < tableView.numberOfSections; i++) {
        
        count = [tableView numberOfRowsInSection:i];
        if (count > 0) {
            
            break;
        }
    }
    if (count == 0) {
        
        [self.emptyView removeFromSuperview];
        [tableView addSubview:self.emptyView];
        [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {

            make.width.mas_equalTo(tableView.mas_width);
            make.centerX.mas_equalTo(tableView.mas_centerX);
            make.height.mas_equalTo(200);
            make.centerY.mas_equalTo(tableView.mas_centerY).offset(offsetY);
        }];
        tableView.scrollEnabled = self.emptyView.scrollEnabled;
    } else {
        
        [self.emptyView removeFromSuperview];
        tableView.scrollEnabled = YES;
    }
}

- (void)judgeEmptyDataWithCollectionView:(UICollectionView *)collection {
    
    NSInteger count = 0;
    for (int i = 0; i < collection.numberOfSections; i++) {
        
        count = [collection numberOfItemsInSection:i];
        if (count > 0) {
            
            break;
        }
    }
    
    if (count == 0) {
        
        [self.emptyView removeFromSuperview];
        [collection addSubview:self.emptyView];
        [self.emptyView mas_makeConstraints:^(MASConstraintMaker *make) {

            make.width.mas_equalTo(collection.mas_width);
            make.centerX.mas_equalTo(collection.mas_centerX);
            make.height.mas_equalTo(200);
            make.centerY.mas_equalTo(collection.mas_centerY);
        }];
        collection.scrollEnabled = self.emptyView.scrollEnabled;
    } else {
        
        [self.emptyView removeFromSuperview];
        collection.scrollEnabled = YES;
    }
}

#pragma mark - setter and getter

- (RHEmptyView *)emptyView {

    if (!_emptyView) {

        _emptyView = [[RHEmptyView alloc] init];
        [_emptyView setImage:[UIImage imageNamed:@"img_empty_none"] title:@"There is no data~"];
        _emptyView.scrollEnabled = NO;
    }
    return _emptyView;
}

- (CGFloat)navHeight {
    
    return [UIApplication sharedApplication].statusBarFrame.size.height + 44;
}

- (CGFloat)tabBarHeight {
    
    if (@available(iOS 11.0, *)) {
        
        return self.view.safeAreaInsets.bottom + 49;
    }
    return 49;
}


@end
