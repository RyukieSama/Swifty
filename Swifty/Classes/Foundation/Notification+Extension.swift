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
    
    /// Easy post notification with default NotificationCenter
    /// - Parameters:
    ///   - notiString: notiString
    ///   - object: object
    ///   - userInfo: userInfo
    public static func post(notification notiString: String, object: Any? = nil, userInfo: [AnyHashable : Any]? = nil) {
        NotificationCenter.default.post(name: Notification.Name(notiString), object: object, userInfo: userInfo)
    }
    
    /// Add observer for notification
    /// - Parameters:
    ///   - observer: observer
    ///   - selector: selector
    ///   - notiString: notiString
    ///   - object: object
    public static func addObserver(_ observer: Any, selector: Selector, notification notiString: String, object: Any? = nil) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: Notification.Name(rawValue: notiString), object: object)
    }

    
    /// Add observer for muti notification
    /// - Parameters:
    ///   - observer: observer
    ///   - aSelector: aSelector
    ///   - notiStrings: notifications
    ///   - anObject: anObject
    public static func addObserver(_ observer: Any, selector aSelector: Selector, notifications notiStrings: [String], object anObject: Any? = nil) {
        notiStrings.forEach {
            NotificationCenter.default.addObserver(observer, selector: aSelector, name: Notification.Name(rawValue: $0), object: anObject)
        }
    }
}
