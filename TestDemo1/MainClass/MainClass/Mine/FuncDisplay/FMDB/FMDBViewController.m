//
//  FMDBViewController.m
//  TestDemo1
//
//  Created by caohouhong on 2021/4/19.
//  Copyright © 2021 caohouhong. All rights reserved.
//

#import "FMDBViewController.h"
#import <FMDB/FMDatabase.h>
#import <FMDB/FMDatabaseQueue.h>

@interface FMDBViewController ()

@end

@implementation FMDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)initView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"FMDB";
    
    NSArray *documentsPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask , YES);
    NSString *databaseFilePath=[[documentsPaths objectAtIndex:0] stringByAppendingPathComponent:@"student.sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:databaseFilePath];
    // 1、打开
    if (![db open]) {
        NSLog(@"打开失败");
        return;
    }
    NSLog(@"打开成功");
    // 2、创建表
    BOOL success = [db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, age INTEGER DEFAULT 1)"];
    if (success) {
      NSLog(@"创建表成功");
    }else{
        NSLog(@"创建表失败");
    }
    // 3、插入数据
    BOOL insertSuccess = [db executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?, ?);", @"jack", @(10)];
    if (insertSuccess){
        NSLog(@"插入成功");
    }else {
        NSLog(@"插入失败");
    }
    
    // 4.查询数据
    FMResultSet *result = [db executeQuery:@"SELECT id, name, age FROM t_student WHERE age > 1;"];
    while ([result next]) {
        NSDictionary *dic = [result resultDictionary];
        NSLog(@"dic:%@", dic);
        int ID = [result intForColumnIndex:0];
        NSString *name = [result stringForColumnIndex:1];
        int age = [result intForColumn:@"age"];
        NSLog(@"ID: %d, name: %@, age: %d", ID, name, age);
    }
    
    // 遍历查询
//    BOOL isSuccess = [db executeStatements:@"SELECT id, name, age FROM t_student WHERE age > 1;" withResultBlock:^int(NSDictionary * _Nonnull resultsDictionary) {
//        NSLog(@"resultsDictionary:%@",resultsDictionary);
//        return 0;
//    }];
    
    
    // 5.删除数据
    BOOL deleteSuccess = [db executeUpdate:@"DELETE FROM t_student WHERE age > 20 AND age < 25;"];
    if (deleteSuccess){
        NSLog(@"删除成功");
    }else {
        NSLog(@"删除失败");
    }
    
    // 6.修改数据
    BOOL updateSuccess = [db executeUpdate:@"UPDATE t_student SET name = 'liwx' WHERE age > 12 AND age < 15;"];
    if (updateSuccess){
        NSLog(@"修改成功");
    }else {
        NSLog(@"修改失败");
    }
}
@end
