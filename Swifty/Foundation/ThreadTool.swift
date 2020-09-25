//
//  ThreadTool.swift
//  Swifty
//
//  Created by 王荣庆 on 2020/9/24.
//  Copyright © 2020 RyukieSama. All rights reserved.
//

import UIKit

///  debounce函数通常称为防抖动函数，该函数会从上一次被调用后，延迟 wait 秒后调用 fn 方法
class Debouncer {
    public let label: String
    public let interval: DispatchTimeInterval
    fileprivate let queue: DispatchQueue
    fileprivate let semaphore: DispatchSemaphoreWrapper
    fileprivate var workItem: DispatchWorkItem?
    
    
    public init(label: String, interval: Float, qos: DispatchQoS = .userInteractive) {
        self.interval         = .milliseconds(Int(interval * 1000))
        self.label         = label
        self.queue = DispatchQueue(label: "com.azizi.debouncer.internalqueue.\(label)", qos: qos)
        self.semaphore = DispatchSemaphoreWrapper(withValue: 1)
    }
    
    public func call(_ callback: @escaping (() -> ())) {
        self.semaphore.sync  { () -> () in
            self.workItem?.cancel()
            self.workItem = DispatchWorkItem {
                callback()
            }
            if let workItem = self.workItem {
                self.queue.asyncAfter(deadline: .now() + self.interval, execute: workItem)
            }
        }
    }
}


public struct DispatchSemaphoreWrapper {
    private let semaphore: DispatchSemaphore
    public init(withValue value: Int) {
        self.semaphore = DispatchSemaphore(value: value)
    }
    
    public func sync<R>(execute: () throws -> R) rethrows -> R {
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        defer { semaphore.signal() }
        return try execute()
    }
}


/// 节流函数，在 wait 秒内最多执行 fn 一次的函数。与deboucne不同的是，throttle会有一个阀值，当到达阀值时，fn一定会执行。
public class Throttler {
    private let queue: DispatchQueue = DispatchQueue.global(qos: .background)
    
    private var job: DispatchWorkItem = DispatchWorkItem(block: {})
    private var previousRun: Date = Date.distantPast
    private var maxInterval: Int
    fileprivate let semaphore: DispatchSemaphoreWrapper
    
    init(seconds: Int) {
        self.maxInterval = seconds
        self.semaphore = DispatchSemaphoreWrapper(withValue: 1)
    }
    
    
    func throttle(block: @escaping () -> ()) {
        self.semaphore.sync  { () -> () in
            job.cancel()
            job = DispatchWorkItem(){ [weak self] in
                self?.previousRun = Date()
                block()
            }
            let delay = Date.second(from: previousRun) > maxInterval ? 0 : maxInterval
            queue.asyncAfter(deadline: .now() + Double(delay), execute: job)
        }
    }
}

private extension Date {
    static func second(from referenceDate: Date) -> Int {
        return Int(Date().timeIntervalSince(referenceDate).rounded())
    }
}
