//
//  LoggerData.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/4/12.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation

open class FlowEntry {
  
    // 图标名称
    var iconName: String
    // 当前设备名称
    var name = ""
    // 设备数据
    var value = ""
    // 值的单位
    var unit = ""
    // 副值，类似于电池80%
    var subValue = ""
    
    init(iconName: String) {
        self.iconName = iconName
    }
    
    convenience init(iconName: String, name: String, value: String = "", unit: String = "", subValue: String = "") {
        self.init(iconName: iconName)
        self.name = name
        self.value = value
        self.unit = unit
        self.subValue = subValue
    }
}
