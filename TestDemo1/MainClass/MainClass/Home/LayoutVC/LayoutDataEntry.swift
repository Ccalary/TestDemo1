//
//  LayoutEntry.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/4/25.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation

/**
    一个组件组内部item的数据
 */
class LayoutDataEntry {
    
    enum State: Int {
        /// 空
        case empty
        /// 未绑定
        case unbound
        /// 绑定
        case bind
    }
    
    var deviceSn: String?
    var state: State = .empty
    /// x下标，从1开始
    var xaxisIndex: Int = 0
    /// y下标，从1开始
    var yaxisIndex: Int = 0
    
    init() {
        
    }
    
    convenience init(deviceSn: String, state: State = .empty) {
        self.init()
        self.deviceSn = deviceSn
        self.state = state
    }
}
