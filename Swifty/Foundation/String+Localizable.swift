//
//  String+Localizable.swift
//  Alamofire
//
//  Created by 王荣庆 on 2019/11/13.
//

import Foundation

public extension String {
    public var localizableString: String {
        return NSLocalizedString(self, comment: "")
    }
}
