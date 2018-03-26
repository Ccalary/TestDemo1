//
//  DataViewController.m
//  TestDemo1
//
//  Created by chh on 2018/1/30.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "DataViewController.h"
#import "StudentsModel.h"

@interface DataViewController ()

@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPathView];
    [self plistMethod];
    [self keyedArchiverMethod];
    

    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor greenColor].CGColor;
    layer.frame = CGRectMake(0, 400, 100, 100);
    [self.view.layer addSublayer:layer];
    
    UIView *cView = [[UIView alloc] initWithFrame:CGRectMake(0, 510, 100, 100)];
    cView.backgroundColor = [UIColor redColor];
    [self.view addSubview:cView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cView.frame = CGRectOffset(cView.frame, 200, 0);
        layer.frame = CGRectOffset(layer.frame, 100, 0);
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/**
 *  iOS程序默认情况下只能访问程序自己的目录，这个目录被称为“沙盒”。
 *  沙盒文件夹包括
 *  1、应用程序包: 这里面存放的是应用程序的源文件，包括资源文件和可执行文件
 *  2、Document: 最常用的目录，iTunes同步该应用时会同步此文件夹中的内容，适合存储重要数据
 *  3、Library／Caches:  iTunes不会同步此文件夹，适合存储体积大，不需要备份的非重要数据
       Library/Preferences: iTunes同步该应用时会同步此文件夹中的内容，通常保存应用的设置信息。
 *  4、tmp: 系统可能在应用没运行时就删除该目录下的文件，所以此目录适合保存应用中的一些临时文件，用完就删除。
 */

- (void)initPathView{
    self.view.backgroundColor = [UIColor whiteColor];
    
    //1.包地址获取
    NSString *appPath = [[NSBundle mainBundle] bundlePath];
    
    UILabel *appLabel = [self creatLabelWithText:[NSString stringWithFormat:@"应用包地址：%@",appPath]];
    [appLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(10);
        make.top.offset(10);
    }];
    //2、document地址
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    UILabel *docLabel = [self creatLabelWithText:[NSString stringWithFormat:@"常用目录地址：%@",docPath]];
    [docLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(10);
        make.top.mas_equalTo(appLabel.mas_bottom).offset(10);
    }];
    //3、cache地址
    NSString *libCachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    UILabel *libCacheLabel = [self creatLabelWithText:[NSString stringWithFormat:@"cache地址：%@",libCachePath]];
    [libCacheLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(10);
        make.top.mas_equalTo(docLabel.mas_bottom).offset(10);
    }];
    //4、临时文件地址
    NSString *temPath = NSTemporaryDirectory();
    UILabel *temLabel = [self creatLabelWithText:[NSString stringWithFormat:@"临时文件地址：%@",temPath]];
    [temLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.right.offset(10);
        make.top.mas_equalTo(libCacheLabel.mas_bottom).offset(10);
    }];
}

/**
 *  数据持久化方案
 *  1、plist(属性列表)
 *  2、NSUserDefaults（偏好设置）
 *  3、NSKeyedArchiver (归档)
 *  4、SQLite 3
 *  5、CoreData
 */

// plist文件处理
/* 支持的类型
 NSArray;NSMutableArray;
 NSDictionary;NSMutableDictionary;
 NSData;NSMutableData;
 NSString;NSMutableString;
 NSNumber;
 NSDate;
 */
- (void)plistMethod{
    //1、获取文件路径
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [docPath stringByAppendingPathComponent:@"123.plist"];
    //2、存储
    NSArray *array = @[@"a",@"b",@"c"];
    [array writeToFile:fileName atomically:YES];
    
//    NSString *str = @"plist";
//    [str writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:nil];
    //3、读取
    NSArray *result = [NSArray arrayWithContentsOfFile:fileName];
//    NSString *result = [NSString stringWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"plist读取数据：%@", result);
}

// 归档、解档
- (void)keyedArchiverMethod{
//    //归档
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *fileName = [docPath stringByAppendingPathComponent:@"student.data"];
    StudentsModel *student = [[StudentsModel alloc] init];
    student.avatar = [UIImage imageNamed:@"icon_xin_s"];
    student.name = @"MC";
    student.age = 26;
    [NSKeyedArchiver archiveRootObject:student toFile:fileName];
    
    //解档
    StudentsModel *sModel = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
    if (sModel){
        NSLog(@"%@-%@-%ld",sModel.avatar,sModel.name,(long)sModel.age);
    }
}

- (UILabel *)creatLabelWithText:(NSString *)text{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.numberOfLines = 0;
    [self.view addSubview:label];
    return label;
}
@end
