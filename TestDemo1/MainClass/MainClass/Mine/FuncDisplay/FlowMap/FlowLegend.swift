//
//  Legend.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/4/13.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import UIKit

class FlowLegend {
    /// 图标位置
    public enum LegendPosition: Int {
        case topLeft = 0
        case topCenter
        case topRight
        case centerLeft
        case center
        case centerRight
        case bottomLeft
        case bottomCenter
        case bottomRight
    }
    
    /// 文本位置
    public enum TextPosition: Int {
        case bottom // default
        case top
    }
    
    /// 流动方向
    public enum FlowDirection: Int {
        /// 四周向中心点移动
        case forward
        /// 中心点向四周
        case reverse
    }
    
    /// 路径类型
    public enum FlowPathType: Int {
        case normal // 常规绘制，9点都在的时候，4个角4个点绘制，转弯两次
        case simple // 4个角3点绘制，转弯一次
    }
    
    var entry: FlowEntry
    /// 图标位置
    var position: LegendPosition
    /// 文本位置
    var textPosition: TextPosition
    /// 流动方向
    var flowDirection: FlowDirection
    /// 流动方向
    var flowEnable: Bool = true
    /// 流动路径类型
    var flowPathType: FlowPathType = .normal
    /// 中心点
    var centerPoint: CGPoint = CGPoint.zero
    /// 图标大小
    var iconSize: CGFloat = 48.0
    
    init(entry: FlowEntry, positon: LegendPosition, textPosition: TextPosition = .bottom, flowDirection: FlowDirection = .forward, flowEnable: Bool = true, flowPathType: FlowPathType = .normal) {
        self.entry = entry
        self.position = positon
        self.textPosition = textPosition
        self.flowDirection = flowDirection
        self.flowEnable = flowEnable
        self.flowPathType = flowPathType
    }
}
