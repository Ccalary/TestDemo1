//
//  MineViewController.m
//  TestDemo1
//
//  Created by caohouhong on 17/4/16.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "MineViewController.h"
#import "HomeViewController.h"

@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation MineViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSArray *array = @[@"showHUD",@"runningTime",@"异常捕获",@"抛出异常"];
    
    [self.dataArray addObjectsFromArray:array];
    
    [self drawView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)drawView{
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    _tableView.mj_header = [HHRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"走了下拉刷新");
        
        [_tableView.mj_header endRefreshing];
    }];

    _tableView.mj_footer = [HHRefreshNormalFooter footerWithRefreshingBlock:^{
        
        NSLog(@"走了上拉加载");
        
       int x = arc4random() % 10;
        if (x > 6){
            [_tableView.mj_footer endRefreshingWithNoMoreData];
        }else {
             [_tableView.mj_footer endRefreshing];
        }
    }];
     // 马上进入刷新状态
    [_tableView.mj_header beginRefreshing];
}

- (void)loadNewData{
    NSLog(@"走了下拉刷新");
    [_tableView.mj_header endRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self showHUD];
            break;
        case 1:
            [self showRunningTime];
            break;
         case 2:
            [self catchTheCrash];
            break;
        case 3:
            [self throwException];
            break;
        default:
            break;
    }
}



#pragma mark - HUD
- (void)showHUD{
    [LCProgressHUD showLoading:@""];
    
    //延时
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LCProgressHUD hide];
    });

}

#pragma mark - runningTime
- (void)showRunningTime{
    
    id obj = self;
    if ([obj respondsToSelector:@selector(nextMonthBtnAction)]){
        
    }
    
    if ([obj isKindOfClass:[NSArray class]]){
        
    }
    
    NSArray *array = @[@"1",@"2"];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSLog(@"--%@--",obj);
        
    }];
}

- (void)nextMonthBtnAction{
    NSLog(@"runtime开始了");
}

#pragma mark - 异常捕获
- (void)catchTheCrash{
    
    @try {
        NSMutableArray *array = [NSMutableArray array];
        NSString *str = nil;
        [array addObject:str];
        
        NSLog(@"走不到这里了");
        
    } @catch (NSException *exception) {
        
//        @throw exception;
        
        NSLog(@"数组越界拉");
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"捕获异常" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *done = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:done];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    } @finally {
        
        DLog(@"捕获结束");
    }
}

#pragma mark - 抛出异常
- (void)throwException{
    
    //异常的名称
    NSString *exceptionName = @"自定义异常";
    //异常的原因
    NSString *exceptionReason = @"我长得太帅了，所以程序崩溃了";
    //异常的信息
    NSDictionary *exceptionUserInfo = @{@"e_info":@"这是异常信息"};
    
    NSException *exception = [NSException exceptionWithName:exceptionName reason:exceptionReason userInfo:exceptionUserInfo];
    
    NSString *aboutMe = @"太帅了";
    
    if ([aboutMe isEqualToString:@"太帅了"]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"捕获异常,是否抛出？" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *done = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //抛异常
            @throw exception;
        }];
        [alertController addAction:done];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

@end
