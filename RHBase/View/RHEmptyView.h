//
//  RHEmptyView.h
//
//  Created by Abner_G on 2018/11/17.
//  Copyright © 2018 Abner_G. All rights reserved.
//

#import "RHBView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RHEmptyViewDelegate;
@interface RHEmptyView : RHBView

@property (nonatomic, weak) id<RHEmptyViewDelegate> delegate;

// image
@property (nonatomic, strong) UIImage * emptyImage;
// title label
@property (nonatomic, strong) UIFont  * emptyTitleFont;
@property (nonatomic, strong) UIColor * emptyTitleColor;
@property (nonatomic, copy) NSString  * emptyTitle;
// button
@property (nonatomic, strong) UIFont  * buttonTitleFont;
@property (nonatomic, strong) UIColor * buttonTitleColor;
@property (nonatomic, strong) UIColor * buttonBackgroundColor;
@property (nonatomic, copy) NSString  * buttonTitle;

@property (nonatomic, assign) CGFloat buttonCornerRadius;

@property (nonatomic, assign) BOOL scrollEnabled;
@property (nonatomic, assign) BOOL showReloadButton;

- (void)setImage:(nullable UIImage *)image title:(nullable NSString *)title;
@end
@protocol RHEmptyViewDelegate <NSObject>

@optional
- (void)emptyViewDidReloadData;
@end

NS_ASSUME_NONNULL_END
