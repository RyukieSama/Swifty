//
//  UITextField+Swifty.swift
//  Swifty
//
//  Created by 王荣庆 on 2019/11/14.
//  Copyright © 2019 RyukieSama. All rights reserved.
//

#if !os(macOS)

import UIKit

public extension Swifty where Base: UITextField {
    func checkLength() -> Bool {
        
        return true
    }
}

#endif
