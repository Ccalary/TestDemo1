//
//  IndustrayData.h
//  TestDemo1
//
//  Created by caohouhong on 17/3/26.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import <Realm/Realm.h>

RLM_ARRAY_TYPE(IndustrayData)
@interface IndustrayData : RLMObject
//行业名称
@property NSString *name;
//行业代号
@property NSNumber<RLMInt> *id;

@property RLMArray<IndustrayData *><IndustrayData> *children;
@end

