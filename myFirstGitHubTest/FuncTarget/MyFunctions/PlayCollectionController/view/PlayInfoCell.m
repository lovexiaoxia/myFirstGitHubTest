//
//  PlayInfoCell.m
//  FuncTarget
//
//  Created by 程昂 on 2017/3/14.
//  Copyright © 2017年 程昂. All rights reserved.
//

#import "PlayInfoCell.h"

@interface PlayInfoCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation PlayInfoCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createNameLabel];
        [self createImageView];
    }
    return self;
}

- (void)createNameLabel{
    _nameLabel = [UILabel new];
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.textColor = [UIColor colorWithRed:53.0 / 255 green:53.0 / 255 blue:53.0 / 255 alpha:1.0f];
    _nameLabel.font = [UIFont systemFontOfSize:15.0f];
    [self.contentView addSubview:_nameLabel];
}

- (void)createImageView{
    _imageView = [UIImageView new];
    _imageView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_imageView];
}

#pragma mark - layoutSubviews

- (void)layoutSubviews{
    [super layoutSubviews];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.top.mas_equalTo(@0);
        make.bottom.mas_equalTo(@0);
        make.left.mas_equalTo(@15);
        make.width.mas_equalTo(@80);
    }];
    [_nameLabel layoutIfNeeded];
    
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@17);
        make.width.mas_equalTo(@17);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.right.mas_equalTo(@15.0f);
    }];
    [_imageView layoutIfNeeded];
    
    [super layoutSubviews];
}

@end
