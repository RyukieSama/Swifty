//
//  UIViewChainEx.swift
//  Swifty_Example
//
//  Created by 王荣庆 on 2022/7/20.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import RyukieSwifty
import SnapKit

extension UIView: ViewChainable {
    public typealias LayoutConstraintMaker = ConstraintMaker

    @discardableResult
    public func layout(maker: (ConstraintMaker?) -> Void) -> Self {
        snp.makeConstraints(maker)
        return self
    }

    @discardableResult
    public func layoutRemake(maker: (ConstraintMaker?) -> Void) -> Self {
        snp.remakeConstraints(maker)
        return self
    }

    @discardableResult
    public func layoutUpdate(maker: (ConstraintMaker?) -> Void) -> Self {
        snp.updateConstraints(maker)
        return self
    }
}



