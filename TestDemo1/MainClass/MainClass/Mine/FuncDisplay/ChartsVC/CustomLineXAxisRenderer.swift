//
//  CustomLineXAxisRenderer.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/3/29.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation

open class CustomLineXAxisRenderer: XAxisRenderer {
  
    // x轴拆分，根据最小粒度的倍数展示
    open override func computeAxisValues(min: Double, max: Double) {
        let yMin = min
        let yMax = max

        let labelCount = axis.labelCount
        let range = abs(yMax - yMin)

        guard labelCount != 0, range > 0, range.isFinite else {
            axis.entries = []
            axis.centeredEntries = []
            return
        }
        // Find out how much spacing (in y value space) between axis values
        let rawInterval = range / Double(labelCount)
        var interval = rawInterval.customLineRoundedToNextSignificant(axis.granularity)
        // If granularity is enabled, then do not allow the interval to go below specified granularity.
        // This is used to avoid repeated values when rounding values for display.
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
    }
}

