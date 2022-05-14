//
//  LayoutViewPortHandler.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/4/24.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation
import UIKit

class LayoutViewPortHandler {
    /// 布局
    private(set) var contentRect = CGRect()
    /// 矩阵变换
    private(set) var touchMatrix = CGAffineTransform.identity
    /// 长按点位
    private(set) var longPressPoint: CGPoint?
    /// 边界间距
    let resetEdgeInsets = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
    
    /// 初始化
    init(width: CGFloat, height: CGFloat) {
        setLayoutDimens(width: width, height: height)
    }
    
    func setLayoutDimens(width: CGFloat, height: CGFloat) {
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
    
    /// 复位时的宽
    var resetWidth: CGFloat {
        return contentWidth - resetEdgeInsets.left - resetEdgeInsets.right
    }
    
    /// 复位时的高
    var resetHeight: CGFloat {
        return contentHeight - resetEdgeInsets.top - resetEdgeInsets.bottom
    }
    
    /// 更新matrix
    func refresh(newMatrix: CGAffineTransform, layout: LayoutView) -> CGAffineTransform {
        touchMatrix = newMatrix
        layout.setNeedsDisplay()
        return touchMatrix
    }
    
    /// 更新长按点位
    func updateLongPressPoint(newPoint: CGPoint?, layout: LayoutView) {
        longPressPoint = newPoint
        layout.setNeedsDisplay()
    }
}
