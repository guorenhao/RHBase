//
//  RHBViewController.h
//
//  Created by Abner_G on 2017/9/5.
//  Copyright © 2018年 Abner_G. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHBViewControllerProtocol.h"
//#import "RHEmptyView.h"

NS_ASSUME_NONNULL_BEGIN

@interface RHBViewController : UIViewController <RHBViewControllerProtocol>

//@property (nonatomic, strong) RHEmptyView * emptyView;

@property (nonatomic, assign) CGFloat navHeight;
@property (nonatomic, assign) CGFloat tabBarHeight;

@end

NS_ASSUME_NONNULL_END
