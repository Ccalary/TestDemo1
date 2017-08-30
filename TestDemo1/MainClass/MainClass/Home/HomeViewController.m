//
//  HomeViewController.m
//  TestDemo1
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "HomeViewController.h"
#import "Post.h"
#import "FirstViewController.h"
#import "IndustryList.h"
#import "IndustrayData.h"
#import "HHPopButton.h"

@implementation Dog

@end

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    [self initView];
    
}

- (void)initView{
    UIView *holdView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    holdView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:holdView];
    
    //创建数据库
    Dog *dog = [[Dog alloc] init];
    dog.name = @"Peter";
//    dog.age = 1;
    
    Post *post = [[Post alloc] init];
    post.title = @"开心1";
    post.contents = @"今天是个好日子1";
    
    DLog(@"post%@",post);
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm transactionWithBlock:^{
        [realm addObject:dog];
    }];
    
    DLog(@"dog%@",dog);
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 200, 30)];
    
    [self.view addSubview:nameLabel];
    
    RLMResults *r = [Dog allObjects];
    DLog(@"%@", r);
    Dog *dogP = [r firstObject];
    nameLabel.text = dogP.name;
    
    [realm transactionWithBlock:^{
        [realm deleteObjects:r];
    }];
    
    DLog(@"%@", r);
    
   
    
    HHPopButton *nextMonthBtn = [[HHPopButton alloc] initWithFrame:CGRectMake(50, 150, 100, 50)];
    [nextMonthBtn setTitle:@"按钮" forState:UIControlStateNormal];
    [nextMonthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    nextMonthBtn.colicActionBlock = ^(){
       [self.navigationController pushViewController:[[FirstViewController alloc] init] animated:YES];
    };
    nextMonthBtn.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:nextMonthBtn];
    
//    RLMResults *result = [IndustrayData allObjects];
//    
//    [realm transactionWithBlock:^{
//        [realm deleteObjects:result];
//    }];
//    
//    if (result.count == 0){
//        [self requestData];
//    }
//    
//    NSLog(@"IndustrayData==%@",result);

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)nextMonthBtnAction:(UIButton *)button{
    
//    FirstViewController *vc = [[FirstViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    
    [self.navigationController pushViewController:[[FirstViewController alloc] init] animated:YES];
}

@end
