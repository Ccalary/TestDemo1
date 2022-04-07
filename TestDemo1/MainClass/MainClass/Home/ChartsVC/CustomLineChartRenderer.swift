//
//  CustomLineChartRenderer.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/3/29.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation
import Charts

// 处理高亮线段绘制
class CustomLineChartRenderer: LineChartRenderer {
    var hightlightCircleRadius: CGFloat = 4.0
    
    // 自定义绘制高亮线段
    open override func drawHighlighted(context: CGContext, indices: [Highlight]) {
        guard let dataProvider = dataProvider, let lineData = dataProvider.lineData else {
            return
        }
        let chartXMax = dataProvider.chartXMax
        guard let dataSets = lineData.dataSets as? [LineChartDataSet], let hightlight = indices.first else {
            return
        }
        var pointArray: [CGPoint] = []
        var setArray: [LineChartDataSet] = []
        // 最高点
        var minY = viewPortHandler.contentBottom
        // 遍历所有数据找出对应的点
        dataSets.forEach { dataSet in
            // entryForXValue 通过这个方法找到符合x点所有原始数据
            guard let entry = dataSet.entryForXValue(hightlight.x, closestToY: hightlight.y) else { return }
            let x = entry.x // get the x-position
            let y = entry.y * Double(animator.phaseY)
            // 过滤掉界外和x轴数据不等的点
            if !isInBoundsX(entry: entry, dataSet: dataSet) || (entry.x != hightlight.x) || (x > chartXMax * animator.phaseX) {
                return
            }
            let transformer = dataProvider.getTransformer(forAxis: dataSet.axisDependency)
            // 转换得到实际的x，y坐标点
            let point = transformer.pixelForValues(x: x, y: y)
            minY = min(point.y, minY)
            pointArray.append(point)
            setArray.append(dataSet)
        }
        if (setArray.isEmpty) {
            return
        }
        drawCustomHighlightLine(context: context, point: CGPoint(x: pointArray.first!.x, y: minY))
        for i in 0..<setArray.count {
            let set = setArray[i]
            let point = pointArray[i]
            drawCustomHighlightCircle(context: context, dataSet: set, point: point)
        }
    }
    
    // 绘制高亮线段
    func drawCustomHighlightLine(context: CGContext, point: CGPoint) {
        context.saveGState()
        context.setStrokeColor(UIColor(hex: 0x4E95F8).cgColor)
        context.setLineWidth(1)
        context.setLineDash(phase: 0, lengths: [3.0,3.0])

        context.beginPath()
        context.move(to: CGPoint(x: point.x, y: point.y))
        context.addLine(to: CGPoint(x: point.x, y: viewPortHandler.contentBottom))
        context.strokePath()
        context.restoreGState()
    }
    
    // 绘制高亮线段上的圆点
    func drawCustomHighlightCircle(context: CGContext, dataSet: LineChartDataSet, point: CGPoint) {
        // saveGState，restoreGState 包裹起来可以单独设置颜色等属性
        context.saveGState()
        context.setStrokeColor(dataSet.highlightColor.cgColor)
        context.setLineWidth(dataSet.highlightLineWidth)
        context.setFillColor(UIColor(hex: 0xffffff, alpha: 0.9).cgColor)
        
        context.beginPath()
        context.addArc(center: point, radius: hightlightCircleRadius, startAngle: 0, endAngle: Double.pi*2.0, clockwise: true)
        // 边线和填充色都绘制
        context.drawPath(using: .fillStroke)
        context.restoreGState()
    }
    
    func isInBoundsX(entry: ChartDataEntry, dataSet: BarLineScatterCandleBubbleChartDataSetProtocol) -> Bool {
        let entryIndex = dataSet.entryIndex(entry: entry)
        return Double(entryIndex) < Double(dataSet.entryCount) * animator.phaseX
    }
}

