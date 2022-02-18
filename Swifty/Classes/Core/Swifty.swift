//
//  Swifty.swift
//  Swifty
//
//  Created by 王荣庆 on 2019/9/8.
//  Copyright © 2019 RyukieSama. All rights reserved.
//

import Foundation

public struct Swifty<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol SwiftyCompatible {
    associatedtype CompatibleType
    var swifty: CompatibleType { get }
}

public extension SwiftyCompatible {
    var swifty: Swifty<Self> {
        return Swifty(self)
    }
}
