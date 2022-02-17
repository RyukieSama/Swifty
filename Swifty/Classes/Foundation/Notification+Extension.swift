//
//  Notification+Extension.swift
//  Swifty
//
//  Created by 王荣庆 on 2020/1/10.
//  Copyright © 2020 Swifty. All rights reserved.
//

import Foundation

public protocol NotificationNameProtocol: RawRepresentable {
}

public extension NotificationNameProtocol where Self.RawValue == String {
    var key: String {
        return "Notification_\(self)_" + rawValue
    }
}

extension NotificationCenter {
    /// 快速发送通知
    /// - Parameters:
    ///   - notiString: 通知String
    ///   - anObject: 对象
    ///   - aUserInfo: UserInfo
    public static func post(notification notiString: String, object anObject: Any? = nil, userInfo aUserInfo: [AnyHashable : Any]? = nil) {
        NotificationCenter.default.post(name: Notification.Name(notiString), object: anObject, userInfo: aUserInfo)
    }
    
    /// 快速添加通知
    /// - Parameters:
    ///   - observer: 观察者
    ///   - aSelector: selector
    ///   - notiString: 通知String
    ///   - anObject: 对象
    public static func addObserver(_ observer: Any, selector aSelector: Selector, notification notiString: String, object anObject: Any? = nil) {
        NotificationCenter.default.addObserver(observer, selector: aSelector, name: Notification.Name(rawValue: notiString), object: anObject)
    }
}
