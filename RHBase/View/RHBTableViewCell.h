//
//  RHBTableViewCell.h
//
//  Created by Abner_G on 2017/9/5.
//  Copyright © 2018年 Abner_G. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHBTableViewCellProtocol.h"

typedef struct RHHorizontalEdge {
    
    CGFloat left, right;  // specify amount to inset (positive) for the horizontal edges.
} RHHorizontalEdge;

UIKIT_STATIC_INLINE RHHorizontalEdge RHHorizontalEdgeMake(CGFloat left, CGFloat right) {
    
    RHHorizontalEdge insets = {left, right};
    return insets;
}

NS_ASSUME_NONNULL_BEGIN

@interface RHBTableViewCell : UITableViewCell <RHBTableViewCellProtocol>

@property (nonatomic) RHHorizontalEdge separatorEdge;

@end

NS_ASSUME_NONNULL_END
