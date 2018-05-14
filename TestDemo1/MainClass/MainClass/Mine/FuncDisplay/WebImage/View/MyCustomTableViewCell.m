//
//  MyCustomTableViewCell.m
//  TestDemo1
//
//  Created by caohouhong on 2018/5/10.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "MyCustomTableViewCell.h"
@implementation MyCustomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _customImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20.0, 5.0, 60.0, 80.0)];
        [self.contentView addSubview:_customImageView];
        _customTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(100.0, 0.0, 200, 90.0)];
        [self.contentView addSubview:_customTextLabel];
        
        _customImageView.clipsToBounds = YES;
        _customImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

@end
