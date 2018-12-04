//
//  HQHomeListCell.m
//  HQAppArchitectureDemo
//
//  Created by Mr_Han on 2018/12/4.
//  Copyright © 2018 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//

#import "HQHomeListCell.h"

@interface HQHomeListCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *mottoLabel;
@end

@implementation HQHomeListCell

#pragma mark - life cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initViews];
    }
    return self;
}

- (void)initViews {
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.mottoLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(self.contentView);
        make.width.lessThanOrEqualTo(@(100));
    }];
    [self.mottoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.contentView).offset(15);
        make.bottom.equalTo(self.contentView).offset(-15);
    }];
    [self.nameLabel setContentHuggingPriority:UILayoutPriorityDefaultLow + 1 forAxis:UILayoutConstraintAxisHorizontal];
    [self.mottoLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    [self.nameLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 1 forAxis:UILayoutConstraintAxisHorizontal];
    [self.mottoLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
}

#pragma mark - setter

- (void)setModel:(HQHomeListModel *)model {
    _model = model;
    
    self.nameLabel.text = model.name;
    self.mottoLabel.text = model.motto;
}

#pragma mark - getter

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont boldSystemFontOfSize:14];
        _nameLabel.textColor = [UIColor darkTextColor];
    }
    return _nameLabel;
}

- (UILabel *)mottoLabel {
    if (!_mottoLabel) {
        _mottoLabel = [UILabel new];
        _mottoLabel.font = [UIFont systemFontOfSize:14];
        _mottoLabel.textColor = [UIColor orangeColor];
        _mottoLabel.numberOfLines = 0;
    }
    return _mottoLabel;
}

@end

