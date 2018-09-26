//
//  RHBTableViewCell.m
//
//  Created by Abner_G on 2017/9/5.
//  Copyright © 2018年 Abner_G. All rights reserved.
//

#import "RHBTableViewCell.h"

@interface RHBTableViewCell ()

@property (nonatomic, strong) UILabel * lab_line;
@end
@implementation RHBTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView * selectedBackgroundView = [[UIView alloc] init];
        selectedBackgroundView.backgroundColor = [UIColor colorWithRed:220 / 255.0 green:220 / 255.0 blue:220 / 255.0 alpha:1.0];
        self.selectedBackgroundView = selectedBackgroundView;
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

- (void)configCellWithModel:(RHBModel *)model indexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - setter and getter

- (UILabel *)lab_line {
    
    if (!_lab_line) {
        
        _lab_line = [[UILabel alloc] init];
        _lab_line.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1.0];
    }
    return _lab_line;
}

- (void)setSeparatorEdge:(RHHorizontalEdge)separatorEdge {
    
    _separatorEdge = separatorEdge;
    [self addSubview:self.lab_line];
    [_lab_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(separatorEdge.left);
        make.right.mas_equalTo(-separatorEdge.right);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
