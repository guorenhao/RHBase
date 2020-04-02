//
//  RHBUtils.h
//  CocoapodsDemo
//
//  Created by Abner_G on 2019/1/27.
//  Copyright © 2019 Abner_G. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RHConstraintAttribute) {
    
    RHConstraintAttributeTop    = 0,
    RHConstraintAttributeLeft,
    RHConstraintAttributeBottom,
    RHConstraintAttributeRight,
};
@interface RHBUtils : NSObject

@end

NS_ASSUME_NONNULL_END
