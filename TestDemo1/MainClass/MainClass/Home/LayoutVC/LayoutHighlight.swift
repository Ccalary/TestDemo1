//
//  LayoutHighlight.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/4/29.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation

class LayoutHighlight {
   
    /// 数据组的下标
    private var dataSetIndex = Int(-1)
     
    init() {
        
    }
    
    convenience init(dataSetIndex: Int) {
        self.init()
        self.dataSetIndex = dataSetIndex
    }
}
