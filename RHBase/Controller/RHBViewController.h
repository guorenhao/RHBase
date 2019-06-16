//
//  RHBViewController.h
//
//  Created by Abner_G on 2017/9/5.
//  Copyright © 2018年 Abner_G. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHBViewControllerProtocol.h"
#import "RHEmptyView.h"
#import "RHBUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface RHBViewController : UIViewController <RHBViewControllerProtocol>

@property (nonatomic, strong) RHEmptyView * emptyView;

// 导航与状态栏高度
@property (nonatomic, assign) CGFloat navHeight;
// 标签栏高度
@property (nonatomic, assign) CGFloat tabBarHeight;

@end

NS_ASSUME_NONNULL_END
