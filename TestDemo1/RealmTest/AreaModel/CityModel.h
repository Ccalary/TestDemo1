//
//  CityModel.h
//  TestDemo1
//
//  Created by caohouhong on 17/6/6.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import <Realm/Realm.h>
#import "CountyModel.h"


@interface CityModel : RLMObject
@property NSInteger cityId;
@property NSString *cityName;
@property RLMArray<CountyModel *><CountyModel> *locationDistricts;
@end

RLM_ARRAY_TYPE(CityModel)
