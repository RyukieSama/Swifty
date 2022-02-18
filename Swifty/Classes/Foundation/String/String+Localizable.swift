//
//  String+Localizable.swift
//  Swifty
//
//  Created by 王荣庆 on 2019/9/14.
//  Copyright © 2019 RyukieSama. All rights reserved.
//

import Foundation

public extension String {
    var localizableString: String {
        return NSLocalizedString(self, comment: "")
    }
}
