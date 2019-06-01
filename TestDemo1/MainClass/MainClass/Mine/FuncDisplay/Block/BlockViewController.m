//
//  BlockViewController.m
//  TestDemo1
//
//  Created by caohouhong on 2018/5/22.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "BlockViewController.h"
typedef void(^doubleWithNumBlock)(int a);

@interface BlockViewController ()
@property (nonatomic, copy) doubleWithNumBlock doubleBlock;
@end

@implementation BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initBlock];
}

- (void)initBlock {
    // 块的语法：return_type (^block_name)(parameters)
    // 1、没有参数，没有返回值的最简单的块
    void(^someBlock)() = ^{
        NSLog(@"someBlock");
    };
    // 2、有参数，有返回值的块
    int (^addBlock)(int a, int b) = ^(int a, int b) {
        return a + b;
    };
    
    int add = addBlock(3,4);
    someBlock();
    NSLog(@"sum:%d",add);
    
    [self doubleWithNum:2 completion:^(int b) {
      NSLog(@"a=%d",b);
    }];
     
    [self doubleWithNum:3 completion:nil];
    
}


- (void)doubleWithNum:(int)a completion:(void(^)(int b))finish{
    if (finish){
      finish(a*2);
    }
}

@end
