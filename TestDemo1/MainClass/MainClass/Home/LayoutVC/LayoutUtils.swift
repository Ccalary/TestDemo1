//
//  LayoutUtils.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/4/29.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation

class LayoutUtils {
    /// rect旋转操作
    static func rectRotated(angle: Double, anchorPoint: CGPoint) -> CGAffineTransform {
        let matrix = CGAffineTransform(translationX: anchorPoint.x, y: anchorPoint.y)
                    .rotated(by: angle/180.0*Double.pi)
                    .translatedBy(x: -anchorPoint.x, y: -anchorPoint.y)
        return matrix
    }
}

extension CGPoint {
    /// 计算一个点是否在一个多边形内
    func isInPolygon(_ polygon: [CGPoint]) -> Bool {
            if polygon.count <= 1 {
                return false //or if first point = test -> return true
            }

            let path = UIBezierPath()
            let firstPoint = polygon.first!
            path.move(to: firstPoint)
            for index in 1...polygon.count-1 {
                path.addLine(to: polygon[index])
            }
            path.close()
            return path.contains(self)
        }
}
