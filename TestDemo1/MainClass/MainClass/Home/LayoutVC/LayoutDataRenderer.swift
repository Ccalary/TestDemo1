//
//  LayoutRender.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/4/26.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation
import CoreGraphics

class LayoutDataRenderer {
    
    let viewPortHandler: LayoutViewPortHandler
    var data: LayoutData?
    
    public init(data: LayoutData?, viewPortHandler: LayoutViewPortHandler) {
        self.data = data
        self.viewPortHandler = viewPortHandler
    }
    
    func drawData(context: CGContext) {
        guard let data = self.data else {
            return
        }
        context.saveGState()
        // 外框
        let drawRect = CGRect(x: data.xMin, y: data.yMin, width: data.xMax - data.xMin, height: data.yMax - data.yMin)
        let path = CGMutablePath()
        path.move(to: CGPoint(x: data.xMin, y: data.yMin))
        path.addRect(drawRect, transform: viewPortHandler.touchMatrix)
        context.addPath(path)
        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineWidth(1)
        context.strokePath()
        
        context.restoreGState()
        
        /// 组绘制
        data.dataSets.forEach { dataSet in
            drawGroup(context: context, dataSet: dataSet)
        }
    }
    
    func drawGroup(context: CGContext, dataSet: LayoutDataSet) {
        guard dataSet.rowNum > 0, dataSet.columnNum > 0 else {
            return
        }
        context.saveGState()
        defer {
            context.restoreGState()
        }
        
        let matrix = LayoutUtils.rectRotated(angle: dataSet.angle, anchorPoint: CGPoint(x: dataSet.rect.midX, y: dataSet.rect.midY)).concatenating(viewPortHandler.touchMatrix)
        /// 对整个画布做矩阵变换
        context.concatenate(matrix)
        
        let path = CGMutablePath()
        path.move(to: CGPoint(x: dataSet.rect.minX, y: dataSet.rect.minY))
        path.addRoundedRect(in: dataSet.rect, cornerWidth: dataSet.cornerRadius, cornerHeight: dataSet.cornerRadius)
        context.addPath(path)
        
        context.setStrokeColor(dataSet.borderColor.cgColor)
        context.setLineWidth(dataSet.borderWidth)
//      context.setFillColor(UIColor.blue.cgColor)
//      context.drawPath(using: .fillStroke)
//      context.fillPath()
        
        
        /// 长按选中处理
        if let longPressPoint = viewPortHandler.longPressPoint {
            
            let topLeftPoint = dataSet.rect.origin
            let topRightPoint = CGPoint(x: topLeftPoint.x + dataSet.rect.width, y: topLeftPoint.y)
            let bottomLeftPoint = CGPoint(x: topLeftPoint.x, y: topLeftPoint.y + dataSet.rect.height)
            let bottomRightPoint = CGPoint(x: topRightPoint.x , y: bottomLeftPoint.y)
            
            let isContains = longPressPoint.isInPolygon([topLeftPoint.applying(matrix), topRightPoint.applying(matrix), bottomRightPoint.applying(matrix), bottomLeftPoint.applying(matrix)])
            
            if (isContains) {
                context.setStrokeColor(dataSet.borderSelectedColor.cgColor)
            }
            
        }
        
        context.strokePath()
        
        /// 绘制item
        dataSet.entries.forEach { entry in
            drawItem(context: context, dataSet: dataSet, entry: entry)
        }
    }
    
    /// 绘制item
    func drawItem(context: CGContext, dataSet: LayoutDataSet, entry: LayoutDataEntry) {
        
        context.saveGState()
        defer {
            context.restoreGState()
        }
        
        let xIndex = entry.xaxisIndex - 1
        let yIndex = entry.yaxisIndex - 1
        let originX = dataSet.rect.minX + dataSet.edgeInsets.left + (dataSet.margin + dataSet.itemWidth)*Double(xIndex)
        let originY = dataSet.rect.minY + dataSet.edgeInsets.top + (dataSet.margin + dataSet.itemHeight)*Double(yIndex)
        let itemRect = CGRect(x: originX, y: originY, width: dataSet.itemWidth, height: dataSet.itemHeight)
        
        switch entry.state {
            case .empty:
                context.setStrokeColor(dataSet.itemBorderColor.cgColor)
                context.setLineWidth(dataSet.itemBorderWidth)
                context.stroke(itemRect)
                context.strokePath()
            case .unbound:
                drawFullRect(dataSet, context: context, itemRect: itemRect)
            case .bind:
                drawFullRect(dataSet, context: context, itemRect: itemRect, text: entry.deviceSn ?? "")
        }
    }

    /// 非空的状态下绘制效果
    func drawFullRect(_ dataSet: LayoutDataSet, context: CGContext, itemRect: CGRect, text: String = "") {
        
        context.setFillColor(dataSet.itemFillColor.cgColor)
        context.fill(itemRect)
        context.fillPath()
    
        /// 方向rect
        let directionRect = CGRect(x: itemRect.minX, y: itemRect.minY, width: dataSet.itemWidth, height: dataSet.itemDirectionHeight)
        context.setFillColor(dataSet.itemDirectionFillColor.cgColor)
        context.fill(directionRect)
        context.fillPath()
        
        /// 网格
        let gridCenter = CGPoint(x: itemRect.midX, y: itemRect.midY + directionRect.height/2.0)
        let centerLineLeftPoint = CGPoint(x: gridCenter.x - dataSet.itemGridWidth/2.0, y: gridCenter.y)
        let topLineLeftPoint = CGPoint(x: centerLineLeftPoint.x, y: centerLineLeftPoint.y - dataSet.itemGridHight/2.0)
        let bottomLineLeftPoint = CGPoint(x: centerLineLeftPoint.x, y: centerLineLeftPoint.y + dataSet.itemGridHight/2.0)
        
        let path = CGMutablePath()
        path.move(to: topLineLeftPoint)
        path.addLine(to: CGPoint(x: topLineLeftPoint.x + dataSet.itemGridWidth, y: topLineLeftPoint.y))
        path.move(to: centerLineLeftPoint)
        path.addLine(to: CGPoint(x: centerLineLeftPoint.x + dataSet.itemGridWidth, y: centerLineLeftPoint.y))
        path.move(to: bottomLineLeftPoint)
        path.addLine(to: CGPoint(x: bottomLineLeftPoint.x + dataSet.itemGridWidth, y: bottomLineLeftPoint.y))
        path.move(to: CGPoint(x: gridCenter.x, y: topLineLeftPoint.y))
        path.addLine(to: CGPoint(x: gridCenter.x, y: bottomLineLeftPoint.y))
    
        context.addPath(path)
        context.setStrokeColor(dataSet.itemGridLineColor.cgColor)
        context.setLineWidth(dataSet.itemGridLineWidth)
        context.strokePath()
        
        /// 文字绘制
        guard !text.isEmpty else {
            return
        }
        /// 可绘制区域
        let size = CGSize(width: dataSet.itemWidth - 2*dataSet.itemTextMargin, height: dataSet.itemHeight - dataSet.itemDirectionHeight - 2*dataSet.itemTextMargin)
        let attributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: dataSet.itemTextFontSize),
            NSAttributedString.Key.foregroundColor: dataSet.itemTextColor
        ]
        /// 计算大小
        let rect = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        let textRect = CGRect(x: gridCenter.x - rect.width/2.0, y: gridCenter.y - rect.height/2.0, width: rect.width, height: rect.height)
        (text as NSString).draw(in: textRect, withAttributes: attributes)
    }
}
