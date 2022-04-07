//
//  DayModel.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/3/28.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation
import HandyJSON

class DayModel: HandyJSON {
    var dateTime: Int?
    var generationPower: Double?
    var generationCapacity: Double?
    var usePower: Double?
    var wirePower: Double?
    var batteryPower: Double?
    var chargePower: Double?
    required init() {}
}
