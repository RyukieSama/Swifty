//
//  UIScrollView+Screenshot.swift
//  RyukieSwifty
//
//  Created by 王荣庆 on 2023/5/26.
//

import UIKit

#if !os(macOS)

public extension Swifty where Base: UIView {
    func takeScreenshotImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(base.frame.size, base.isOpaque, 0)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        base.layer.render(in: context)
        let screenShot = UIGraphicsGetImageFromCurrentImageContext()
        return screenShot
    }
}

#endif
