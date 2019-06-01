//
//  FirstViewController.m
//  TestDemo1
//
//  Created by caohouhong on 17/3/23.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "FirstViewController.h"
#import "HHCountingLabel.h"
#import "UICountingLabel.h"



@interface FirstViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIRefreshControl *refresh;

@end

@implementation FirstViewController

- (NSMutableArray *)dataArray
{
    if (!_dataArray){
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self drawView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)dealloc{
    DLog(@"*****dealloc***")
}

- (void)drawView{
    
    HHCountingLabel *label = [[HHCountingLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    label.text = @"0";
    [label countFrom:0 toValue:100 withDuration:10];
    
    UICountingLabel *countingLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(100, 0, 100, 20)];
    countingLabel.text = @"0";
    [countingLabel countFrom:0 to:100 withDuration:10];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self.tableView addSubview:label];
    [self.tableView addSubview:countingLabel];
    
    //系统自带下拉刷新
    _refresh = [[UIRefreshControl alloc] init];
    _refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"松开刷新"];
    [_refresh addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:_refresh];
    
}

- (void)refreshAction{
    [_refresh endRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *const cellId = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

@end
