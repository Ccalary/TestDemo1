//
//  CustomBarChartRenderer.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/4/1.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation

class CustomBarChartRenderer: BarChartRenderer {
    
    open override func drawHighlighted(context: CGContext, indices: [Highlight]) {
        guard let dataProvider = dataProvider, let barData = dataProvider.barData else {
            return
        }
        context.saveGState()
        defer {
            context.restoreGState()
        }
        var barRect = CGRect()
        guard let highlight = indices.first else {
            return
        }
        guard let set = barData[highlight.dataSetIndex] as? BarChartDataSetProtocol,
            set.isHighlightEnabled else {
            return
        }
        
        if let entry = set.entryForXValue(highlight.x, closestToY: highlight.y) as? BarChartDataEntry {
            guard isInBoundsX(entry: entry, dataSet: set) else {
                return
            }
            let transformer = dataProvider.getTransformer(forAxis: set.axisDependency)
            context.setFillColor(set.highlightColor.cgColor)
            context.setAlpha(set.highlightAlpha)
            let y1: Double = entry.y
            let y2: Double = 0.0
            prepareFullBarHighlight(x: entry.x, y1: y1, y2: y2, transformer: transformer, rect: &barRect)
            // 转化为整个Y轴填充满
            barRect = CGRect(x: barRect.origin.x, y: 0, width: barRect.width, height: barRect.origin.y + barRect.height)
            context.fill(barRect)
        }
    }
    
     func prepareFullBarHighlight(x: Double, y1: Double, y2: Double, transformer: Transformer, rect: inout CGRect) {
        // 取group的最左和最右边
        let left = floor(x) //x - barWidthHalf
        let right = ceil(x) //x + barWidthHalf
        let top = y1
        let bottom = y2
        
        rect.origin.x = CGFloat(left)
        rect.origin.y = CGFloat(top)
        rect.size.width = CGFloat(right - left)
        rect.size.height = CGFloat(bottom - top)
        transformer.rectValueToPixel(&rect, phaseY: animator.phaseY )
    }
    
    // 绘制顶部value判断方法
    open override func isDrawingValuesAllowed(dataProvider: ChartDataProvider?) -> Bool {
        guard let data = dataProvider?.data else { return false }
        let number = viewPortHandler.maxScaleX/viewPortHandler.scaleX*Double(data.dataSetCount)
        return number < 10.0
//        return data.entryCount < Int(CGFloat(dataProvider?.maxVisibleCount ?? 0) * viewPortHandler.scaleX)
    }
}
