//
//  SceneFlowPathLayer.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/12/7.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

@objc public class SceneFlowPathLayer: CALayer {
    /* 路线的宽度 */
    public var lineWidth = 1.5 {
        didSet {
            self.lineLayer.lineWidth = lineWidth
            refreshLayer()
        }
    }
    /* 路线的颜色 */
    public var lineStokeColor = UIColor("#07D66A") {
        didSet {
            self.lineLayer.strokeColor = lineStokeColor.cgColor
            refreshLayer()
        }
    }
    
    /* 圆圈的颜色 */
    public var dotColor = "#07D66A" {
        didSet {
            roundLayer.fillColor = UIColor(dotColor).cgColor
            refreshLayer()
        }
    }
    /* 圆圈（小）的半径 */
    public var dotRadius = 3.0 {
        didSet {
            refreshLayer()
        }
    }
    
    /* 路径的转角半径，默认是5.0 */
    public var pathCornerRadius = 5.0 {
        didSet {
            refreshLayer()
        }
    }
    /* 路线点位数组 */
    public var pointArray = [CGPoint]()

    public var linePath: CGPath? {
        return self.lineLayer.path
    }
    
    public override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(pointArray: Array<CGPoint>,
                     pathCornerRadius: Double = 5.0
    ) {
        self.init()
        self.pathCornerRadius = pathCornerRadius
        self.pointArray = pointArray
        self.initPathLayer()
    }
    
    // 重新构建界面
    func refreshLayer() {
        self.lineLayer.removeFromSuperlayer()
        self.roundLayer.removeFromSuperlayer()
        self.initPathLayer()
    }
    
    private func initPathLayer() {
        let linePath = self.getLinePath(self.pointArray)
        self.lineLayer.path = linePath.cgPath
        self.addSublayer(lineLayer)
        
        let roundPath = self.getRoundDotPath(self.pointArray)
        self.roundLayer.path = roundPath.cgPath
        self.addSublayer(roundLayer)
    }
    
    /// 路径
    private func getLinePath(_ pointArray: Array<CGPoint>) -> UIBezierPath {
        let cornerRadius = min(self.pathCornerRadius, getMinLineCornerRadius(pointArray))
        let linePath = UIBezierPath()
        for (i, point) in pointArray.enumerated() {
            if (i == 0) { // 开始点
                linePath.move(to: point)
            }else if (i == pointArray.count - 1) { // 终止点
                linePath.addLine(to: point)
            }else {
                let lastPoint = pointArray[i-1]
                let nextPoint = pointArray[i+1]
                // 计算point点旁边两个点，得出圆心,max 避免cornerRadius为0的情况
                let pointA = calculateResultPoint(startPoint: lastPoint, endPoint: point, distance: max(cornerRadius, 0.01))
                let pointB = calculateResultPoint(startPoint: nextPoint, endPoint: point, distance: max(cornerRadius, 0.01))
                let centerPoint = CGPoint(x:pointB.x - (point.x - pointA.x), y:pointB.y - (point.y - pointA.y))
                
                // 向量叉积 P×Q=（x1y2-x2y1), 判断旋转方向
                let lastToPoint = CGPoint(x: point.x - lastPoint.x, y: point.y - lastPoint.y)
                let nextToPoint = CGPoint(x: nextPoint.x - point.x, y: nextPoint.y - point.y)
                let result = lastToPoint.x * nextToPoint.y - nextToPoint.x * lastToPoint.y
                let clockwise = (result < 0) ? false : true
                
                let startAngle = calculateLineAngle(startPoint: centerPoint, endPoint: pointA)
                let endAngle = clockwise ? (startAngle + Double.pi/2.0) : (startAngle - Double.pi/2.0)
                linePath.addLine(to: pointA)
                // 圆角
                linePath.addArc(withCenter: centerPoint,
                                radius: cornerRadius,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: clockwise)
            }
        }
        return linePath
    }
    
    /// 端点圆点
    private func getRoundDotPath(_ pointArray: Array<CGPoint>) -> UIBezierPath {
        guard pointArray.count >= 2 else {
            return UIBezierPath()
        }
        var roundPath = UIBezierPath()
        roundPath.addArc(withCenter: pointArray.first!,
                         radius: dotRadius,
                         startAngle: 0,
                         endAngle: Double.pi * 2,
                         clockwise: true)
        roundPath.move(to: pointArray.last!)
        roundPath.addArc(withCenter: pointArray.last!,
                         radius: dotRadius,
                         startAngle: 0,
                         endAngle: Double.pi * 2,
                         clockwise: true)
        return roundPath
    }
    
    /// 获取最小支持的圆角
    private func getMinLineCornerRadius(_ pointArray: [CGPoint]) -> CGFloat {
        var lengthArray = [CGFloat]()
        var minLength: Double = 10000.0
        for i in 0..<pointArray.count {
            if (i < pointArray.count - 1) {
                let point = pointArray[i]
                let nextPoint = pointArray[i+1]
                let length = sqrt(pow(point.x - nextPoint.x, 2.0) + pow(point.y - nextPoint.y, 2.0))
                lengthArray.append(length)
                minLength = min(length, minLength)
            }
        }
        if lengthArray.count == 3 { // normal模式，中间线取一半对比
            minLength = min(minLength, lengthArray[1]/2.0)
        }
        return minLength
    }
    
    // MARK: UI
    /* 路径layer */
    private lazy var lineLayer: CAShapeLayer = {
        let lineLayer = CAShapeLayer()
        lineLayer.lineWidth = self.lineWidth
        lineLayer.fillColor = UIColor.clear.cgColor
        lineLayer.strokeColor = lineStokeColor.cgColor
        lineLayer.lineCap = CAShapeLayerLineCap.round
        lineLayer.lineJoin = CAShapeLayerLineJoin.round
        return lineLayer
    }()
    
    /* 画圆 */
    public lazy var roundLayer: CAShapeLayer = {
        let roundLayer = CAShapeLayer()
        roundLayer.fillColor = UIColor(dotColor).cgColor;
        return roundLayer
    }()
}

extension SceneFlowPathLayer {
    /* 根据两点计算终点附近的点，用于获取圆心 */
    func calculateResultPoint(startPoint: CGPoint,
                              endPoint: CGPoint,
                              distance: CGFloat) -> CGPoint {
        let endToStartPoint = CGPoint(x: endPoint.x - startPoint.x, y: endPoint.y - startPoint.y);
        var resultPoint = endPoint
        if (endToStartPoint.x > 0) {
            resultPoint = CGPoint(x: endPoint.x - distance,y: endPoint.y)
        } else if (endToStartPoint.x < 0) {
            resultPoint = CGPoint(x: endPoint.x + distance,y: endPoint.y)
        } else if (endToStartPoint.y > 0) {
            resultPoint = CGPoint(x: endPoint.x,y: endPoint.y - distance)
        } else {
            resultPoint = CGPoint(x: endPoint.x,y: endPoint.y + distance)
        }
        return resultPoint;
    }
    
    /**
     * 计算角度 (和X轴正方向的夹角)
     *  - Parameters:
     *   - pointA : 线段终点
     *   - pointB : 线段起始点
     *  - Returns: 角度
     */
    func calculateLineAngle(startPoint: CGPoint, endPoint: CGPoint) -> Double {
        //向量点积 a·b=|a||b|cosθ， θ = arccos(a·b)/(|a||b|)， a·b = x1 × x2 + y1 × y2
        let firstPoint = CGPoint(x: endPoint.x - startPoint.x, y:endPoint.y - startPoint.y)
        // 辅助线
        let helpPoint = CGPoint(x:10, y:0)
        let aLength = sqrt(pow(firstPoint.x, 2.0) + pow(firstPoint.y, 2.0))
        let bLength = sqrt(pow(helpPoint.x, 2.0) + pow(helpPoint.y, 2.0))
        let ab = (firstPoint.x*helpPoint.x + firstPoint.y*helpPoint.y)
        let cosX = ab/(aLength*bLength)
        var angle = acos(cosX)
        /*向量叉积 P×Q=（x1y2-x2y1)
         叉积时一个非常重要的性质是可以通过它的符号判断两向量相互之间的顺逆时针关系：
         若P×Q > 0 , 则P在Q的顺时针方向；
         若P×Q < 0 , 则P在Q的逆时针方向；
         若P×Q = 0 , P与Q共线，可能是同向也可能是反向；
         iOS中坐标下为y正，右为x正，顺逆相反
         */
        let abResult = firstPoint.x * helpPoint.y - helpPoint.x * firstPoint.y
        if (abResult > 0){
            angle = 2*Double.pi - angle
        }
        return angle
    }
}
