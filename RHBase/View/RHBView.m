//
//  RHBView.m
//
//  Created by Abner_G on 2017/9/5.
//  Copyright © 2018年 Abner_G. All rights reserved.
//

#import "RHBView.h"

@implementation RHBView

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



- (CGFloat)navHeight {
    
    if ([self iPhoneX]) {
        
        return 88;
    }
    return 64;
}

- (BOOL)iPhoneX {
    
    if ([UIScreen instancesRespondToSelector:@selector(currentMode)]) {
        
        return CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size);
    }
    return NO;
}


@end
