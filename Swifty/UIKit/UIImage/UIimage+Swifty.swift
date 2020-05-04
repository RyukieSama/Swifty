//
//  UIimage+Swifty.swift
//  Swifty
//
//  Created by 王荣庆 on 2019/11/15.
//  Copyright © 2019 RyukieSama. All rights reserved.
//

import UIKit

public extension UIImage {
    func resize(toSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(toSize)
        self.draw(in: CGRect(x: 0, y: 0, width: toSize.width, height: toSize.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    @available(iOS 13.0, *)
    static func systemImage(name: String, font: UIFont, scale: SymbolScale = .default) -> UIImage? {
        let config = UIImage.SymbolConfiguration(font: font, scale: scale)
        return UIImage(systemName: name, withConfiguration: config)
    }
    
    @available(iOS 13.0, *)
    static func systemImage(name: String, weight: SymbolWeight = .regular) -> UIImage? {
        let config = UIImage.SymbolConfiguration(weight: weight)
        return UIImage(systemName: name, withConfiguration: config)
    }
    
    @available(iOS 13.0, *)
    static func systemImage(name: String, pointSize: CGFloat, weight: SymbolWeight = .regular, scale: SymbolScale = .default) -> UIImage? {
        let config = UIImage.SymbolConfiguration(pointSize: pointSize, weight: weight, scale: scale)
        return UIImage(systemName: name, withConfiguration: config)
    }
    
    @available(iOS 13.0, *)
    static func systemImage(name: String, textStyle: UIFont.TextStyle = .body, scale: UIImage.SymbolScale = .default) -> UIImage? {
        let config = UIImage.SymbolConfiguration(textStyle: textStyle, scale: scale)
        return UIImage(systemName: name, withConfiguration: config)
    }
    
}
