//
//  StudentsModel.m
//  TestDemo1
//
//  Created by chh on 2018/1/30.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "StudentsModel.h"

@implementation StudentsModel
//解档
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]){
        self.avatar = [aDecoder decodeObjectForKey:@"avatar"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntegerForKey:@"age"];
    }
    return self;
}
//归档
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.avatar forKey:@"avatar"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInteger:self.age forKey:@"age"];
}
@end
