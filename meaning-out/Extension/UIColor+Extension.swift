//
//  UIColor+Extension.swift
//  meaning-out
//
//  Created by junehee on 6/14/24.
//

import UIKit

extension UIColor {
    // Hex색상코드를 UIColor로 변경
    convenience init(rgb: UInt, alpha: CGFloat = 1.0) {
       self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                 green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                 blue: CGFloat(rgb & 0x0000FF) / 255.0,
                 alpha: CGFloat(alpha))
    }
}
