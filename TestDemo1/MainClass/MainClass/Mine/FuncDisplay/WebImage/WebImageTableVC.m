//
//  WebImageTableVC.m
//  TestDemo1
//
//  Created by caohouhong on 2018/5/10.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "WebImageTableVC.h"

@interface WebImageTableVC ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *classNameArray;
@end

@implementation WebImageTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    self.classNameArray = [NSMutableArray array];
    [self addCell:@"SDWebImage" class:@"SDWebImageTableVC"];
    [self addCell:@"MyWebImage" class:@"MyWebImageVC"];
}

//添加标题和类名
- (void)addCell:(NSString *)title class:(NSString *)className {
    [self.dataArray addObject:title];
    [self.classNameArray addObject:className];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CellID"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    Class class = NSClassFromString(self.classNameArray[indexPath.row]);
    if (class){
        UIViewController *vc = class.new;
        vc.title = self.dataArray[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
