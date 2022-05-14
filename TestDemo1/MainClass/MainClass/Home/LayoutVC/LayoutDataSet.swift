//
//  LayoutDateSets.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/4/25.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation

/**
    一个组件组数据
 */
class LayoutDataSet {
    /// 安装方向
    enum Direction: String {
        case horizontal
        case vertical
    }
    
    public init() {
        entries = []
    }
    
    public convenience init(name: String) {
        self.init()
        self.name = name
    }
    
    public convenience init(entries: [LayoutDataEntry], name: String) {
        self.init(name: name)
        self.entries = entries
    }
    
    private(set) var entries: [LayoutDataEntry]
    /// 名称
    var name: String? = "device"
    /// x轴起始点
    var xaxisIndex: Double = 0.0
    /// y轴起始点
    var yaxisIndex: Double = 0.0
    /// 行数
    var rowNum: Int = 0
    /// 列数
    var columnNum: Int = 0
    /// 旋转角度
    var angle: Double = 0.0
    /// 安装方向
    var direction: Direction = .horizontal
    
    /// 边界颜色
    var borderColor = UIColor("#787878")
    /// 边界颜色
    var borderSelectedColor = UIColor("#0B4CE9")
    /// 边界宽度
    var borderWidth = 2.0
    /// 内部边距
    var edgeInsets = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    /// 圆角
    var cornerRadius = 5.0
    
    /// 组件宽度
    var itemWidth = 40.0
    /// 组件高度
    var itemHeight = 80.0
    /// 组件间距
    var margin = 10.0
    /// 组件边界线颜色
    var itemBorderColor = UIColor("#787878")
    /// 组件边界宽度
    var itemBorderWidth = 1.0
    /// 组件填充颜色
    var itemFillColor = UIColor("#787878")
    
    /// 方位高度
    var itemDirectionHeight = 15.0
    /// 方位颜色
    var itemDirectionFillColor = UIColor("#333333")
    
    /// 网格线颜色
    var itemGridLineColor = UIColor("#cccccc")
    /// 网格线宽度
    var itemGridLineWidth = 1.0
    /// 网格线总宽
    var itemGridWidth: Double {
        return itemWidth/2.0
    }
    /// 网格线总高
    var itemGridHight: Double {
        return (itemHeight - itemDirectionHeight)/2.0
    }
    
    /// 文字颜色
    var itemTextColor = UIColor.white
    /// 文字大小
    var itemTextFontSize = 10.0
    /// 文字边界间隙
    var itemTextMargin = 3.0

    /// frame
    var rect: CGRect {
        get {
            let width = edgeInsets.left + edgeInsets.right + Double(rowNum)*itemWidth + Double(rowNum-1)*margin
            let height = edgeInsets.top + edgeInsets.bottom + Double(columnNum)*itemHeight + Double(columnNum-1)*margin
            let rect = CGRect(x: xaxisIndex, y: yaxisIndex, width: width, height: height)
            return rect
        }
    }
}
