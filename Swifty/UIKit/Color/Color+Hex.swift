//
//  Color+Hex.swift
//  Alamofire
//
//  Created by 王荣庆 on 2019/9/16.
//

import Foundation

public extension UIColor {
    
    /// 快速适配暗黑模式颜色
    /// - Parameters:
    ///   - defaultColor: 默认颜色
    ///   - darkColor: 暗黑模式颜色 空 返回默认颜色
    /// - Returns: 根据模式选择的颜色
    @available(iOS 13.0, *)
    static func dynamic(defaultColor: UIColor, darkColor: UIColor? = nil) -> UIColor {
        return UIColor { (trait) -> UIColor in
            if trait.userInterfaceStyle == .dark {
                return darkColor ?? defaultColor
            }
            return defaultColor
        }
    }
    
    static func hexStringToColor(hex: String, alpha: CGFloat = 1) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
}
