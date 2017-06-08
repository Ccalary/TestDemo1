//
//  HomeViewController.h
//  TestDemo1
//
//  Created by caohouhong on 17/3/15.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Realm;

@interface Dog : RLMObject
@property NSString *name;
@property NSString *sex;
@property NSInteger age;
@property int num;
@end

@interface HomeViewController : UIViewController

@end
