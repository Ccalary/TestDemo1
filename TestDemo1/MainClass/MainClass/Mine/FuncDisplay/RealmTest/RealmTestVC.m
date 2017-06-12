//
//  RealmTestVC.m
//  TestDemo1
//
//  Created by caohouhong on 17/6/6.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "RealmTestVC.h"
#import "ProvinceModel.h"
#import "HHPopButton.h"
#import "DemoHelper.h"
@import Realm;

@interface RealmTestVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UILabel *areaLabel;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) RLMArray *provinceArray;
@property (nonatomic, strong) RLMArray *cityArray;
@property (nonatomic, strong) RLMArray *countyArray;
@property (nonatomic, strong) NSString *province, *city, *county;//省、市、区
@property (nonatomic, assign) DataArrayType dataArrayType;
@end

@implementation RealmTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawView];
    //RLMArray初始化的方式
    self.provinceArray = [[RLMArray alloc] initWithObjectClassName:[ProvinceModel className]];
    self.cityArray = [[RLMArray alloc] initWithObjectClassName:[CityModel className]];
    self.countyArray = [[RLMArray alloc] initWithObjectClassName:[CountyModel className]];

    [self requestData];
}

//加载缓存数据
- (void)loadCacheData{
    self.dataArrayType = DataArrayTypeProvice;
    self.province = @"";
    self.county = @"";
    self.city = @"";
    self.areaLabel.text = @"";
    
    [self loadTypeData];
    [self.tableView reloadData];
}

- (void)loadTypeData{
    
    if (_dataArrayType == DataArrayTypeCounty){
        [self.countyArray removeAllObjects];
        RLMResults *results = [CountyModel allObjects];
        [self.countyArray addObjects:results];
    }else if (_dataArrayType == DataArrayTypeCity){
        [self.cityArray removeAllObjects];
        RLMResults *results = [CityModel allObjects];
        [self.cityArray addObjects:results];
    }else {
        [self.provinceArray removeAllObjects];
        RLMResults *results = [ProvinceModel allObjects];
        [self.provinceArray addObjects:results];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)drawView{
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 150*UIRate, 40)];
    //提示文字
    _searchBar.placeholder = @"搜索";
    //搜索框上方标题
    _searchBar.prompt = @"搜索框测试";
    
    self.navigationItem.titleView = _searchBar;
    
    
    _areaLabel = [[UILabel alloc] initWithFrame:CGRectMake(15*UIRate, 0, ScreenWidth - 50*UIRate, 45*UIRate)];
    _areaLabel.textColor = [UIColor lightGrayColor];
    _areaLabel.font = FONT_SYSTEM(15*UIRate);
    [self.view addSubview:_areaLabel];
    
    HHPopButton *resetButton = [[HHPopButton alloc] initWithFrame:CGRectMake(ScreenWidth - 45*UIRate, 2.5*UIRate, 40*UIRate, 40*UIRate)];
    [resetButton setTitle:@"复位" forState:UIControlStateNormal];
    [resetButton setBackgroundColor:[UIColor redColor]];
    
    [resetButton addTarget:self action:@selector(resetBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetButton];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45*UIRate, ScreenWidth, ScreenHeight - 45*UIRate) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_dataArrayType == DataArrayTypeCounty){
        return self.countyArray.count;
    }else if (_dataArrayType == DataArrayTypeCity){
        return self.cityArray.count;
    }else {
        return self.provinceArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (self.dataArrayType == DataArrayTypeCity){
        CityModel *model = self.cityArray[indexPath.row];
         cell.textLabel.text = [NSString stringWithFormat:@"%@-%ld",model.cityName, (long)model.cityId];
    }else if (self.dataArrayType == DataArrayTypeCounty){
        CountyModel *model = self.countyArray[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@-%ld",model.districtName, (long)model.locationDistrictId];
    }else {
        ProvinceModel *model = self.provinceArray[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@-%ld",model.provinceName, (long)model.provinceId];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   if (self.dataArrayType == DataArrayTypeProvice){
        
        ProvinceModel *model = self.provinceArray[indexPath.row];
        self.province = model.provinceName;
        [self.cityArray removeAllObjects];
       
        [self.cityArray addObjects:model.cities];
       
        self.dataArrayType = DataArrayTypeCity;
    }else  if (self.dataArrayType == DataArrayTypeCity){
        CityModel *model = self.cityArray[indexPath.row];
        self.city = model.cityName;
        [self.countyArray removeAllObjects];
        
        [self.countyArray addObjects:model.locationDistricts];
        self.dataArrayType = DataArrayTypeCounty;
    }else {
        CountyModel *countyModel = self.countyArray[indexPath.row];
        self.county = countyModel.districtName;
    }
    
    self.areaLabel.text = [NSString stringWithFormat:@"%@ %@ %@", self.province, self.city, self.county];
    [self.tableView reloadData];
}

- (void)resetBtnAction{
    [self loadCacheData];
}

- (void)requestData{
    
    int oldTimeStamp = [DemoHelper getAreaRequestTimeStamp];
    int nowTimeStamp = (int)[[NSDate date] timeIntervalSince1970];
    
    //更新频率／s
    if ((nowTimeStamp - oldTimeStamp) < 7*24*60*60){
        [self loadCacheData];
        return;
    }
    [DemoHelper setAreaRequestTimeStamp:nowTimeStamp];
    
    RLMResults *results = [ProvinceModel allObjects];
    RLMRealm *r = [RLMRealm defaultRealm];
    
    [r beginWriteTransaction];
    [r deleteObjects:results];
    [r commitWriteTransaction];
    
    NSURL *url = [NSURL URLWithString:@"http://www.58caibiao.com:8788/cbapiprj/webService/location/listLocationForTree"];
    NSMutableURLRequest *mutableRequest = [NSMutableURLRequest requestWithURL:url];
    //设置请求方式
    [mutableRequest setHTTPMethod:@"POST"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:mutableRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //json转字典
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NULL];
        
        //model映射，可直接转化为realm的数组类型
        RLMArray *array =(RLMArray *)[ProvinceModel mj_objectArrayWithKeyValuesArray:[dict objectForKey:@"data"]];
        DLog(@"%@",array);
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm addObjects:array];
        [realm commitWriteTransaction];
        
        //主线程更新数据
        dispatch_sync(dispatch_get_main_queue(), ^{
             [self loadCacheData];
        });
    }];
    //4.执行任务
    [dataTask resume];
}
@end
