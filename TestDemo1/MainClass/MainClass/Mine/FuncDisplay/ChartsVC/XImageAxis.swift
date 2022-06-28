//
//  XImageAxis.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/6/22.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation

open class XImageAxis {
    // 图标展示位置，例如天气图标
    public enum IconPosition: Int {
        case none
        case bottom
    }
    // 图标位置
    open var iconPosition = IconPosition.none
    // 图标大小
    open var iconSize = CGSize.zero
    // 坐标数据data为图片名称
    open var dataEntries = [ChartDataEntry]()
}

