//
//  CustomLineChartView.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/3/29.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation

/// 注意⚠️：leftAxisTransformer 此属性更改源码后获取
open class CustomLineChartView: LineChartView {
    func setupCustomRenderer() {
        xAxisRenderer = CustomLineXAxisRenderer(viewPortHandler: viewPortHandler, axis: xAxis, transformer: leftAxisTransformer)
        renderer = CustomLineChartRenderer(dataProvider: self, animator: chartAnimator, viewPortHandler: viewPortHandler)
    }
}

extension Double {
    /// 根据最小粒度算出拆分数据
    func customLineRoundedToNextSignificant(_ granularity: Double = 60.0) -> Double {
        guard !isInfinite, !isNaN, self != 0 else {
            return self
        }
        // 四舍五入
        let value = lround(self/granularity)
        return Double(granularity*Double(value))
    }
    
    /// y轴数据处理
    func yRoundedToNextSignificant() -> Double {
        guard !isInfinite, !isNaN, self != 0 else {
            return self
        }
        // 给定一个数字，求它的数量级最接近的10^n的倍数。
        let value = ceil(log10(self < 0 ? -self : self))
        let number = 1 - Int(value)
        let magnitude = pow(10.0, Double(number))
        // 做了up向上取整操作
        let shifted = (self * magnitude).rounded(.awayFromZero)
        return shifted / magnitude
    }
}