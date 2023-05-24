//
//  Color+Hex.swift
//  Alamofire
//
//  Created by 王荣庆 on 2019/9/16.
//

#if !os(macOS)

import UIKit

public extension UIColor {
    
    func toRGBA() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        guard let components = self.cgColor.components else { return (0, 0, 0, 0) }
        let red = components.count > 0 ? components[0] : 0
        let green = components.count > 1 ? components[1] : 0
        let blue = components.count > 2 ? components[2] : 0
        let alpha = components.count > 3 ? components[3] : 1
        return (red, green, blue, alpha)
    }

    /// 转 16 进制字符串
    /// - Returns: 16 进制字符串
    func toHexString() -> String {
        guard let components = self.cgColor.components else { return "FFFFFF" }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        let a = Float(components[3])
        let hexString = String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        return hexString
    }
    
    /// 生成随机颜色
    /// - Parameter alpla: 透明度
    /// - Returns: 颜色
    static func random(alpla: CGFloat = 1) -> UIColor {
        UIColor(red: CGFloat(arc4random_uniform(256)) / 255, green: CGFloat(arc4random_uniform(256)) / 255, blue: CGFloat(arc4random_uniform(256)) / 255, alpha: alpla)
    }
    
    /// Dynamic between dark mode and default mode
    /// - Parameters:
    ///   - defaultColor: default color
    ///   - darkColor: dark mode color
    /// - Returns: color
    @available(iOS 13.0, *)
    static func dynamic(defaultColor: UIColor, darkColor: UIColor? = nil) -> UIColor {
        return UIColor { (trait) -> UIColor in
            if trait.userInterfaceStyle == .dark {
                return darkColor ?? defaultColor
            }
            return defaultColor
        }
    }
    
    /// Get UIColor from HEX string like #D8D8D8
    /// - Parameters:
    ///   - hex: hex String
    ///   - alpha: alpha description
    /// - Returns: UIColor
    static func hexStringToColor(hex: String, alpha: CGFloat = 1) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return .clear
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
    
    /// Get UIColor from HEX value like 0xD8D8D8
    /// - Parameters:
    ///   - hex: hex description
    ///   - alpha: alpha
    /// - Returns: UIColor
    static func hexValueToColor(hex: UInt32, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }

}

#endif


#if os(OSX)
    import AppKit
    typealias Color = NSColor
#elseif os(iOS) || os(tvOS)
    import UIKit
    typealias Color = UIColor
#endif

extension Color
{
    /// Initializes a `NSColor` or `UIColor` object from a (hexadecimal) `UInt32` value.
    ///
    /// - parameter hex: The (hexadecimal) value with 8 bits per color channel.
    ///                  `0xRRGGBB` e.g. `0xff0000` for red.
    /// - parameter alpha: The desired value of the alpha channel of the color to create.
    ///                    Default is 1.0
    ///                    Should be in the range of 0.0...1.0
    ///
    convenience init(hex: UInt32, alpha a: CGFloat = 1.0) {
        let r = CGFloat((hex >> 16) & 0xFF) / 255.0
        let g = CGFloat((hex >> 8)  & 0xFF) / 255.0
        let b = CGFloat((hex)       & 0xFF) / 255.0
        
        self.init(red: r, green: g , blue: b , alpha: a)
    }
}
