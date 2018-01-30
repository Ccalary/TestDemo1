//
//  FluencyViewController.m
//  TestDemo1
//
//  Created by chh on 2018/1/30.
//  Copyright © 2018年 caohouhong. All rights reserved.
//  

#import "FluencyViewController.h"
#import "FluencyTableViewCell.h"
@interface FluencyViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSInteger _count;
    NSTimeInterval _lastTime;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation FluencyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 100; i++){
        [self.dataArray addObject:[NSString stringWithFormat:@"http://images.cnblogs.com/cnblogs_com/kenshincui/613474/o_%i.jpg",i%10]];
    }
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)initView{
    self.view.backgroundColor = [UIColor whiteColor];
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLink:)];
    [link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - TopFullHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)displayLink:(CADisplayLink *)link{
    if (_lastTime == 0){
        _lastTime = link.timestamp;
        return;
    }
    //每秒刷新帧率
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    float fps = _count / delta;
    _count = 0;
    self.navigationItem.title = [NSString stringWithFormat:@"%d FPS",(int)round(fps)];
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
    FluencyTableViewCell *cell = (FluencyTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[FluencyTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    [cell setImageStr:self.dataArray[indexPath.row] andTitle:[NSString stringWithFormat:@"%d", (int)indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

@end
