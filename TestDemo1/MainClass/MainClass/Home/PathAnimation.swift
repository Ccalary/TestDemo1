//
//  PathAnimation.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/3/18.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation
import UIKit

@objc public class PathAnimation: UIView {
    /* 动画时长 */
    public var animationDuration = 5.0 {
        didSet {
            self.positionAnimation.duration = animationDuration
            self.roundLayer.add(self.positionAnimation, forKey: "position")
        }
    }
    /* 路线的宽度 */
    public var lineWidth = 2.0 {
        didSet {
            self.lineLayer.lineWidth = lineWidth
        }
    }
    /* 路线的颜色 */
    public var lineStokeColor = UIColor.init(hex: 0xD8E1F2) {
        didSet {
            self.lineLayer.strokeColor = lineStokeColor.cgColor
        }
    }
    /* 路径的转角半径，默认是5.0 */
    private var pathCornerRadius = 5.0
    /* 路线点位数组 */
    private var pointArray = [CGPoint]()
    /* 有移动的原点 */
    private var isNeedMove = true
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @objc convenience init(frame: CGRect, pointArray: Array<CGPoint>, pathCornerRadius: Double = 5.0, isNeedMove:Bool = true) {
        self.init(frame: frame)
        self.pathCornerRadius = pathCornerRadius
        self.pointArray = pointArray
        self.isNeedMove = isNeedMove
        self.initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        self.backgroundColor = UIColor.white
        self.initAnimation(self.pointArray)
    }
    
    func initAnimation(_ pointArray: Array<CGPoint>) {
        let linePath = UIBezierPath()
        for (i, point) in pointArray.enumerated() {
            if (i == 0) { // 开始点
                linePath.move(to: point)
            }else if (i == pointArray.count - 1) { // 终止点
                linePath.addLine(to: point)
            }else {
                let lastPoint = pointArray[i-1]
                let nextPoint = pointArray[i+1]
                // 计算point点旁边两个点，得出圆心
                let pointA = calculateResultPoint(startPoint: lastPoint, endPoint: point, distance: self.pathCornerRadius)
                let pointB = calculateResultPoint(startPoint: nextPoint, endPoint: point, distance: self.pathCornerRadius)
                let centerPoint = CGPoint(x:pointB.x - (point.x - pointA.x), y:pointB.y - (point.y - pointA.y))
                let startAngle = calculateLineAngle(startPoint: centerPoint, endPoint: pointA)
                
                //向量叉积 P×Q=（x1y2-x2y1), 判断旋转方向
                let lastToPoint = CGPoint(x: point.x - lastPoint.x, y: point.y - lastPoint.y)
                let nextToPoint = CGPoint(x: nextPoint.x - point.x, y: nextPoint.y - point.y)
                let result = lastToPoint.x*nextToPoint.y - nextToPoint.x*lastToPoint.y
                let clockwise = (result < 0) ? false : true
                let endAngle = clockwise ? (startAngle + Double.pi/2.0) : (startAngle - Double.pi/2.0)
                linePath.addLine(to: pointA)
                // 圆角
                linePath.addArc(withCenter: centerPoint, radius: self.pathCornerRadius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
            }
        }
        
        self.lineLayer.path = linePath.cgPath
        self.layer.addSublayer(lineLayer)
        if (isNeedMove) {
            self.layer.addSublayer(roundLayer)
            self.roundLayer.addSublayer(smallRoundLayer)
            //移动路径
            self.positionAnimation.path = lineLayer.path
            self.positionAnimation.duration = 5.0
            roundLayer.add(self.positionAnimation, forKey: "position")
        }
    }
    
    /* 路径layer */
    private lazy var lineLayer: CAShapeLayer = {
        let lineLayer = CAShapeLayer()
        lineLayer.lineWidth = self.lineWidth
        lineLayer.lineCap = .round
        lineLayer.lineJoin = .round
        lineLayer.fillColor = UIColor.clear.cgColor
        lineLayer.strokeColor = lineStokeColor.cgColor
        return lineLayer
    }()
    
    /* 画外圆 */
    public lazy var roundLayer: CAShapeLayer = {
        let roundPath = UIBezierPath()
        roundPath.addArc(withCenter: CGPoint.zero, radius: 6.0, startAngle: 0, endAngle: Double.pi*2, clockwise: true)
        let roundLayer = CAShapeLayer()
        roundLayer.fillColor = UIColor.clear.cgColor;
        roundLayer.strokeColor = UIColor.init(hex: 0x4682F4, alpha: 0.3).cgColor
        roundLayer.lineWidth = 2
        roundLayer.path = roundPath.cgPath
        return roundLayer
    }()
    /* 画内圆 */
    public lazy var smallRoundLayer: CAShapeLayer = {
        let smallRoundPath = UIBezierPath()
        smallRoundPath.addArc(withCenter: CGPoint.zero, radius: 4.0, startAngle: 0, endAngle: Double.pi*2, clockwise: true)
        let smallRoundLayer = CAShapeLayer()
        smallRoundLayer.fillColor = UIColor.white.cgColor
        smallRoundLayer.strokeColor = UIColor.init(hex: 0x4682F4).cgColor
        smallRoundLayer.lineWidth = 2
        smallRoundLayer.path = smallRoundPath.cgPath
        return smallRoundLayer
    }()
    /* 动画 */
    private lazy var positionAnimation: CAKeyframeAnimation = {
        //圆圈位移动画
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.duration = 5;
        animation.autoreverses = false;
        animation.repeatCount = Float.infinity;
        animation.isRemovedOnCompletion = false;
        animation.calculationMode = .paced;
        // 动画效果，渐入渐出
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        return animation
    }()
}

extension PathAnimation {
    /* 根据两点计算终点附近的点，用于获取圆心 */
    func calculateResultPoint(startPoint: CGPoint, endPoint: CGPoint, distance: CGFloat) -> CGPoint {
        let endToStartPoint = CGPoint(x: endPoint.x - startPoint.x, y: endPoint.y - startPoint.y);
        var resultPoint = endPoint;
        if (endToStartPoint.x > 0) {
            resultPoint = CGPoint(x: endPoint.x - distance,y: endPoint.y);
        }else if (endToStartPoint.x < 0) {
            resultPoint = CGPoint(x: endPoint.x + distance,y: endPoint.y);
        }else if (endToStartPoint.y > 0) {
            resultPoint = CGPoint(x: endPoint.x,y: endPoint.y - distance);
        }else {
            resultPoint = CGPoint(x: endPoint.x,y: endPoint.y + distance);
        }
        return resultPoint;
    }
    
    /**
     * 计算角度 (和X轴正方向的夹角)
     * @param pointA 线段终点
     * @param pointB 线段起始点
     */
    func calculateLineAngle(startPoint: CGPoint, endPoint: CGPoint) -> Double {
        //向量点积 a·b=|a||b|cosθ， θ = arccos(a·b)/(|a||b|)， a·b = x1 × x2 + y1 × y2
        let firstPoint = CGPoint(x: endPoint.x - startPoint.x, y:endPoint.y - startPoint.y);
        // 辅助线
        let helpPoint = CGPoint(x:10, y:0);
        let aLength = sqrt(pow(firstPoint.x, 2.0) + pow(firstPoint.y, 2.0));
        let bLength = sqrt(pow(helpPoint.x, 2.0) + pow(helpPoint.y, 2.0));
        let ab = (firstPoint.x*helpPoint.x + firstPoint.y*helpPoint.y);
        let cosX = ab/(aLength*bLength);
        var angle = acos(cosX);
        /*向量叉积 P×Q=（x1y2-x2y1)
         叉积时一个非常重要的性质是可以通过它的符号判断两向量相互之间的顺逆时针关系：
         若P×Q > 0 , 则P在Q的顺时针方向；
         若P×Q < 0 , 则P在Q的逆时针方向；
         若P×Q = 0 , P与Q共线，可能是同向也可能是反向；
         iOS中坐标下为y正，右为x正，顺逆相反
         */
        let abResult = firstPoint.x*helpPoint.y - helpPoint.x*firstPoint.y;
        if (abResult > 0){
            angle = 2*Double.pi - angle;
        }
        return angle;
    }
}
