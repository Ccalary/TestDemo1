//
//  ProvinceModel.h
//  TestDemo1
//
//  Created by caohouhong on 17/6/6.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import <Realm/Realm.h>
#import "CityModel.h"

@interface ProvinceModel : RLMObject
@property NSString *provinceName;
@property NSInteger provinceId;
@property RLMArray<CityModel *><CityModel> *cities;
@end
