//
//  TimeAxisValueFormatter.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/3/28.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation
import Charts
open class TimeAxisValueFormatter: NSObject, AxisValueFormatter {
    public override init() {
        super.init()
    }
    
    // 按照时间展示
    open func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value.rounded())
        let result = self.formatDate(second: index)
        return result
    }
    
    // second 秒数
    func formatDate(second:Int) ->String {
        let formatter = DateComponentsFormatter()
        // . dropMiddle为  0d 00h 00m 格式 (需要其它格式可以自己点进去看看)
        formatter.zeroFormattingBehavior = .pad
        // 此处事例只写了 日 时 分；需要秒的可以在后面加上（参数： | NSCalendar.Unit.second.rawValue ）
        formatter.allowedUnits = NSCalendar.Unit(rawValue: NSCalendar.Unit.hour.rawValue | NSCalendar.Unit.minute.rawValue)
        formatter.unitsStyle = DateComponentsFormatter.UnitsStyle.positional
        // 结果默认格式为 00:00
        let resultStr = formatter.string(from: TimeInterval(second)) ?? ""
        return resultStr
    }
}


