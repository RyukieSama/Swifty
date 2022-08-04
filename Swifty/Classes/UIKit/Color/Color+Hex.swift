//
//  Color+Hex.swift
//  Alamofire
//
//  Created by 王荣庆 on 2019/9/16.
//

#if !os(macOS)

import UIKit

public extension UIColor {

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
