//
//  UIView+Swifty.swift
//  Swifty
//
//  Created by 王荣庆 on 2019/9/14.
//  Copyright © 2019 RyukieSama. All rights reserved.
//

import UIKit

public extension Swifty where Base: UIView {
    func x(x: CGFloat) {
        base.frame = CGRect(x: x, y: base.frame.origin.y, width: base.frame.size.width, height: base.frame.size.height)
    }
    
    func y(y: CGFloat) {
        base.frame = CGRect(x: base.frame.origin.x, y: y, width: base.frame.size.width, height: base.frame.size.height)
    }
    
    func width(width: CGFloat)  {
        base.frame = CGRect(x: base.frame.origin.x, y: base.frame.origin.y, width: width, height: base.frame.size.height)
    }
    
    func height(height: CGFloat) {
        base.frame = CGRect(x: base.frame.origin.x, y: base.frame.origin.y, width: base.frame.size.width, height: height)
    }
}
