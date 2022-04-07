//
//  RecordModel.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/3/31.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation
import HandyJSON

class RecordModel: HandyJSON {
    var systemId: String?
    var year: Int?
    var month: Int?
    var day: Int?
    var generationValue: Double?
    var useValue: Double?
    var buyValue: Double?
    var fullPowerHoursDay: Double?
    
    required init() {}
}
