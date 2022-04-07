//
//  CustomBarChartView.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/4/1.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation
import Charts

open class CustomBarChartView: BarChartView {
    func setupCustomRenderer() {
        renderer = CustomBarChartRenderer(dataProvider: self, animator: chartAnimator, viewPortHandler: viewPortHandler)
    }
}
