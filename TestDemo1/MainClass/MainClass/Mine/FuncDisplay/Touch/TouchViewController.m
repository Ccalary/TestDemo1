//
//  TouchViewController.m
//  TestDemo1
//
//  Created by caohouhong on 2021/4/16.
//  Copyright © 2021 caohouhong. All rights reserved.
//

#import "TouchViewController.h"
#import "DetailViewController.h"

@interface TouchViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *mainTable;
}

@end

@implementation TouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"首页";
    
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您的手机支持3dtouch" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
         /** 注册当前view */
        [self registerForPreviewingWithDelegate:self sourceView:self.view];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"很遗憾您的手机不支持3dtouch" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    mainTable = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    mainTable.delegate = self;
    mainTable.dataSource = self;
    [self.view addSubview:mainTable];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellId = [NSString stringWithFormat:@"%ld--%ld",(long)indexPath.section,(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    cell.textLabel.text = cellId;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -  previewing Delegate
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
     /** 转换坐标 */
    CGPoint p = [mainTable convertPoint:location fromView:self.view];
    
     /** 通过坐标活的当前cell indexPath */
    NSIndexPath *indexPath = [mainTable indexPathForRowAtPoint:p];
    
     /** 获得当前cell */
    UITableViewCell *cell = [mainTable cellForRowAtIndexPath:indexPath];
    
    DetailViewController *detail = [[DetailViewController alloc] init];
//    detail.preferredContentSize = CGSizeMake(0, 120);
    detail.view.frame = self.view.frame;
    
    detail.titleString = cell.textLabel.text;
    
    if (indexPath.row > 6)
    {
        return nil;
    }
    
    return detail;
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    [self showViewController:viewControllerToCommit sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
