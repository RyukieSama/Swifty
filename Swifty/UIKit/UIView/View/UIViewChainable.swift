//
//  UIViewChainable.swift
//  Swifty
//
//  Created by RyukieSama on 2020/09/01.
//  Copyright © 2020年 Swifty. All rights reserved.
//

import UIKit

/// UIView设置链式调用协议
public protocol ViewChainable {
    /// 根据项目自身使用布局框架设置
    associatedtype LayoutConstraintMaker
    
    typealias LayoutConstraintClosure = (LayoutConstraintMaker?) -> Void
    
    func layout(maker: LayoutConstraintClosure) -> Self
    
    func layoutRemake(maker: LayoutConstraintClosure) -> Self
    
    func layoutUpdate(maker: LayoutConstraintClosure) -> Self
}

extension ViewChainable {
    @discardableResult
    public func config(_ config: (Self) -> Void) -> Self {
        config(self)
        return self
    }

    @discardableResult
    public func added(to superView: UIView) -> Self {
        guard let view = self as? UIView else {
            return self
        }
        superView.addSubview(view)
        return self
    }
}
