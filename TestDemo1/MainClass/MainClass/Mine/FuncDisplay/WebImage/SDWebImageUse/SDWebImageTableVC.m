//
//  SDWebImageTableVC.m
//  TestDemo1
//
//  Created by caohouhong on 2018/5/8.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "SDWebImageTableVC.h"

#import "UIView+WebCache.h"
#import "UIImageView+WebCache.h"
#import "MyCustomTableViewCell.h"
#import "FPSTools.h"

@interface SDWebImageTableVC ()
@property (nonatomic, strong) NSMutableArray<NSString *> *objects;
@property (nonatomic, strong) FPSTools *fps;
@end

@implementation SDWebImageTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof (self) weakSelf = self;
    // 检测流畅度
    _fps = [[FPSTools alloc] init];
    _fps.block = ^(NSString *fpsStr) {
        weakSelf.navigationItem.title = fpsStr;
    };

    UIBarButtonItem *item = [[UIBarButtonItem alloc]
                             initWithTitle:@"Clear Cache"
                             style:UIBarButtonItemStylePlain
                             target:self
                             action:@selector(flushCache)];
    self.navigationItem.rightBarButtonItem = item;
     NSArray *dictArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"WebImagePlist" ofType:@"plist"]];
    self.objects = [NSMutableArray arrayWithArray:dictArray];
    for (int i=0; i<9; i++) {
        [self.objects addObject:[NSString stringWithFormat:@"http://images.cnblogs.com/cnblogs_com/kenshincui/613474/o_%i.jpg",i]];
    }
    // 禁止使用图片解压
    [[SDImageCache sharedImageCache].config setShouldDecompressImages:NO];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.fps finish];
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
    [cell.customImageView sd_setShowActivityIndicatorView:YES];
    [cell.customImageView sd_setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    cell.customTextLabel.text = [NSString stringWithFormat:@"Image #%ld", (long)indexPath.row];
    NSString *imageStr = [self.objects[indexPath.row] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:imageStr];
    [cell.customImageView sd_setImageWithURL:url
                            placeholderImage:placeholderImage
                                     options:indexPath.row == 0 ? SDWebImageRefreshCached : 0];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

#pragma mark 清空缓存
- (void)flushCache {
    [SDWebImageManager.sharedManager.imageCache clearMemory];
    [SDWebImageManager.sharedManager.imageCache clearDiskOnCompletion:nil];
}

@end
