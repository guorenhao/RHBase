//
//  RHBCollectionViewCell.m
//
//  Created by Abner_G on 2017/9/5.
//  Copyright © 2018年 Abner_G. All rights reserved.
//

#import "RHBCollectionViewCell.h"

@implementation RHBCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubviews];
        [self makeConstraintsForUI];
    }
    return self;
}

#pragma mark - protocol

- (void)addSubviews {
    
}

- (void)makeConstraintsForUI {
    
}

- (void)configWithModel:(RHBModel *)model indexPath:(NSIndexPath *)indexPath {
    
}


@end
