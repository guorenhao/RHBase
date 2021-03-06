//
//  RHBView.h
//
//  Created by Abner_G on 2017/9/5.
//  Copyright © 2018年 Abner_G. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHBViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface RHBView : UIView <RHBViewProtocol>

@property (nonatomic, assign) CGFloat navHeight;

@end

NS_ASSUME_NONNULL_END
