//
//  MineViewController.m
//  TestDemo1
//
//  Created by caohouhong on 17/4/16.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "MineViewController.h"
#import "HomeViewController.h"

@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
//保存原始数据
@property (nonatomic, strong) NSMutableArray *dataArray;
//保存搜索数据
@property (nonatomic, strong) NSArray *searchArray;
//是否是搜索状态
@property (nonatomic, assign) BOOL isSearch;

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
   
    self.searchArray = [[NSArray alloc] init];
    
    NSArray *array = @[@"showHUD",@"runningTime",@"异常捕获",@"抛出异常",@"rrrr",@"run",@"shang"];
    
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
    
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 180, ScreenWidth, 80)];
    //提示文字
    _searchBar.placeholder = @"搜索";
    //搜索框上方标题
    _searchBar.prompt = @"搜索框测试";
    _searchBar.showsCancelButton = YES;
    _searchBar.delegate = self;
    //搜索输入闪烁符的颜色
    //    _searchBar.tintColor = [UIColor redColor];
    //背景色
    //    _searchBar.barTintColor = COLOR_Background;
    
    self.tableView.tableHeaderView = self.searchBar;
    
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
    //是否搜索状态
    if (_isSearch){
        return _searchArray.count;
    }else {
        return _dataArray.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text =  _isSearch ? self.searchArray[indexPath.row] : self.dataArray[indexPath.row];

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

#pragma mark - UISearchBarDelegate
//取消按钮的点击事件
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    //取消搜索状态
    _isSearch = NO;
    //关闭键盘
    [searchBar resignFirstResponder];
    [self.tableView reloadData];
}

//当搜索框内的文本改变时激发该方法
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    [self filterBySubstring:searchText];
}
//点击search按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self filterBySubstring:searchBar.text];
    //关闭键盘
    [searchBar resignFirstResponder];
}

//过滤
- (void)filterBySubstring:(NSString *)substr{
    //设置搜索状态
    _isSearch = YES;
    //定义搜索谓词
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", substr];
    //使用谓词过滤NSArray
    _searchArray = [_dataArray filteredArrayUsingPredicate:pred];
    //让表格重新加载数据
    [self.tableView reloadData];
}


@end
