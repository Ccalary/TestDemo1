//
//  MCRuleCollectionViewCell.m
//  MCRuleDemo
//
//  Created by caohouhong on 2018/5/28.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "MCRuleCollectionViewCell.h"
@interface MCRuleCollectionViewCell()
@property (nonatomic, strong) UIView *topLineView, *bottomLineView;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation MCRuleCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]){
        [self initView];
    }
    return self;
}

- (void)initView {
    CGFloat height = self.contentView.bounds.size.height;
    _topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, height/2.0)];
    _topLineView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_topLineView];
    
    _bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, height/2.0 - 5, 1, 5)];
    _bottomLineView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_bottomLineView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, height/2.0 + 1, self.contentView.bounds.size.width, 1)];
    lineView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:lineView];
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(-30, height/2.0 + 1, 60, height/2.0 - 1)];
    _contentLabel.textColor = [UIColor blackColor];
    _contentLabel.font = [UIFont systemFontOfSize:12];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_contentLabel];
}

- (void)setIsMultiple:(BOOL)isMultiple {
    _isMultiple = isMultiple;
    _topLineView.hidden = !isMultiple;
    _bottomLineView.hidden = isMultiple;
}

- (void)setContent:(NSString *)content {
    _contentLabel.text = content;
}
@end
