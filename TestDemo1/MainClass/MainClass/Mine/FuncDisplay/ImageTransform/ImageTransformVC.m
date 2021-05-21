//
//  ImageTransformVC.m
//  TestDemo1
//
//  Created by caohouhong on 2020/7/10.
//  Copyright © 2020 caohouhong. All rights reserved.
//

#import "ImageTransformVC.h"
#import <AGGeometryKit/AGGeometryKit.h>

@interface ImageTransformVC ()

@end

@implementation ImageTransformVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"图像变化";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initView];
}

- (void)initView {
   UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 1, 1)]; // create a view
    view.image = [UIImage imageNamed:@"img_190"];
   [self.view addSubview:view];
   [view.layer ensureAnchorPointIsSetToZero]; // set the anchor point to [0, 0] (this method keeps the same position)

   AGKQuad quad = view.layer.quadrilateral;
   quad.br.x += 20; // shift bottom right x-value with 20 pixels
   quad.br.y += 50; // shift bottom right y-value with 50 pixels
   quad.tr.x += 30;

   view.layer.quadrilateral = quad; // the quad is converted to CATransform3D and applied
}
@end
