//
//  UITableViewCell+Swifty.swift
//  Swifty
//
//  Created by 王荣庆 on 2019/9/8.
//  Copyright © 2019 RyukieSama. All rights reserved.
//

import UIKit

public protocol NibTableCellRegisterable: NibLoadable where Self: UITableViewCell {}

public extension Swifty where Base: UITableView {
    @discardableResult
    func registerNib<T>(cellTypes: T.Type...) -> Base where T: NibTableCellRegisterable {
        cellTypes.forEach { base.register($0.nib, forCellReuseIdentifier: $0.identifier) }
        return base
    }
    
    @discardableResult
    func register<T>(cellTypes: T.Type...) -> Base where T: Identifiable & UITableViewCell {
        cellTypes.forEach { base.register($0.self, forCellReuseIdentifier: $0.identifier) }
        return base
    }
    
    func dequeueReusableCell<T>(for indexPath: IndexPath? = nil) -> T where T: UITableViewCell & Identifiable {
        if let index = indexPath {
            return base.dequeueReusableCell(withIdentifier: T.identifier, for: index) as! T
        } else {
            return base.dequeueReusableCell(withIdentifier: T.identifier) as! T
        }
    }
}

