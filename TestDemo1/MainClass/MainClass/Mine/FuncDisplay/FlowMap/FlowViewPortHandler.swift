//
//  FlowViewPortHandler.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/4/14.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation

class FlowViewPortHandler {
    /// 布局
    open private(set) var contentRect = CGRect()
    
    // 中间图标大小
    let contentCenterIconSize = CGSize(width: 50.0, height: 62.0)
    // 绘制流动线段时距离中心图片的边距
    let centerIconMargin = 5.0
    // 绘制流动线段时线段间距
    let lineMargin = 10.0
    
    // 上下左右偏移量，对中心图片而言
    let offsetLeft = 25.0
    let offsetTop = 50.0
    let offsetRight = 25.0
    let offsetBottom = 50.0
    
    /// 初始化
    init(width: CGFloat, height: CGFloat) {
        setFlowMapDimens(width: width, height: height)
    }
    
    func setFlowMapDimens(width: CGFloat, height: CGFloat) {
        contentRect.size.width = width
        contentRect.size.height = height
    }
    
    var contentWidth: CGFloat {
        return contentRect.size.width
    }
    
    var contentHeight: CGFloat {
        return contentRect.size.height
    }
    
    var contentCenter: CGPoint {
        return CGPoint(x: contentRect.origin.x + contentRect.size.width / 2.0, y: contentRect.origin.y + contentRect.size.height / 2.0)
    }
    
    // 中间图标四周位置
    var centerIconLeft: CGFloat {
        return contentCenter.x - contentCenterIconSize.width/2.0
    }
    
    var centerIconTop: CGFloat {
        return contentCenter.y - contentCenterIconSize.height/2.0
    }
    
    var centerIconRight: CGFloat {
        return contentCenter.x + contentCenterIconSize.width/2.0
    }
    
    var centerIconBottom: CGFloat {
        return contentCenter.y + contentCenterIconSize.height/2.0
    }
}
