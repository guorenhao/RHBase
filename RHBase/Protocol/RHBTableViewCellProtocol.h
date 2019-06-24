//
//  RHBTableViewCellProtocol.h
//
//  Created by Abner_G on 2017/9/5.
//  Copyright © 2018年 Abner_G. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHBModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RHBTableViewCellProtocol <NSObject>

@optional
- (void)addSubviews;
- (void)makeConstraintsForUI;

- (void)configWithModel:(RHBModel *)model indexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
