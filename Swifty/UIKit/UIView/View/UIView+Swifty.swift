//
//  UIView+Swifty.swift
//  Swifty
//
//  Created by 王荣庆 on 2019/9/14.
//  Copyright © 2019 RyukieSama. All rights reserved.
//

import UIKit

public extension Swifty where Base: UIView {
    var x: CGFloat {
        return base.frame.origin.x
    }
    
    var y: CGFloat {
        return base.frame.origin.y
    }
    
    var width: CGFloat {
        return base.frame.size.width
    }
    
    var height: CGFloat {
        return base.frame.size.height
    }
    
    func setX(x: CGFloat) {
        base.frame = CGRect(x: x, y: base.frame.origin.y, width: base.frame.size.width, height: base.frame.size.height)
    }
    
    func setY(y: CGFloat) {
        base.frame = CGRect(x: base.frame.origin.x, y: y, width: base.frame.size.width, height: base.frame.size.height)
    }
    
    func setWidth(width: CGFloat)  {
        base.frame = CGRect(x: base.frame.origin.x, y: base.frame.origin.y, width: width, height: base.frame.size.height)
    }
    
    func setHeight(height: CGFloat) {
        base.frame = CGRect(x: base.frame.origin.x, y: base.frame.origin.y, width: base.frame.size.width, height: height)
    }
}
