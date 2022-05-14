//
//  YAxisValueFormatter.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/4/29.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation

open class YDecimalsAxisValueFormatter: NSObject, AxisValueFormatter {
    // 位数
    var decimals = 0
    
    public override init() {
        super.init()
    }
    
    convenience init(decimals: Int) {
        self.init()
        self.decimals = decimals
    }
    
    // 根据小数点位展示
    open func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let result = String(format: "%.\(decimals)f", value)
        return result
    }
}
