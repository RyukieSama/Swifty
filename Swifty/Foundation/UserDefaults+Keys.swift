//
//  UserDefaults+Keys.swift
//  RYLei
//
//  Created by 王荣庆 on 2019/12/15.
//  Copyright © 2019 RyukieSama. All rights reserved.
//

import Foundation

public extension UserDefaults {
    static func save(value: Any?, key: UserDefaultsKeysProtocol) {
        if value == nil { return }
        UserDefaults.standard.setValue(value, forKey: key.key)
    }
    
    static func get<T>(key: UserDefaultsKeysProtocol) -> T? {
        return UserDefaults.standard.value(forKey: key.key) as? T
    }
    
    static func delete(key: UserDefaultsKeysProtocol) {
        UserDefaults.standard.removeObject(forKey: key.key)
    }
    
    static func synchronize() {
        UserDefaults.standard.synchronize()
    }
}

public protocol UserDefaultsKeysProtocol {
    var key: String { get }
}

public extension UserDefaultsKeysProtocol {
    var key: String {
        return "\(Self.self)-\(self)"
    }
}
