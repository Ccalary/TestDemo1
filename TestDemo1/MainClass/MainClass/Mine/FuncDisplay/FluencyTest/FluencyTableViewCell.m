
//
//  FluencyTableViewCell.m
//  TestDemo1
//
//  Created by chh on 2018/1/30.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "FluencyTableViewCell.h"
@interface FluencyTableViewCell()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) CALayer *imageLayer;
@property (nonatomic, strong) UIImageView *topImageView;
@end

@implementation FluencyTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
//    _imageLayer.frame = CGRectMake(10, 10, 50, 50);
    _titleLabel.frame = CGRectMake(0, 0, 50, self.contentView.frame.size.height);
    _topImageView.frame = CGRectMake(70, 10, 50, 50);
}

- (void)initView{
//    _imageLayer = [CALayer layer];
//    _imageLayer.backgroundColor = [UIColor blueColor].CGColor;
//    [self.contentView.layer addSublayer:_imageLayer];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLabel];
    
    _topImageView = [[UIImageView alloc] init];
    _topImageView.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_topImageView];
}

- (void)setImageStr:(NSString *)imageStr andTitle:(NSString *)title{
    self.titleLabel.text = title;
//    dispatch_group_t downloadGroup = dispatch_group_create();
//    dispatch_group_enter(downloadGroup);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"子线程下载");
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageStr]];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.topImageView.image = [UIImage imageWithData:imgData];
//            dispatch_group_leave(downloadGroup);
        });
    });
//    NSLog(@"======线程之外=====");
//    dispatch_group_notify(downloadGroup, dispatch_get_main_queue(), ^{
//        NSLog(@"图片加载完成");
//    });
    
}
@end
