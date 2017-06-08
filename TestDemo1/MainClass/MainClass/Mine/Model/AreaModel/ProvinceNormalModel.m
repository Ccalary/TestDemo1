//
//  ProvinceNormalModel.m
//  TestDemo1
//
//  Created by caohouhong on 17/6/7.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "ProvinceNormalModel.h"

/**
 省
 */
@implementation ProvinceNormalModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"cities":@"CitiesNormalModel"};
}

@end

/**
 市
 */
@implementation CitiesNormalModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"locationDistricts":@"CountyNormalModel"};
}
@end


/**
 区
 */
@implementation CountyNormalModel

@end
