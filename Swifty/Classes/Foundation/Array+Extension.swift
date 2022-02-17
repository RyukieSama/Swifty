//
//  Array+Extension.swift
//  Swifty
//
//  Created by 王荣庆 on 2020/3/31.
//

import Foundation

public extension Array {
    /// 去重
    /// - Parameter filter: 去重的值
    /// - Returns: 结果 left 剩下的 out 提出的
    public func filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> FilterDuplicatesResults {
        var result = [Element]()
        var out = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
            else {
                out.append(value)
            }
        }
        return (result, out)
    }
    
    typealias FilterDuplicatesResults = (left: [Element], out: [Element])
}
