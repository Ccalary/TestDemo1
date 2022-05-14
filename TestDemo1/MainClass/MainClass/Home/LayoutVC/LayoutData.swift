//
//  LayoutData.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/4/25.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation

class LayoutData {
    
    /// 数据的最大最小值
    private(set) var xMax = -Double.greatestFiniteMagnitude
    private(set) var xMin = Double.greatestFiniteMagnitude
    private(set) var yMax = -Double.greatestFiniteMagnitude
    private(set) var yMin = Double.greatestFiniteMagnitude
    
    var _dataSets = [LayoutDataSet]()
    
    public init(dataSets: [LayoutDataSet]) {
        self.dataSets = dataSets
    }
    
    var dataSets: [LayoutDataSet] {
        get{
            return _dataSets
        }
        set {
            _dataSets = newValue
            notifyDataChanged()
        }
    }
    
    /// 通知数据更改
    func notifyDataChanged() {
        
        calculateMinMax()
    }
    
    /// 计算最大最小
    func calculateMinMax() {
        
        dataSets.forEach { dataSet in
            var rect = dataSet.rect
            // 有旋转操作
            if (dataSet.angle != 0) {
                let x = rect.midX
                let y = rect.midY
                let transform = CGAffineTransform(translationX: x, y: y)
                    .rotated(by: dataSet.angle/180.0*Double.pi)
                    .translatedBy(x: -x, y: -y)
                rect = rect.applying(transform)
            }
            
            xMax = max(xMax, rect.maxX)
            xMin = min(xMin, rect.minX)
            yMax = max(yMax, rect.maxY)
            yMin = min(yMin, rect.minY)
        }
    }
}
