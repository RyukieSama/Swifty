//
//  UIFont+Ex.swift
//  Alamofire
//
//  Created by wrq on 2024/5/21.
//

#if !os(macOS)

import UIKit

extension UIFont: SwiftyCompatible {}

public extension UIFont {
    @available(iOS 11.0, *)
    static func swifty_dynamicFont(size: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        // 使用UIFontMetrics来跟踪系统字体大小设置的变化
        let fontMetrics = UIFontMetrics.default
        // 创建一个适应用户偏好设置的动态字体
        let dynamicFont = fontMetrics.scaledFont(for: UIFont.systemFont(ofSize: size,
                                                                        weight: weight))
        return dynamicFont
    }
}

#endif

