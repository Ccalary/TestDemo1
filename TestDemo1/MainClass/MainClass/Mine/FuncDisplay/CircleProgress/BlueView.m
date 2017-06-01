//
//  BlueView.m
//  TestDemo1
//
//  Created by caohouhong on 17/5/31.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "BlueView.h"

@interface BlueView()
@property (nonatomic, strong) CAShapeLayer *colorLayer;
@end

@implementation BlueView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        
        
    }
    return self;
}

- (void)setupColorLayer{
    
    self.colorLayer = [CAShapeLayer layer];
    
    
}

@end
