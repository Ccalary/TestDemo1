//
//  ToolsHelper.swift
//  TestDemo1
//
//  Created by caohouhong on 2022/3/22.
//  Copyright © 2022 caohouhong. All rights reserved.
//

import Foundation

class ToolsHelper {
    /// 更改字体大小
    /// - Parameters:
    ///   - originalText: 全部文字
    ///   - changeText: 要更改的文字
    ///   - font: 字体
   static func changeTextSize(_ originalText: String, _ changeText: String, _ font: UIFont) -> NSMutableAttributedString {
        let attrStr = NSMutableAttributedString(string: originalText)
        let changeStrRange: Range = originalText.range(of: changeText)!
        let location = originalText.distance(from: originalText.startIndex, to: changeStrRange.lowerBound)
        let range: NSRange = NSRange(location: location, length: changeText.count)
        attrStr.addAttribute(NSAttributedString.Key.font, value: font, range: range)
        return attrStr
    }
}

/* 颜色的十六进制 */
extension UIColor {
    convenience init(_ hex: Int,_ alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
