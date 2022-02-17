//
//  Date+Swifty.swift
//  Swifty
//
//  Created by 王荣庆 on 2020/5/19.
//

import Foundation

extension Date: SwiftyCompatible {}

public extension Swifty where Base == Date {
    func localizedString() -> String {
        return DateFormatter.localizedString(from: base, dateStyle: .medium, timeStyle: .short)
    }
}
