//
//  SwiftyLog.swift
//  Swifty
//
//  Created by 王荣庆 on 2020/5/4.
//

import Foundation

public func SwiftyLog(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG // 判断是否在测试环境下
    print(items, separator, terminator)
    #else
    #endif
}
