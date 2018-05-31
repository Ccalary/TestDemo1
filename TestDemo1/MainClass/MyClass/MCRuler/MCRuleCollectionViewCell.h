//
//  MCRuleCollectionViewCell.h
//  MCRuleDemo
//
//  Created by caohouhong on 2018/5/28.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCRuleCollectionViewCell : UICollectionViewCell
// 是否是整数倍，是的话高度变高
@property (nonatomic, assign) BOOL isMultiple;
@property (nonatomic, strong) NSString *content;
@end
