//
//  UIColor.swift
//  talk_iOS
//
//  Created by 박지수 on 2023/01/14.
//

import UIKit

extension UIColor{
    // MARK: hex 변환 가능 init
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
}
