//
//  RHEmptyView.m
//
//  Created by Abner_G on 2018/11/17.
//  Copyright © 2018 Abner_G. All rights reserved.
//

#import "RHEmptyView.h"
#import "Masonry.h"

@interface RHEmptyView ()

@property (nonatomic, strong) UIImageView * img_icon;
@property (nonatomic, strong) UILabel * lab_title;
@property (nonatomic, strong) UIButton * btn_reload;

@property (nonatomic, assign) CGFloat emptyTitleHeight;
@property (nonatomic, assign) CGFloat buttonWidth;
@property (nonatomic, assign) BOOL addFinish;
@end
@implementation RHEmptyView

+ (void)initialize {
    
    RHEmptyView * view = [self appearance];
    view.emptyTitleFont = [UIFont systemFontOfSize:15];
    view.emptyTitleColor = [UIColor colorWithRed:75 / 255.0 green:75 / 255.0 blue:75 / 255.0 alpha:1.0];
    view.emptyTitle = @"暂无相关信息~";
    view.buttonTitleColor = [UIColor blackColor];
    view.buttonTitleFont = [UIFont systemFontOfSize:15];
    view.buttonTitle = @"重新加载";
    view.buttonCornerRadius = 15.0;
    view.showReloadButton = NO;
}

- (void)addSubviews {
    
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.img_icon];
    [self addSubview:self.lab_title];
    [self addSubview:self.btn_reload];
}

- (void)makeConstraintsForUI {
    
    [_img_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.mas_equalTo(0);
        make.centerY.mas_equalTo(self.mas_centerY).offset(-50);
        make.height.mas_equalTo(130);
    }];
    [_lab_title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.img_icon.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(40);
    }];
    [_btn_reload mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.lab_title.mas_bottom).offset(15);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(30);
    }];
    self.addFinish = YES;
}

#pragma mark - public

- (void)setImage:(UIImage *)image title:(NSString *)title {
    
    [self setEmptyTitle:title];
    [self setEmptyImage:image];
}

#pragma mark - private

- (CGFloat)getHeightByText:(NSString *)text font:(UIFont *)font width:(CGFloat)width {
    
    if (text.length == 0 || width <= 0) {
        
        return 0;
    }
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = text;
    label.font = font;
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}

- (CGFloat)getWidthByText:(NSString *)text font:(UIFont *)font {
    
    if (text.length == 0) {
        
        return 0;
    }
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAXFLOAT, 0)];
    label.text = text;
    label.font = font;
    [label sizeToFit];
    CGFloat width = label.frame.size.width;
    return width;
}

#pragma mark - action

- (void)clickButton:(UIButton *)sender {
    
    [self removeFromSuperview];
    if (self.delegate && [self.delegate respondsToSelector:@selector(emptyViewDidReloadData)]) {
        
        [self.delegate emptyViewDidReloadData];
    }
}

#pragma mark - setter and getter

- (UIImageView *)img_icon {
    
    if (!_img_icon) {
        
        UIImageView * imageV = [[UIImageView alloc] init];
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        _img_icon = imageV;
    }
    return _img_icon;
}

- (UILabel *)lab_title {
    
    if (!_lab_title) {
        
        UILabel * label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        _lab_title = label;
    }
    return _lab_title;
}

- (UIButton *)btn_reload {
    
    if (!_btn_reload) {
        
        UIButton * button = [[UIButton alloc] init];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        _btn_reload = button;
        
    }
    return _btn_reload;
}

- (void)setEmptyImage:(UIImage *)emptyImage {
    
    _emptyImage = emptyImage;
    self.img_icon.image = emptyImage;
}

- (void)setEmptyTitleFont:(UIFont *)emptyTitleFont {
    
    _emptyTitleFont = emptyTitleFont;
    self.lab_title.font = emptyTitleFont;
    if (self.lab_title.text.length > 0) {
        
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        self.emptyTitleHeight = [self getHeightByText:self.lab_title.text font:emptyTitleFont width:width - 30] + 2;
        if (self.addFinish) {
            
            [self.lab_title mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.height.mas_equalTo(self.emptyTitleHeight);
            }];
            [self.img_icon mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.centerY.mas_equalTo(self.mas_centerY).offset(-30 - self.emptyTitleHeight / 2.0);
            }];
        }
    }
}

- (void)setEmptyTitleColor:(UIColor *)emptyTitleColor {
    
    _emptyTitleColor = emptyTitleColor;
    self.lab_title.textColor = emptyTitleColor;
}

- (void)setEmptyTitle:(NSString *)emptyTitle {
    
    _emptyTitle = emptyTitle;
    self.lab_title.text = emptyTitle;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    self.emptyTitleHeight = [self getHeightByText:emptyTitle font:self.emptyTitleFont width:width - 30] + 2;
    if (self.addFinish) {
        
        [self.lab_title mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(self.emptyTitleHeight);
        }];
        [self.img_icon mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.mas_equalTo(self.mas_centerY).offset(-30 - self.emptyTitleHeight / 2.0);
        }];
    }
}

- (void)setButtonTitleFont:(UIFont *)buttonTitleFont {
    
    _buttonTitleFont = buttonTitleFont;
    self.btn_reload.titleLabel.font = buttonTitleFont;
}

- (void)setButtonTitleColor:(UIColor *)buttonTitleColor {
    
    _buttonTitleColor = buttonTitleColor;
    [self.btn_reload setTitleColor:buttonTitleColor forState:UIControlStateNormal];
}

- (void)setButtonTitle:(NSString *)buttonTitle {
    
    _buttonTitle = buttonTitle;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    self.buttonWidth = [self getWidthByText:buttonTitle font:self.buttonTitleFont] + 30;
    if (self.buttonWidth > width - 40) {
        
        self.buttonWidth = width - 40;
    }
    if (self.addFinish) {
        
        [_btn_reload mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.width.mas_equalTo(self.buttonWidth);
        }];
    }
    [self.btn_reload setTitle:buttonTitle forState:UIControlStateNormal];
}

- (void)setButtonCornerRadius:(CGFloat)buttonCornerRadius {
    
    _buttonCornerRadius = buttonCornerRadius;
    self.btn_reload.layer.cornerRadius = buttonCornerRadius;
    self.btn_reload.layer.masksToBounds = YES;
}

- (void)setShowReloadButton:(BOOL)showReloadButton {
    
    _showReloadButton = showReloadButton;
    self.btn_reload.hidden = !showReloadButton;
}

- (CGFloat)emptyTitleHeight {
    
    if (_emptyTitleHeight == 0) {
        
        return 40;
    }
    return _emptyTitleHeight;
}

- (CGFloat)buttonWidth {
    
    if (_buttonWidth == 0) {
        
        return 80;
    }
    return _buttonWidth;
}


@end
