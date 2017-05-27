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
@import Realm;


@interface Dog : RLMObject
@property NSString *name;
@property NSInteger age;
@end

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
    dog.age = 1;
    
    Post *post = [[Post alloc] init];
    post.title = @"开心1";
    post.content = @"今天是个好日子1";
    
    DLog(@"post%@",post);
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addObject:dog];
    }];
    
    DLog(@"dog%@",dog);
 
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 200, 200, 30)];
    nameLabel.text = dog.name;
    [self.view addSubview:nameLabel];
    
    HHPopButton *nextMonthBtn = [[HHPopButton alloc] initWithFrame:CGRectMake(50, 150, 100, 50)];
    [nextMonthBtn setTitle:@"按钮" forState:UIControlStateNormal];
    [nextMonthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    nextMonthBtn.colicActionBlock = ^(){
        FirstViewController *vc = [[FirstViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
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

- (void)requestData{
    
    NSURL *url = [NSURL URLWithString:@"http://121.40.94.85:8788/cbapiprj/webService/tradeMark/listCategoriesTree"];
    
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url];
    //设置请求方式
    [mutableRequest setHTTPMethod:@"POST"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:mutableRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NULL];
        NSLog(@"NSURLsessison_________ %@",dict);
        
        NSArray *array = [dict objectForKey:@"data"];
        
        NSLog(@"array:%@",array);
        
        for (NSDictionary *dic in array){
            IndustrayData *list = [[IndustrayData alloc] init];
            list.name = [dic objectForKey:@"name"];
            list.id = [dic objectForKey:@"id"];
            
            for (NSDictionary *chilDic in [dic objectForKey:@"children"]){
                IndustrayData *chilList = [[IndustrayData alloc] init];
                chilList.name = [chilDic objectForKey:@"category_name"];
                chilList.id = [chilDic objectForKey:@"id"];
                [list.children addObject:chilList];
            }
            
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm transactionWithBlock:^{
                [realm addObject:list];
            }];
            
            NSLog(@"%@==", list);
        }
    }];
    
    //4.执行任务
    [dataTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)nextMonthBtnAction:(UIButton *)button{
    

    
//    FirstViewController *vc = [[FirstViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

@end
