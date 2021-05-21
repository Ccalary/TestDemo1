//
//  TouchCollectionViewCell.m
//  TestDemo1
//
//  Created by caohouhong on 2021/4/16.
//  Copyright © 2021 caohouhong. All rights reserved.
//

#import "TouchCollectionViewCell.h"
@interface TouchCollectionViewCell()
@property (nonatomic, strong) UIView *holdView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;
@end
@implementation TouchCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){
        [self initView];
    }
    return self;
}

- (void)initView {
    self.backgroundColor = [UIColor clearColor];
    
    _holdView = [[UIView alloc] initWithFrame:self.contentView.frame];
    _holdView.backgroundColor = [UIColor whiteColor];
    _holdView.layer.cornerRadius = 5.0;
    _holdView.layer.masksToBounds = YES;
    [self.contentView addSubview:_holdView];
    
    _titleLabel = [UILabel createLabelWithTitle:@"名字" textColor:[UIColor fontColorGray666]];
    [_holdView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.holdView);
        make.left.offset(12*UIRate);
        make.height.mas_equalTo(30*UIRate);
        make.right.offset(-30*UIRate);
    }];
    
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img_3"]];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.layer.masksToBounds = YES;
    [_holdView addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(8*UIRate);
        make.right.offset(-8*UIRate);
        make.bottom.offset(-10*UIRate);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5*UIRate);
    }];    
}

@end
