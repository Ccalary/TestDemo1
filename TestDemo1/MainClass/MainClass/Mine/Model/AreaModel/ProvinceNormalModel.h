//
//  ProvinceNormalModel.h
//  TestDemo1
//
//  Created by caohouhong on 17/6/7.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 省
 */
@interface ProvinceNormalModel : NSObject

@property (nonatomic, copy) NSString *provinceName;
@property (nonatomic, assign) NSInteger provinceId;

@property (nonatomic, strong) NSArray *cities;
@end


/**
 市
 */
@interface CitiesNormalModel : NSObject
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, assign) NSInteger cityId;
@property (nonatomic, strong) NSArray *locationDistricts;
@end


/**
 区
 */
@interface CountyNormalModel : NSObject
@property (nonatomic, copy) NSString *districtName;
@property (nonatomic, assign) NSInteger locationDistrictId;
@end
