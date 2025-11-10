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

public extension UIFont {
    
    /// 系统字体族枚举
    enum SystemFontFamily: String {
        // MARK: - 系统默认字体族
        case sfProText = "SFProText"
        case sfProDisplay = "SFProDisplay"
        case sfMono = "SFMono"
        
        // MARK: - 中文字体族
        case pingFangSC = "PingFangSC"
        case pingFangTC = "PingFangTC"
        case pingFangHK = "PingFangHK"
        case songtiSC = "SongtiSC"
        case kaitiSC = "KaitiSC"
        case heitiSC = "Heiti SC"
        
        // MARK: - 等宽字体
        case menlo = "Menlo"
        case courierNew = "CourierNewPS"
        
        // MARK: - 其他常见字体
        case avenirNext = "AvenirNext"
        case helveticaNeue = "HelveticaNeue"
        case timesNewRoman = "TimesNewRomanPS"
    }
    
    /// 字重后缀映射
    private static func suffix(for weight: UIFont.Weight) -> String {
        switch weight {
        case .ultraLight: return "-UltraLight"
        case .thin:       return "-Thin"
        case .light:      return "-Light"
        case .regular:    return "-Regular"
        case .medium:     return "-Medium"
        case .semibold:   return "-Semibold"
        case .bold:       return "-Bold"
        case .heavy:      return "-Heavy"
        case .black:      return "-Black"
        default:          return "-Regular"
        }
    }
    
    /// 创建系统字体（支持字重 + 斜体）
    ///
    /// - Parameters:
    ///   - family: 字体族
    ///   - size: 字号
    ///   - weight: 字重（默认 regular）
    ///   - italic: 是否为斜体
    /// - Returns: UIFont 实例
    static func swifty_systemFont(_ family: SystemFontFamily,
                           size: CGFloat,
                           weight: UIFont.Weight = .regular,
                           italic: Bool = false) -> UIFont {
        
        // MARK: - 系统字体系列（SF）
        if family == .sfProText || family == .sfProDisplay {
            if italic {
                return UIFont.italicSystemFont(ofSize: size)
            }
            return UIFont.systemFont(ofSize: size, weight: weight)
        }
        
        if family == .sfMono {
            if italic {
                return UIFont.monospacedSystemFont(ofSize: size, weight: weight)
                    .withTraits(.traitItalic)
            }
            return UIFont.monospacedSystemFont(ofSize: size, weight: weight)
        }
        
        // MARK: - 拼接字体名
        var fontName = family.rawValue + suffix(for: weight)
        
        if italic {
            // 尝试 -Italic 或 -Oblique 或 -BoldItalic
            let italicCandidates = [
                fontName + "Italic",
                fontName + "Oblique",
                family.rawValue + "-Italic",
                family.rawValue + "-Oblique"
            ]
            
            for name in italicCandidates {
                if let f = UIFont(name: name, size: size) {
                    return f
                }
            }
        }
        
        // 常规字体
        if let font = UIFont(name: fontName, size: size) {
            return font
        }
        
        // 回退 Regular
        if let regularFont = UIFont(name: family.rawValue + "-Regular", size: size) {
            return regularFont
        }
        
        // 最终回退系统字体
        return italic ? UIFont.italicSystemFont(ofSize: size) : UIFont.systemFont(ofSize: size, weight: weight)
    }
}

// MARK: - UIFont 辅助 Trait 方法
private extension UIFont {
    func withTraits(_ traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(traits) else { return self }
        return UIFont(descriptor: descriptor, size: 0)
    }
}

#endif

