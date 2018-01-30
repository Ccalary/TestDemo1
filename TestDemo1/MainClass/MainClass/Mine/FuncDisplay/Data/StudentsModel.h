//
//  StudentsModel.h
//  TestDemo1
//
//  Created by chh on 2018/1/30.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudentsModel : NSObject <NSCoding>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, strong) UIImage *avatar;
@end
