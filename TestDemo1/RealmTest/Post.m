//
//  Post.m
//  TestDemo1
//
//  Created by caohouhong on 17/3/23.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "Post.h"

@implementation Post

//输出
- (NSString *)description{
    
    return  [NSString stringWithFormat:@"<%@: %p, %@>",
            [self class],
            self,
             @{@"title":_title,
               @"content":_content}
          ];
}
@end
