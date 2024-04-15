//
//  SwiftyAsync.swift
//  RyukieSwifty
//
//  Created by wrq on 2024/4/15.
//

import UIKit

// 事件闭包
public typealias SwiftyTask = () -> Void

// MARK: - 延迟事件
public struct SwiftyAsyncs {
    // MARK: 1.1、异步做一些任务
    /// 异步做一些任务
    /// - Parameter SwiftyTask: 任务
    @discardableResult
    public static func async(_ SwiftyTask: @escaping SwiftyTask) -> DispatchWorkItem {
        return _asyncDelay(0, SwiftyTask)
    }
    
    // MARK: 1.2、异步做任务后回到主线程做任务
    /// 异步做任务后回到主线程做任务
    /// - Parameters:
    ///   - SwiftyTask: 异步任务
    ///   - mainSwiftyTask: 主线程任务
    @discardableResult
    public static func async(_ SwiftyTask: @escaping SwiftyTask,
                             _ mainSwiftyTask: @escaping SwiftyTask) -> DispatchWorkItem{
        return _asyncDelay(0, SwiftyTask, mainSwiftyTask)
    }
    
    // MARK: 1.3、异步延迟(子线程执行任务)
    /// 异步延迟(子线程执行任务)
    /// - Parameter seconds: 延迟秒数
    /// - Parameter SwiftyTask: 延迟的block
    @discardableResult
    public static func asyncDelay(_ seconds: Double,
                                  _ SwiftyTask: @escaping SwiftyTask) -> DispatchWorkItem {
        return _asyncDelay(seconds, SwiftyTask)
    }
    
    // MARK: 1.4、异步延迟回到主线程(子线程执行任务，然后回到主线程执行任务)
    /// 异步延迟回到主线程(子线程执行任务，然后回到主线程执行任务)
    /// - Parameter seconds: 延迟秒数
    /// - Parameter SwiftyTask: 延迟的block
    /// - Parameter mainSwiftyTask: 延迟的主线程block
    @discardableResult
    public static func asyncDelay(_ seconds: Double,
                                  _ SwiftyTask: @escaping SwiftyTask,
                                  _ mainSwiftyTask: @escaping SwiftyTask) -> DispatchWorkItem {
        return _asyncDelay(seconds, SwiftyTask, mainSwiftyTask)
    }
}

// MARK: - 私有的方法
extension SwiftyAsyncs {
    
    /// 延迟任务
    /// - Parameters:
    ///   - seconds: 延迟时间
    ///   - SwiftyTask: 任务
    ///   - mainSwiftyTask: 任务
    /// - Returns: DispatchWorkItem
    fileprivate static func _asyncDelay(_ seconds: Double,
                                        _ SwiftyTask: @escaping SwiftyTask,
                                        _ mainSwiftyTask: SwiftyTask? = nil) -> DispatchWorkItem {
        let item = DispatchWorkItem(block: SwiftyTask)
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + seconds,
                                          execute: item)
        if let main = mainSwiftyTask {
            item.notify(queue: DispatchQueue.main, execute: main)
        }
        return item
    }
}
