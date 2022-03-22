//
//  PathAnimationView.m
//  TestDemo1
//
//  Created by caohouhong on 2022/3/18.
//  Copyright © 2022 caohouhong. All rights reserved.
//

#import "OCPathAnimationView.h"

@interface OCPathAnimationView()

@end
@implementation OCPathAnimationView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.pathCornerRadius = 5.0;
        [self initView];
    }
    return self;
}

- (void)initView {
    CGPoint firstPoint = CGPointMake(50, 50);
    CGPoint secontPoint = CGPointMake(100, 50);
    CGPoint thirdPoint = CGPointMake(100, 150);
    CGPoint fourPoint = CGPointMake(150, 150);
    CGPoint fivePoint = CGPointMake(150, 300);
    CGPoint sixPoint = CGPointMake(50, 300);
    
    NSArray *pointArray = @[NSStringFromCGPoint(firstPoint),NSStringFromCGPoint(secontPoint),NSStringFromCGPoint(thirdPoint),NSStringFromCGPoint(fourPoint),NSStringFromCGPoint(fivePoint),NSStringFromCGPoint(sixPoint)];
    
    [self initAnimationWithPointArray:pointArray];
}

- (void)initAnimationWithPointArray:(NSArray *)pointArray {
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    for (int i = 0; i < pointArray.count; i++) {
        CGPoint point = CGPointFromString(pointArray[i]);
        if (i == 0) { // 开始点
            [linePath moveToPoint:point];
        }else if (i == pointArray.count - 1) { // 终止点
            [linePath addLineToPoint:point];
        }else {
            CGPoint lastPoint = CGPointFromString(pointArray[i-1]);
            CGPoint nextPoint = CGPointFromString(pointArray[i+1]);
//            CGPoint centerPoint = CGPointZero;
//            CGPoint pointA = point;
            CGFloat startAngle = 0;
            
//            if (point.x == lastPoint.x) { // 垂直线
//                if (point.y > lastPoint.y) { // 向下
//                    centerPoint.y = point.y - self.pathCornerRadius;
//                }else { // 向上
//                    centerPoint.y = point.y + self.pathCornerRadius;
//                }
//                pointA = CGPointMake(point.x, centerPoint.y);
//            }else if (point.y == lastPoint.y) { // 水平线
//                if (point.x > lastPoint.x) { // 向右
//                    centerPoint.x = point.x - self.pathCornerRadius;
//                }else {
//                    centerPoint.x = point.x + self.pathCornerRadius;
//                }
//                pointA = CGPointMake(centerPoint.x, point.y);
//            }
//            if (point.x == nextPoint.x) { // 垂直
//                if (point.y > nextPoint.y) {
//                    centerPoint.y = point.y - self.pathCornerRadius;
//                    startAngle = M_PI_2; // 两边方向起始角度是一致的，方向不同而已
//                }else {
//                    centerPoint.y = point.y + self.pathCornerRadius;
//                    startAngle = -M_PI_2;
//                }
//            }else if (point.y == nextPoint.y) {
//                if (point.x > nextPoint.x) {
//                    centerPoint.x = point.x - self.pathCornerRadius;
//                    startAngle = 0;
//                }else {
//                    centerPoint.x = point.x + self.pathCornerRadius;
//                    startAngle = M_PI;
//                }
//            }
            
            CGPoint pointA = [self calculatePointWithStartPoint:lastPoint endPoint:point length:self.pathCornerRadius];
            CGPoint pointB = [self calculatePointWithStartPoint:nextPoint endPoint:point length:self.pathCornerRadius];
            CGPoint centerPoint = CGPointMake(pointB.x - (point.x - pointA.x), pointB.y - (point.y - pointA.y));
            startAngle = [self calculateAngleWithPointA:pointA pointB:centerPoint];
            
            /**向量叉积 P×Q=（x1y2-x2y1)
             叉积时一个非常重要的性质是可以通过它的符号判断两向量相互之间的顺逆时针关系：
             若P×Q > 0 , 则P在Q的顺时针方向；
             若P×Q < 0 , 则P在Q的逆时针方向；
             若P×Q = 0 , P与Q共线，可能是同向也可能是反向；
             iOS中坐标下为y正，右为x正，顺逆相反
             */
            CGPoint lastToPoint = CGPointMake(point.x - lastPoint.x, point.y - lastPoint.y);
            CGPoint pointToNext = CGPointMake(nextPoint.x - point.x, nextPoint.y - point.y);
            // 叉积
            CGFloat result = lastToPoint.x*pointToNext.y - pointToNext.x*lastToPoint.y;
            // 判断旋转方向
            BOOL clockwise = (result < 0) ? NO : YES;
            CGFloat endAngle = clockwise ? (startAngle + M_PI_2) : (startAngle - M_PI_2);
            // 圆角
            [linePath addLineToPoint:pointA];
            [linePath addArcWithCenter:centerPoint radius:self.pathCornerRadius startAngle:startAngle endAngle:endAngle clockwise:clockwise];
        }
    }
    
    // 路线
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.path = linePath.CGPath;
    lineLayer.lineWidth = 2;
    lineLayer.lineCap = kCALineCapRound;
    lineLayer.lineJoin = kCALineJoinRound;
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    lineLayer.strokeColor = [UIColor fontColorLightMain].CGColor;
    [self.layer addSublayer:lineLayer];
    
    // 小圆点
    UIView *roundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
    roundView.backgroundColor = [UIColor clearColor];
    roundView.center = CGPointZero;
    [self addSubview:roundView];
    
    // 画外圆
    UIBezierPath *roundPath = [UIBezierPath bezierPath];
    [roundPath addArcWithCenter:CGPointMake(roundView.frame.size.width/2.0, roundView.frame.size.height/2.0) radius:CGRectGetWidth(roundView.frame)/2.0 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    CAShapeLayer *roundLayer = [CAShapeLayer layer];
    roundLayer.fillColor = [UIColor clearColor].CGColor;
    roundLayer.strokeColor = [UIColor colorWithHex:0x4682F4 alpha:0.3].CGColor;
    roundLayer.lineWidth = 2;
    roundLayer.path = [roundPath CGPath];
    [roundView.layer addSublayer:roundLayer];
    
    // 画内圆
    UIBezierPath *smallRoundPath = [UIBezierPath bezierPath];
    [smallRoundPath addArcWithCenter:CGPointMake(roundView.frame.size.width/2.0, roundView.frame.size.height/2.0) radius:4 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    CAShapeLayer *smallRoundLayer = [CAShapeLayer layer];
    smallRoundLayer.fillColor = [UIColor whiteColor].CGColor;
    smallRoundLayer.strokeColor = [UIColor colorWithHex:0x4682F4].CGColor;
    smallRoundLayer.lineWidth = 2;
    smallRoundLayer.path = [smallRoundPath CGPath];
    [roundView.layer addSublayer:smallRoundLayer];
    
    //圆圈位移动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //移动路径
    animation.path = lineLayer.path;
    animation.duration = 5;
    animation.autoreverses = NO;
    animation.repeatCount = CGFLOAT_MAX;
    animation.removedOnCompletion = NO;
    animation.calculationMode = kCAAnimationPaced;
    [roundView.layer addAnimation:animation forKey:@"position"];
}

- (CGPoint)calculatePointWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint length:(CGFloat)length{
    CGPoint endToStartPoint = CGPointMake(endPoint.x - startPoint.x, endPoint.y - startPoint.y);
    CGPoint resultPoint = startPoint;
    if (endToStartPoint.x > 0) {
        resultPoint = CGPointMake(endPoint.x - length, endPoint.y);
    }else if (endToStartPoint.x < 0) {
        resultPoint = CGPointMake(endPoint.x + length, endPoint.y);
    }else if (endToStartPoint.y > 0) {
        resultPoint = CGPointMake(endPoint.x, endPoint.y - length);
    }else {
        resultPoint = CGPointMake(endPoint.x, endPoint.y + length);
    }
    return resultPoint;
}

/**
 * 计算角度 (和X轴正方向的夹角)
 * @param pointA 线段终点
 * @param pointB 线段起始点
 */
- (CGFloat)calculateAngleWithPointA:(CGPoint)pointA pointB:(CGPoint)pointB {
    //向量点积 a·b=|a||b|cosθ， θ = arccos(a·b)/(|a||b|)， a·b = x1 × x2 + y1 × y2
    CGPoint firstPoint = CGPointMake(pointA.x - pointB.x, pointA.y - pointB.y);
    // 辅助线
    CGPoint helpPoint = CGPointMake(10, 0);
    CGFloat aLength = sqrt(pow(firstPoint.x, 2.0) + pow(firstPoint.y, 2.0));
    CGFloat bLength = sqrt(pow(helpPoint.x, 2.0) + pow(helpPoint.y, 2.0));
    CGFloat ab = (firstPoint.x*helpPoint.x + firstPoint.y*helpPoint.y);
    CGFloat cosX = ab/(aLength*bLength);
    CGFloat angle = acos(cosX);
    /**向量叉积 P×Q=（x1y2-x2y1)
     叉积时一个非常重要的性质是可以通过它的符号判断两向量相互之间的顺逆时针关系：
     若P×Q > 0 , 则P在Q的顺时针方向；
     若P×Q < 0 , 则P在Q的逆时针方向；
     若P×Q = 0 , P与Q共线，可能是同向也可能是反向；
     iOS中坐标下为y正，右为x正，顺逆相反
     */
    CGFloat abResult = firstPoint.x*helpPoint.y - helpPoint.x*firstPoint.y;
    if (abResult > 0){
        angle = 2*M_PI - angle;
    }
    return angle;
}
@end
