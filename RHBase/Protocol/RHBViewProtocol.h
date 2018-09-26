//
//  RHBViewProtocol.h
//
//  Created by Abner_G on 2017/9/5.
//  Copyright © 2018年 Abner_G. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RHBViewProtocol <NSObject>

@optional
- (void)addSubviews;
- (void)makeConstraintsForUI;
@end

NS_ASSUME_NONNULL_END
