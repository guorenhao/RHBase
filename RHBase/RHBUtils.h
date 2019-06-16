//
//  RHBUtils.h
//  CocoapodsDemo
//
//  Created by 郭人豪 on 2019/1/27.
//  Copyright © 2019 Abner_G. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RHBConstraintAttribute) {
    
    RHBConstraintAttributeTop    = 0,
    RHBConstraintAttributeLeft,
    RHBConstraintAttributeBottom,
    RHBConstraintAttributeRight,
};
@interface RHBUtils : NSObject

@end

NS_ASSUME_NONNULL_END
