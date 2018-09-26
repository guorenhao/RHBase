//
//  RHBCollectionViewCellProtocol.h
//
//  Created by Abner_G on 2017/9/5.
//  Copyright © 2018年 Abner_G. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHBModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RHBCollectionViewCellProtocol <NSObject>

@optional
- (void)addSubviews;
- (void)makeConstraintsForUI;

- (void)configCellWithModel:(RHBModel *)model indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END