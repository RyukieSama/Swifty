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
}
