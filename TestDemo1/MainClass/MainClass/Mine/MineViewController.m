//
//  MineViewController.m
//  TestDemo1
//
//  Created by caohouhong on 17/4/16.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "MineViewController.h"
#import "HomeViewController.h"
#import "IconfontViewController.h"

@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
//保存原始数据
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *classNameArray;
//保存搜索数据
@property (nonatomic, strong) NSArray *searchArray;
//是否是搜索状态
@property (nonatomic, assign) BOOL isSearch;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.searchArray = [[NSArray alloc] init];
    self.dataArray = @[].mutableCopy;
    self.classNameArray = @[].mutableCopy;
    
    [self addCell:@"小控件" class:@"WidgetViewController"];
    [self addCell:@"全选、删除操作" class:@"SelectAndDeleteVC"];
    [self addCell:@"tableView优化" class:@"ImageViewController"];
    [self addCell:@"runningTime" class:@"RuningTimeViewController"];
    [self addCell:@"异常捕获" class:@"ExceptionViewController"];
    [self addCell:@"抛出异常" class:@"MakeExpViewController"];
    [self addCell:@"GCD使用" class:@"GCDViewController"];
    [self addCell:@"拖动，摇晃，截屏" class:@"EventViewController"];
    [self addCell:@"蓝牙" class:@"BluetoothVC"];
    [self addCell:@"贝赛尔曲线" class:@"BezierPathVC"];
    [self addCell:@"渐变色" class:@"GradientViewController"];
    [self addCell:@"进度条" class:@"CircleProgressVC"];
    [self addCell:@"showHUD" class:@"ShowHUDViewController"];
    [self addCell:@"Animation" class:@"LoadingAnimationVC"];
    [self addCell:@"Layer、Animation" class:@"LayerAnimationVC"];
    [self addCell:@"粒子动画" class:@"CAEmitterLayerVC"];
    [self addCell:@"界面流畅" class:@"FluencyViewController"];
    [self addCell:@"数据持久化" class:@"DataViewController"];
    [self addCell:@"IconFont" class:@"IconfontViewController"];
    [self addCell:@"转场动画" class:@"TransitonViewController"];
    
    [self drawView];
}

//添加标题和类名
- (void)addCell:(NSString *)title class:(NSString *)className {
    [self.dataArray addObject:title];
    [self.classNameArray addObject:className];
}

- (void)drawView{
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = item;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.allowsMultipleSelectionDuringEditing = YES;
//    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
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
    
    if (tableView.isEditing || _isSearch) return;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //运用runningTime 判断VC进行跳转
    NSString *className = self.classNameArray[indexPath.row];
    Class class = NSClassFromString(className);
    if (class){
        UIViewController *vc = class.new;
        vc.navigationItem.title = self.dataArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark 右编辑
- (void)rightItemAction:(UIBarButtonItem *)item
{
    if (!self.tableView.isEditing){
        item.title = @"完成";
        [self.tableView setEditing:YES animated:YES];
    }else {
        item.title = @"编辑";
       [self.tableView setEditing:NO animated:YES];
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
