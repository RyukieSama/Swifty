//
//  UIimage+Swifty.swift
//  Swifty
//
//  Created by 王荣庆 on 2019/11/15.
//  Copyright © 2019 RyukieSama. All rights reserved.
//

import UIKit
import CoreGraphics

public extension UIImage {
    func resize(toSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(toSize)
        self.draw(in: CGRect(x: 0, y: 0, width: toSize.width, height: toSize.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    @available(iOS 13.0, *)
    static func systemImageForNavigationItem(name: String) -> UIImage? {
        return UIImage.systemImage(name: name, font: .systemFont(ofSize: 24))
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
    
    static func image(color: UIColor, size: CGSize) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return theImage
    }
    
}

// MARK: - Base64
public extension UIImage {
    /// 获取图片的Base64
    /// - Returns: Base64
    func base64String() -> String? {
        guard let data = jpegData(compressionQuality: 1) else {
            return nil
        }
        return data.base64EncodedString()
    }
    
    /// 通过base64获取图片
    /// - Parameter base64: Base64
    /// - Returns: 图片
    static func image(from base64: String) -> UIImage? {
        guard let data = Data(base64Encoded: base64) else {
            return nil
        }
        return UIImage(data: data)
    }
}
