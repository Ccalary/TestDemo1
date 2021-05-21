//
//  DetailViewController.m
//  TestDemo1
//
//  Created by caohouhong on 2021/4/20.
//  Copyright © 2021 caohouhong. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"title  %@",self.titleString);
    
    self.navigationItem.title = self.titleString;
}

// 底部预览界面选项
-(NSArray<id<UIPreviewActionItem>> *)previewActionItems
{
    UIPreviewAction *p1 = [UIPreviewAction actionWithTitle:@"选项1" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"1111111");
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"111111" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }];
    
    
    UIPreviewAction *p2 = [UIPreviewAction actionWithTitle:@"选项2" style:UIPreviewActionStyleSelected handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"2222222222");
    }];
    
    
    UIPreviewAction *p3 = [UIPreviewAction actionWithTitle:@"选项3" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"3333333333");
        
    }];
    
    return @[p1,p2,p3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
