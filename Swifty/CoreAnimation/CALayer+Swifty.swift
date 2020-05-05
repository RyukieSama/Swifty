//
//  UIView+Swifty.swift
//  Swifty
//
//  Created by 王荣庆 on 2019/9/14.
//  Copyright © 2019 RyukieSama. All rights reserved.
//

import UIKit

extension CALayer: SwiftyCompatible {}

public extension Swifty where Base: CALayer {
    func addCorner(cornerRadius: CGFloat, corners: UIRectCorner = .allCorners) {
        let mask = CAShapeLayer()
        mask.frame = base.bounds
        mask.backgroundColor = UIColor.clear.cgColor
        
        let path = UIBezierPath(roundedRect: mask.bounds, byRoundingCorners: UIRectCorner(rawValue: UIRectCorner.RawValue(cornerRadius)), cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        
        mask.path = path.cgPath
        base.mask = mask
    }
}
