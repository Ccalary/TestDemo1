//
//  IndustryList.h
//  TestDemo1
//
//  Created by caohouhong on 17/3/26.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import <Realm/Realm.h>
#import "IndustrayData.h"

RLM_ARRAY_TYPE(IndustrayData)
@interface IndustryList : RLMObject

@property RLMArray<IndustrayData *><IndustrayData> *data;
@end
