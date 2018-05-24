//
//  SelectAndDeleteVC.m
//  TestDemo1
//
//  Created by caohouhong on 17/6/6.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "SelectAndDeleteVC.h"

@interface SelectAndDeleteVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
//底部删除View
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *selectButton;
@end

@implementation SelectAndDeleteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = [[NSMutableArray alloc] initWithArray:@[@"测试数据1",@"测试数据2",@"测试数据3"]];
    
    [self drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)drawView{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction:)];
    self.navigationItem.rightBarButtonItem = item;
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //在编辑时可以多选，开启后就显示圆形选择框
    _tableView.allowsMultipleSelectionDuringEditing = YES;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
    [self.view addSubview:self.bottomView];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
}


- (UIView *)bottomView{
    if (!_bottomView){
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight , ScreenWidth, 50*UIRate)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        UIButton *selectButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth/2.0, 50*UIRate)];
        [selectButton setTitle:@"全选" forState:UIControlStateNormal];
        [selectButton setBackgroundColor:[UIColor grayColor]];
        [selectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:selectButton];
        
        UIButton *deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth/2.0, 0, ScreenWidth/2.0, 50*UIRate)];
        [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [deleteButton setBackgroundColor:[UIColor redColor]];
        [deleteButton addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:deleteButton];
        
    }
    return _bottomView;
}

//走了左滑删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    DLog(@"走了左滑删除%ld", (long)indexPath.row);
    if (editingStyle == UITableViewCellEditingStyleDelete){//删除操作
        [self.dataArray removeObjectAtIndex:indexPath.row];
        
        //删除某行并配有动画
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

//更改左滑后的字体显示
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    //如果系统是英文，会显示delete,这里可以改成自己想显示的内容
    return @"删除";
}

//全选
- (void)selectButtonAction:(UIButton *)button{
    
    if ([button.currentTitle isEqualToString:@"全选"]){
        //遍历循环
        [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //全选
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        }];
        
        [button setTitle:@"全不选" forState:UIControlStateNormal];
    }else {
        //刷新数据即可实现全不选状态
        [self.tableView reloadData];
        [button setTitle:@"全选" forState:UIControlStateNormal];
    }
}

//删除
- (void)deleteBtnAction:(UIButton *)button{
    
    //indexPathsForSelectedRows 可以获得选中的行
    NSArray *array = self.tableView.indexPathsForSelectedRows;
    if (!array.count){
        [LCProgressHUD showMessage:@"请选择要删除的列表"];
        return;
    }
    
    NSMutableArray *selectArray = [[NSMutableArray alloc] init];
    
    for (NSIndexPath *indexPath in array){
        //取出数据
        [selectArray addObject:self.dataArray[indexPath.row]];
    }
    //删除数据
    [self.dataArray removeObjectsInArray:selectArray];
    //删除行
    [self.tableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark 右编辑
- (void)rightItemAction:(UIBarButtonItem *)item
{
    if (!self.tableView.isEditing){
        item.title = @"取消";
        //伴随编辑动画
        [self.tableView setEditing:YES animated:YES];
        
        [UIView animateWithDuration:0.5 animations:^{
            self.bottomView.frame = CGRectMake(0, ScreenHeight - 50, ScreenWidth, 50);
        }];
        
    }else {
        item.title = @"编辑";
        [self.tableView setEditing:NO animated:YES];
        [UIView animateWithDuration:0.5 animations:^{
            self.bottomView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 50);
        }];
    }
}
@end
