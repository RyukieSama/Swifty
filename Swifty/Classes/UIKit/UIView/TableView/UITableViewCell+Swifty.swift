//
//  UITableViewCell+Swifty.swift
//  Swifty
//
//  Created by 王荣庆 on 2019/9/8.
//  Copyright © 2019 RyukieSama. All rights reserved.
//

#if !os(macOS)

import UIKit

public protocol TableCellRegisterable: NibLoadable where Self: UITableViewCell {}

public extension Swifty where Base: UITableView {
    func reloadWithouAnimation() {
        UIView.performWithoutAnimation {
            self.base.reloadData()
        }
    }
    
    @discardableResult
    func register(isNib: Bool = false, cellTypes: TableCellRegisterable.Type...) -> Base {
        if isNib {
            cellTypes.forEach { base.register($0.nib, forCellReuseIdentifier: $0.identifier) }
        } else {
            cellTypes.forEach { base.register($0.self, forCellReuseIdentifier: $0.identifier) }
        }
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


#endif
