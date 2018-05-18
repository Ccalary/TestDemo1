//
//  MyWebImageVC.m
//  TestDemo1
//
//  Created by caohouhong on 2018/5/10.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "MyWebImageVC.h"
#import "MyCustomTableViewCell.h"
#import "FPSTools.h"


@interface MyWebImageVC ()
@property (nonatomic, strong) NSMutableArray<NSString *> *objects;
@property (nonatomic, strong) FPSTools *fps;
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) NSBlockOperation *lastOperation;
@property (nonatomic, strong) NSCache *operationCache; // 存储在下载的线程，避免同一个资源多次下载
@property (nonatomic, strong) NSMutableDictionary *imageMemaryCache; // 图片资源内存存储

@end

@implementation MyWebImageVC

- (void)viewDidLoad {
    [super viewDidLoad];

    __weak typeof (self) weakSelf = self;
    // 检测流畅度
    _fps = [[FPSTools alloc] init];
    _fps.block = ^(NSString *fpsStr) {
        weakSelf.navigationItem.title = fpsStr;
    };
    
    self.queue = [[NSOperationQueue alloc] init];
    // 最大线程数
    self.queue.maxConcurrentOperationCount = 6;
    
    _operationCache = [[NSCache alloc] init];
    _imageMemaryCache = [NSMutableDictionary dictionary];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]
                             initWithTitle:@"Start"
                             style:UIBarButtonItemStylePlain
                             target:self
                             action:@selector(start)];
    self.navigationItem.rightBarButtonItem = item;
    
    self.objects = [NSMutableArray array];
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"WebImagePlist" ofType:@"plist"]];
    [self.objects addObjectsFromArray:dictArray];

    for (int i=0; i<9; i++) {
        [self.objects addObject:[NSString stringWithFormat:@"http://images.cnblogs.com/cnblogs_com/kenshincui/613474/o_%i.jpg",i]];
    }

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.fps finish];
}

- (void)dealloc {
    NSLog(@"----delloc-----");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static UIImage *placeholderImage = nil;
    if (!placeholderImage){
        placeholderImage = [UIImage imageNamed:@"placeholder"];
    }
    
    MyCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell){
        cell = [[MyCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
    }
    cell.customTextLabel.text = [NSString stringWithFormat:@"Image #%ld", (long)indexPath.row];
    cell.customImageView.image = placeholderImage;
    // 图片地址有中文，进行转码处理
    NSString *imageStr = [self.objects[indexPath.row] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:imageStr];
    
    UIImage *cacheImage = self.imageMemaryCache[imageStr];
//    UIImage *cacheImage = [self.memoryCache objectForKey:imageStr];
    if (cacheImage){
        cell.customImageView.image = cacheImage;
    }else {
        // 如果队列中不存在当前图片资源，则开启线程去下载
        NSString *str = [self.operationCache objectForKey:imageStr];
        __weak typeof (self) weakSelf = self;
        if (!str){
            // 图片下载处理
            NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
                __strong typeof (weakSelf) sself = weakSelf;
                NSLog(@"开启子线程下载第%ld行",indexPath.row);
                NSData *data = [NSData dataWithContentsOfURL:url];
                if (!data){
                    [sself.operationCache removeObjectForKey:imageStr];
                    NSLog(@"图片下载失败");
                    return;
                }
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    // cell 真正的indexPath
                    NSIndexPath *currentIndexPath = [tableView indexPathForCell:cell];
                    NSInteger currentRow = currentIndexPath.row;
                    NSInteger originalRow = indexPath.row; // 当时的行
                    if (currentRow != originalRow){
                        //                    NSLog(@"你这个图片和当前要设置的cell图片不一致,你设置的是第%ld个cell,但现在要设置是%ld个cell", (long)originalRow, currentRow);
                        return ;
                    }
                    UIImage *image = [UIImage imageWithData:data];
                    cell.customImageView.image = image;
                    sself.imageMemaryCache[imageStr] = image;
                }];
                [sself.operationCache removeObjectForKey:imageStr];
            }];
            // 设置依赖关系-后进先出
            [self.lastOperation addDependency:blockOperation];
            self.lastOperation = blockOperation;
            // 将线程加入缓存
            [self.operationCache setObject:@"1" forKey:imageStr];
            // 线程添加到队列
            [self.queue addOperation:blockOperation];
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (void)start {
    [self.tableView reloadData];
    [self creatFile];
}

- (void)creatFile {
    NSString *libCachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [libCachePath stringByAppendingPathComponent:@"imageCache"];
    NSLog(@"cache:%@",fileName);
    
    BOOL isSuccess = [[NSFileManager defaultManager] createDirectoryAtPath:fileName withIntermediateDirectories:YES attributes:nil error:NULL];
    if (isSuccess){
        NSLog(@"文件夹创建成功");
    }
}
@end

