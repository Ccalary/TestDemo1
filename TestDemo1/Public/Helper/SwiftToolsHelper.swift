//
//  ToolsHelper.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/3/22.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation

class SwiftToolsHelper {
    
}

/* 颜色的十六进制 */
extension UIColor {
    convenience init(_ hex: Int,_ alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    // 十六进制颜色
    convenience init(_ hexString: String, alpha: CGFloat = 1.0) {
        var cString = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") { cString.removeFirst() }
        
        if cString.count != 6 {
          self.init("ff0000") // return red color for wrong hex input
          return
        }
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        self.init(Int(rgbValue), alpha)
    }
}
