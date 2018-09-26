//
//  RHBMainViewController.m
//
//  Created by Abner_G on 2017/9/5.
//  Copyright © 2018年 Abner_G. All rights reserved.
//

#import "RHBMainViewController.h"

@interface RHBMainViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, assign) BOOL isCanSideBack;

@end

@implementation RHBMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self forbidSideBack];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self regainSideBack];
}

// forbid side back
- (void)forbidSideBack{
    
    self.isCanSideBack = NO;
    // close pop gesture
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

// regain side  back
- (void)regainSideBack {
    
    self.isCanSideBack=YES;
    // open pop gesture
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    
    return self.isCanSideBack;
}

@end
