//
//  Service.swift
//  Swifty
//
//  Created by 王荣庆 on 2019/12/31.
//  Copyright © 2019 Swifty. All rights reserved.
//

import Foundation

public protocol SwiftyServiceProtocol {
    /// 请求参数
    var parameters: [AnyHashable : Any]? { get }
    /// 域名
    var base: String { get }
    /// 路径
    var path: String { get }
    /// 完整请求URLString  base + path
    var urlString: String { get }
    /// 请求方法
    var method: SwiftyServiceMethod { get }
    
    /// 网络请求回调 由使用方指定回调类型
    associatedtype SwiftyServiceCallBackType
    
    /// 发起请求
    func request(completion: Self.SwiftyServiceCallBackType?)
}

public enum SwiftyServiceMethod {
    case POST
    case GET
}

