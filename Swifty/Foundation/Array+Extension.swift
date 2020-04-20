//
//  Array+Extension.swift
//  Swifty
//
//  Created by 王荣庆 on 2020/3/31.
//

import Foundation

public extension Array {
    // 去重
    public func filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
}
