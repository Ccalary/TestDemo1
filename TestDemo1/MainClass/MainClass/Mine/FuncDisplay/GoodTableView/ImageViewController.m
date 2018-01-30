//
//  ImageViewController.m
//  TestDemo1
//
//  Created by caohouhong on 2017/11/21.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "ImageViewController.h"
#import "ImageTableViewCell.h"

@interface ImageViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ImageViewController
- (void)timerMethod{
    //啥都不干
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawView];
    [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
    [self addRunloopObserver];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)drawView{
    self.navigationItem.title = @"优化列表";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    ImageTableViewCell *cell = (ImageTableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
        cell = [[ImageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//    }
    cell.titleLabel.text = [NSString stringWithFormat:@"%d加载大图会卡顿不",(int)indexPath.row];
    cell.imageView1.image = [UIImage imageNamed:@"big_bg"];
    cell.imageView2.image = [UIImage imageNamed:@"big_bg"];
    cell.imageView3.image = [UIImage imageNamed:@"big_bg"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

//添加runloop观察器
- (void)addRunloopObserver{
    //获取runloop
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    //定义观察者
    static CFRunLoopObserverRef runloopObserver;
    /*
     typedef struct {
     CFIndex    version;
     void *    info;
     const void *(*retain)(const void *info);
     void    (*release)(const void *info);
     CFStringRef    (*copyDescription)(const void *info);
     } CFRunLoopObserverContext;
     */
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)self,
        &CFRetain,
        &CFRelease,
        NULL
    };
    
    //创建观察者
    runloopObserver = CFRunLoopObserverCreate(NULL, kCFRunLoopBeforeWaiting, YES, 0, &callBack, &context);
    //添加观察者
    CFRunLoopAddObserver(runloop, runloopObserver, kCFRunLoopDefaultMode);
    //释放
    CFRelease(runloopObserver);
}

void callBack(){
    DLog(@"callBack");
}
@end
