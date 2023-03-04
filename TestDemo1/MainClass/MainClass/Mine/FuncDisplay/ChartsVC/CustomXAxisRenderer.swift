//
//  CustomLineXAxisRenderer.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/3/29.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation

open class CustomXAxisRenderer: XAxisRenderer {
    
    // 渲染类型
    public enum CustomXAxisType {
        case line
        case bar
    }
    
    public let imageAxis: XImageAxis
    /// 渲染类型
    public var xAxisType: CustomXAxisType
    
    public init(viewPortHandler: ViewPortHandler, axis: XAxis, transformer: Transformer?, xImageAxis: XImageAxis, xAxisType: CustomXAxisType = .line) {
        self.imageAxis = xImageAxis
        self.xAxisType = xAxisType
        super.init(viewPortHandler: viewPortHandler, axis: axis, transformer: transformer)
    }
    
    // x轴拆分，根据最小粒度的倍数展示
    open override func computeAxisValues(min: Double, max: Double) {
        switch xAxisType {
        case .line: /// 折线格式自处理
            let yMin = min
            let yMax = max

            let labelCount = axis.labelCount
            let range = abs(yMax - yMin)

            guard labelCount != 0, range > 0, range.isFinite else {
                axis.entries = []
                axis.centeredEntries = []
                return
            }
            // 计算间距
            let rawInterval = range / Double(labelCount)
            // 自定义偏移算法，计算实际的间距
            var interval = rawInterval.customLineRoundedToNextSignificant(axis.granularity)
            // 取自定义间距和算出的大值，作为间距
            if axis.granularityEnabled {
                interval = Swift.max(interval, axis.granularity)
            }
            var n = axis.centerAxisLabelsEnabled ? 1 : 0
            // no forced count
            var first = interval == 0.0 ? 0.0 : ceil(yMin / interval) * interval
            if axis.centerAxisLabelsEnabled {
                first -= interval
            }
            let last = interval == 0.0 ? 0.0 : (floor(yMax / interval) * interval).nextUp
            if interval != 0.0, last != first {
                stride(from: first, through: last, by: interval).forEach { _ in n += 1 }
            }
            // Ensure stops contains at least n elements.
            axis.entries.removeAll(keepingCapacity: true)
            axis.entries.reserveCapacity(labelCount)
            let start = first, end = first + Double(n) * interval
            // Fix for IEEE negative zero case (Where value == -0.0, and 0.0 == -0.0)
            let values = stride(from: start, to: end, by: interval).map { $0 == 0.0 ? 0.0 : $0 }
            axis.entries.append(contentsOf: values)
            // set decimals
            if interval < 1 {
                axis.decimals = Int(ceil(-log10(interval)))
            } else {
                axis.decimals = 0
            }
            if axis.centerAxisLabelsEnabled {
                let offset: Double = interval / 2.0
                axis.centeredEntries = axis.entries[..<n].map { $0 + offset }
            }
            computeSize()
        case .bar: // 柱状图根据父类处理
            super.computeAxisValues(min: min, max: max)
        }
    }
    
    // 渲染图标，计算位置
    open override func renderAxisLabels(context: CGContext) {
        super.renderAxisLabels(context: context)
        guard
            axis.isEnabled,
            axis.isDrawLabelsEnabled
            else { return }
        /// 高度
        let xlabelheight = axis.labelRotatedHeight + axis.yOffset
        
        if (axis.labelPosition == .top) {
            switch self.imageAxis.iconPosition {
                case .top:
                    drawIcons(context: context, pos: viewPortHandler.contentTop - self.imageAxis.iconSize.height - xlabelheight - self.imageAxis.iconYOffset)
                case .bottom:
                    drawIcons(context: context, pos: viewPortHandler.contentBottom + self.imageAxis.iconYOffset)
                case .none:
                    break
            }
        }else if (axis.labelPosition == .bottom) {
            switch self.imageAxis.iconPosition {
                case .top:
                    drawIcons(context: context, pos: viewPortHandler.contentTop - self.imageAxis.iconSize.height - self.imageAxis.iconYOffset)
                case .bottom:
                    drawIcons(context: context, pos: viewPortHandler.contentBottom + xlabelheight + self.imageAxis.iconYOffset)
                case .none:
                    break
            }
        }else if (axis.labelPosition == .bothSided) {
            switch self.imageAxis.iconPosition {
                case .top:
                    drawIcons(context: context, pos: viewPortHandler.contentTop - self.imageAxis.iconSize.height - xlabelheight - self.imageAxis.iconYOffset)
                case .bottom:
                    drawIcons(context: context, pos: viewPortHandler.contentBottom + xlabelheight + self.imageAxis.iconYOffset)
                case .none:
                    break
            }
        }else if (axis.labelPosition == .topInside) {
            switch self.imageAxis.iconPosition {
                case .top:
                    drawIcons(context: context, pos: viewPortHandler.contentTop - self.imageAxis.iconSize.height - self.imageAxis.iconYOffset)
                case .bottom:
                    drawIcons(context: context, pos: viewPortHandler.contentBottom + self.imageAxis.iconYOffset)
                case .none:
                    break
            }
        }else if (axis.labelPosition == .bottomInside) {
            switch self.imageAxis.iconPosition {
                case .top:
                    drawIcons(context: context, pos: viewPortHandler.contentTop - self.imageAxis.iconSize.height - self.imageAxis.iconYOffset)
                case .bottom:
                    drawIcons(context: context, pos: viewPortHandler.contentBottom + self.imageAxis.iconYOffset)
                case .none:
                    break
            }
        }
    }
    
    private func drawIcons(context: CGContext, pos: CGFloat) {
        switch self.xAxisType {
            case .line:
                drawLineIcons(context: context, pos: pos)
            case .bar:
                drawBarIcons(context: context, pos: pos)
        }
    }
    
    /// 绘制icon
    @objc open func drawLineIcons(context: CGContext, pos: CGFloat) {
        guard let transformer = self.transformer else { return }
        
        let valueToPixelMatrix = transformer.valueToPixelMatrix

        var position = CGPoint.zero
        /// 是否居中
        let isCenteringEnabled = axis.isCenterAxisLabelsEnabled
        let offset = (axis.centeredEntries.first ?? 0) - (axis.entries.first ?? 0)
        /// x轴对应点位数据
        let entries = imageAxis.dataEntries.map {$0.x}
        /// x轴对应的图片名称
        let icons = imageAxis.dataEntries.map {$0.data}
                
        for i in entries.indices {
            let px = isCenteringEnabled ? (CGFloat(entries[i]) + offset) : CGFloat(entries[i])
            position = CGPoint(x: px, y: 0).applying(valueToPixelMatrix)
            
            guard viewPortHandler.isInBoundsX(position.x) else { continue }
            /// 增加icon
            if let icon = UIImage(named: icons[i] as! String) {
                context.drawImage(icon,
                                  atCenter: CGPoint(x: position.x, y: pos + imageAxis.iconSize.height / 2.0),
                                  size: imageAxis.iconSize)
            }
        }
      }
      
      // bar天气图标绘制
      @objc open func drawBarIcons(context: CGContext, pos: CGFloat) {
          guard let transformer = self.transformer else { return }

          let isCenteringEnabled = axis.isCenterAxisLabelsEnabled
          let valueToPixelMatrix = transformer.valueToPixelMatrix

          var position = CGPoint.zero
          let entries = axis.entries

          for i in entries.indices {
              let px = isCenteringEnabled ? CGFloat(axis.centeredEntries[i]) : CGFloat(entries[i])
              position = CGPoint(x: px, y: 0)
                  .applying(valueToPixelMatrix)

              guard viewPortHandler.isInBoundsX(position.x) else { continue }

              let label = axis.valueFormatter?.stringForValue(axis.entries[i], axis: axis) ?? ""

              for item in imageAxis.dataEntries {
                  if (item.x == Double(label)) {
                      if let icon = UIImage(named: item.data as! String) {
                          context.drawImage(icon,
                                            atCenter: CGPoint(x: position.x, y: pos + imageAxis.iconSize.height / 2.0),
                                            size: imageAxis.iconSize)
                      }
                  }
              }
          }
      }
}


extension Double {
    /// 根据最小粒度算出拆分数据
    func customLineRoundedToNextSignificant(_ granularity: Double = 60.0) -> Double {
        guard !isInfinite, !isNaN, self != 0 else {
            return self
        }
        // 四舍五入
        let value = lround(self/granularity)
        return Double(granularity*Double(value))
    }
    
    /// y轴数据处理
    func yRoundedToNextSignificant() -> Double {
        guard !isInfinite, !isNaN, self != 0 else {
            return self
        }
        // 给定一个数字，求它的数量级最接近的10^n的倍数。
        let value = ceil(log10(self < 0 ? -self : self))
        let number = 1 - Int(value)
        let magnitude = pow(10.0, Double(number))
        // 做了up向上取整操作
        let shifted = (self * magnitude).rounded(.awayFromZero)
        return shifted / magnitude
    }
}
