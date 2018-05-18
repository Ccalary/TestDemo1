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
    
//    [self getHomePath];
//    [self getDocumentsPath];
//    [self createFolder];
//    [self createFile];
//    [self writeFile];
//    [self addFile];
//    [self writeImage];
//    [self getFileData:@""];
//    [self getFileSizeWithPath:@""];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
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

// 获取沙盒路径
- (NSString *)getHomePath {
    NSString *homePath = NSHomeDirectory();
    NSLog(@"path:%@",homePath);
    return homePath;
}

// 获取Documents路径
- (NSString *)getDocumentsPath {
    // 检索指定路径，
    //参数1-搜索的路径名称
    //参数2-限定了在沙盒内部
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = docPaths.firstObject;
    return documentPath;
}

// 获取Library路径
- (NSString *)getLibraryPath {
    NSArray *libPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryPath = libPaths.firstObject;
    return libraryPath;
}

// 获取Cache路径
- (NSString *)getCachePath {
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = cachePaths.firstObject;
    return cachePath;
}

// 获取Tmp路径
- (NSString *)getTmpPath {
    NSString *tmpPath = NSTemporaryDirectory();
    return tmpPath;
}

// 路径函数处理
- (void)parsePath {
    NSString *path = @"/Library/Developer/CoreSimulator/Devices/test.png";
    // 获得路径的各个组成部分
    NSArray *array = [path pathComponents];
    // 提取路径最后一个组成部分
    NSString *lastName = [path lastPathComponent];
    // 删除路径最后一个组成部分
    NSString *delPath = [path stringByDeletingLastPathComponent];
    // 添加文件
    NSString *addStr = [delPath stringByAppendingPathComponent:@"area.plist"];
    NSLog(@"%@%@%@%@",array,lastName,delPath,addStr);
}

// NSData 数据转换
- (void)dataChange:(NSData *)data {
    // NSString类型
    // NSData -> NSString
    NSString *aString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    // NSString -> NSData
    NSData *aData = [aString dataUsingEncoding:NSUTF8StringEncoding];
    
    // UIImage类型
    // NSData -> UIImage
    UIImage *image = [UIImage imageWithData:data];
    
    //UIImage -> NSData
    NSData *imageData1 = UIImagePNGRepresentation(image);
    NSData *imageData2 = UIImageJPEGRepresentation(image, 1);
    
    NSLog(@"%@%@%@",aData,imageData1,imageData2);
}

// 创建文件夹
- (void)createFolder {
    NSString *docPath = [self getDocumentsPath];
    NSString *folderName = [docPath stringByAppendingPathComponent:@"note"];
    NSFileManager *manager = [NSFileManager defaultManager];
    // 创建文件夹
    // path 文件路径
    // withIntermediateDirectories: YES 如果文件夹存在可以覆盖 NO 不可覆盖
    BOOL isSuccess = [manager createDirectoryAtPath:folderName withIntermediateDirectories:YES attributes:nil error:nil];
    if (isSuccess){
        NSLog(@"文件夹创建成功");
    }else {
        NSLog(@"文件夹创建失败");
    }
}

// 创建文件
- (void)createFile {
    NSString *docPath = [self getDocumentsPath];
    NSString *testPath = [docPath stringByAppendingPathComponent:@"note"];
    NSString *filePath = [testPath stringByAppendingPathComponent:@"note.txt"];
    NSFileManager *manager = [NSFileManager defaultManager];
    // 创建文件
    // contents: NSData 类型
    BOOL isSuccess = [manager createFileAtPath:filePath contents:nil attributes:nil];
    if (isSuccess){
        NSLog(@"文件创建成功!");
    }else {
        NSLog(@"文件创建失败!");
    }
}

// 写入文件
- (void)writeFile {
    NSString *docPath = [self getDocumentsPath];
    NSString *testPath = [docPath stringByAppendingPathComponent:@"note"];
    NSString *filePath = [testPath stringByAppendingPathComponent:@"note.txt"];
    NSString *content = @"我的笔记";
    BOOL isSuccess = [content writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (isSuccess){
        NSLog(@"写入文件成功!");
    }else {
        NSLog(@"写入文件失败!");
    }
}

// 追加内容
- (void)addFile {
    NSString *docPath = [self getDocumentsPath];
    NSString *testPath = [docPath stringByAppendingPathComponent:@"note"];
    NSString *filePath = [testPath stringByAppendingPathComponent:@"note.txt"];
    // 打开文件、准备更新
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
    // 将节点跳转到文件的末尾
    [fileHandle seekToEndOfFile];
    NSString *string = @"这是要添加的内容";
    NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    // 写入内容
    [fileHandle writeData:stringData];
    // 最后要关闭文件
    [fileHandle closeFile];
}

// 删除文件
- (void)deleteFile {
    NSString *docPath = [self getDocumentsPath];
    NSString *testPath = [docPath stringByAppendingPathComponent:@"note"];
    NSString *filePath = [testPath stringByAppendingPathComponent:@"note.txt"];
    NSFileManager *manager = [NSFileManager defaultManager];
    // 检测文件是否存在
    BOOL isExit = [self fileExist:filePath];
    if (isExit){
        // 删除文件
        BOOL isSuccess = [manager removeItemAtPath:filePath error:nil];
        if (isSuccess) {
            NSLog(@"文件删除成功！");
        }else {
            NSLog(@"文件删除失败！");
        }
    }
}

// 检测文件是否存在
- (BOOL)fileExist:(NSString *)filePath {
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return YES;
    }else {
        return NO;
    }
}

// 写入图片
- (void)writeImage {
    UIImage *image = [UIImage imageNamed:@"coin"];
    NSData *data = UIImagePNGRepresentation(image);
    NSString *docPath = [self getDocumentsPath];
    NSString *testPath = [docPath stringByAppendingPathComponent:@"imageCache"];
    NSString *fileName = [testPath stringByAppendingPathComponent:@"image1"];
    if (![self fileExist:testPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:testPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if (![self fileExist:fileName]) {
        [[NSFileManager defaultManager] createFileAtPath:fileName contents:nil attributes:nil];
    }
    BOOL isSuccess = [data writeToFile:fileName atomically:YES];
    if (isSuccess){
        NSLog(@"写入图片成功！");
    }else {
        NSLog(@"写入图片失败！");
    }
    
}

//获取文件
- (NSData *)getFileData:(NSString *)filePath {
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    NSData *fileData = [handle readDataToEndOfFile];
    [handle closeFile];
    return fileData;
}


//获取文件大小
- (long long)getFileSizeWithPath:(NSString *)path {
    unsigned long long fileLength = 0;
    NSNumber *fileSize;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:path error:nil];
    if ((fileSize = [fileAttributes objectForKey:NSFileSize])) {
        fileLength = [fileSize unsignedLongLongValue]; //单位是 B
    }
    return fileLength / 1000; //换算为K
}

//获取文件创建时间
- (NSString *)getFileCreatDateWithPath:(NSString *)path
{
    NSString *date = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:path error:nil];
    date = [fileAttributes objectForKey:NSFileCreationDate];
    return date;
}

@end
