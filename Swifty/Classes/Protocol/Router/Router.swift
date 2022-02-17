//
//  Router.swift
//  Swifty
//
//  Created by 王荣庆 on 2019/12/31.
//  Copyright © 2019 Swifty. All rights reserved.
//

#if !os(macOS)

import UIKit

/**
 OC部分调用的接口就用 NSObject 来封装了，其他部分使用纯Swift
 */

// MARK: - Swift模块接口
/// Swift模块接口
open class SwiftModuleInterface: NSObject {  // open 可以被其他module继承和override
    
    /// 调用Swift模块
    /// - Parameter module: 模块实例
    @objc
    public class func perform(module: SwiftModuleProtocol) {
        perform(module: module, param: nil, closure: nil)
    }
    
    /// 调用Swift模块
    /// - Parameters:
    ///   - module: 模块实例
    ///   - param: 参数
    @objc
    public class func perform(module: SwiftModuleProtocol, param: Any?) {
        perform(module: module, param: param, closure: nil)
    }
    
    /// 调用Swift模块
    /// - Parameters:
    ///   - module: 模块实例
    ///   - closure: 回调
    @objc
    public  class func perform(module: SwiftModuleProtocol, closure: SwiftModuleClosure?) {
        module.perform(with: nil, closure: closure)
    }

    /// 调用Swift模块
    /// - Parameters:
    ///   - module: 模块实例
    ///   - param: 参数
    ///   - closure: 回调
    @objc
    public class func perform(module: SwiftModuleProtocol, param: Any?, closure: SwiftModuleClosure?) {
        module.perform(with: param, closure: closure)
    }
}


// MARK: - Swift 模块协议
/// Swift 模块协议
@objc
public protocol SwiftModuleProtocol {
    func perform(with param:Any?, closure: SwiftModuleClosure?)
}

/// 第一个为回调需要带的参数， 后面的Bool按需使用，这里单独设置一个Bool是为了在OC好处理
public typealias SwiftModuleClosure = ((Any?, Bool) -> ())

#endif
