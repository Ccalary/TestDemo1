//
//  ImageTableViewCell.m
//  TestDemo1
//
//  Created by caohouhong on 2017/11/21.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "ImageTableViewCell.h"

@implementation ImageTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

- (void)initView{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor greenColor];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.height.equalTo(@20);
    }];
    
    _imageView1 = [[UIImageView alloc] init];
    [self.contentView addSubview:_imageView1];
    [_imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@100);
        make.left.offset((ScreenWidth - 300)/4.0);
        make.bottom.offset(-5);
    }];
    
    _imageView2 = [[UIImageView alloc] init];
    [self.contentView addSubview:_imageView2];
    [_imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@100);
        make.left.equalTo(_imageView1.mas_right).offset((ScreenWidth - 300)/4.0);
        make.bottom.offset(-5);
    }];
    
    _imageView3 = [[UIImageView alloc] init];
    [self.contentView addSubview:_imageView3];
    [_imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@100);
        make.left.equalTo(_imageView2.mas_right).offset((ScreenWidth - 300)/4.0);
        make.bottom.offset(-5);
    }];
}

@end
