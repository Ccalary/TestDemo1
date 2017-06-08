//
//  CountyModel.h
//  TestDemo1
//
//  Created by caohouhong on 17/6/6.
//  Copyright © 2017年 caohouhong. All rights reserved.
//  县

#import <Realm/Realm.h>

@interface CountyModel : RLMObject
@property NSInteger locationDistrictId;
@property NSString *districtName;
@end
RLM_ARRAY_TYPE(CountyModel)
