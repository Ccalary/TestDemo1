//
//  BezierPathVC.m
//  TestDemo1
//
//  Created by caohouhong on 17/6/8.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "BezierPathVC.h"
#import "BezierPathViewBase.h"
#import "BezierPathViewSquare.h"
#import "BezierPathViewRound.h"
#import "BezierPathQuadCurve.h"

@interface BezierPathVC ()
@property (nonatomic, strong) BezierPathViewBase *baseView;
@property (nonatomic, strong) BezierPathViewSquare *squareView;
@property (nonatomic, strong) BezierPathViewRound *roundView;
@property (nonatomic, strong) BezierPathQuadCurve *quadCurveView;
@end

@implementation BezierPathVC


- (void)loadView{
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _baseView = [BezierPathViewBase addViewTo:self.view];
    _squareView = [BezierPathViewSquare addViewTo:self.view];
    _roundView = [BezierPathViewRound addViewTo:self.view];
    _quadCurveView = [BezierPathQuadCurve addViewTo:self.view];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
