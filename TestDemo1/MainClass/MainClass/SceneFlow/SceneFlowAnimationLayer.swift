//
//  SceneFlowAnimationLayer.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/12/8.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation

@objc public class SceneFlowAnimationLayer: CALayer {
    
    public var animationPath: CGPath? {
        didSet {
            refreshLayer()
        }
    }
    
    /* 动画时长 */
    public var animationDuration = 3.0 {
        didSet {
            self.groupAnimation.duration = animationDuration
            self.arrowLayer.add(self.groupAnimation, forKey: "groupAnimation")
        }
    }
    
    /* 箭头大小 */
    public var arrowSize = CGSize(width: 8, height: 12) {
        didSet {
            refreshLayer()
        }
    }
    
    /* 箭头的颜色 */
    public var arrowColor = "#07D66A" {
        didSet {
            arrowLayer.fillColor = UIColor(arrowColor).cgColor
            refreshLayer()
        }
    }
    
    public override init() {
        super.init()
    }
    
    deinit {
        self.arrowLayer.removeAllAnimations()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func refreshLayer() {
        self.removePathAnimation()
        self.addPathAnimation()
    }
    
    /* 移除动画 */
    public func removePathAnimation() {
        self.arrowLayer.removeAllAnimations()
        self.arrowLayer.removeFromSuperlayer()
    }
    
    /* 增加动画 */
    public func addPathAnimation() {
        // 绘制
        let arrowPath = calculateArrowPath(arrowSize: arrowSize)
        self.arrowLayer.path = arrowPath.cgPath
        self.addSublayer(arrowLayer)
        
        // 移动路径
        self.positionAnimation.path = animationPath
        self.groupAnimation.animations = [self.positionAnimation, self.opacityAnimation]
        self.arrowLayer.add(self.groupAnimation, forKey: "groupAnimation")
    }
    
    /* 获取箭头路径 */
    public func calculateArrowPath(arrowSize: CGSize) -> UIBezierPath {
        
        let arrowPath = UIBezierPath()
        let arrowTopPoint = CGPoint(x: arrowSize.width/2.0, y: 0)
        let leftArrowPoint = CGPoint(x: -arrowSize.width/2.0, y: -arrowSize.height/2.0)
        let rightArrowPoint = CGPoint(x: -arrowSize.width/2.0, y: arrowSize.height/2.0)

        arrowPath.move(to: arrowTopPoint)
        arrowPath.addLine(to: leftArrowPoint)
        arrowPath.addLine(to: rightArrowPoint)
        arrowPath.close()
        return arrowPath
    }
    
    /* 箭头 */
    public lazy var arrowLayer: CAShapeLayer = {
        let roundLayer = CAShapeLayer()
        roundLayer.fillColor = UIColor(arrowColor).cgColor
        return roundLayer
    }()
    
    /* 动画 */
    private lazy var positionAnimation: CAKeyframeAnimation = {
        //圆圈位移动画
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.autoreverses = false
        animation.repeatCount = Float.infinity
        animation.isRemovedOnCompletion = false
        animation.calculationMode = CAAnimationCalculationMode.paced
        animation.rotationMode = .rotateAuto
        return animation
    }()
    
    /* 透明度动画 */
    private lazy var opacityAnimation: CAKeyframeAnimation = {
        let animation = CAKeyframeAnimation(keyPath: "opacity")
        animation.values = [0.1, 1, 1, 0.1]
        animation.keyTimes = [NSNumber(value: 0.00), NSNumber(value: 0.1),NSNumber(value: 0.9), NSNumber(value: 1)]
        return animation
    }()
    
    /* 动画组 */
    private lazy var groupAnimation: CAAnimationGroup = {
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = self.animationDuration
        animationGroup.autoreverses = false;
        animationGroup.repeatCount = Float.infinity
        animationGroup.isRemovedOnCompletion = false
        return animationGroup
    }()
}
