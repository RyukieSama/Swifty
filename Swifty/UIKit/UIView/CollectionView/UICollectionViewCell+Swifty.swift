//
//  UICollectionViewCell+Swifty.swift
//  Swifty
//
//  Created by 王荣庆 on 2019/9/8.
//  Copyright © 2019 RyukieSama. All rights reserved.
//

import UIKit

public protocol NibCollectionCellRegisterable: NibLoadable where Self: UICollectionViewCell {}

public extension Swifty where Base: UICollectionView {
    @discardableResult
    func registerNib<T>(isNib: Bool = true, cellTypes: T.Type...) -> Base where T: NibCollectionCellRegisterable {
        if isNib {
            cellTypes.forEach { base.register($0.nib, forCellWithReuseIdentifier: $0.identifier) }
        } else {
            cellTypes.forEach { base.register($0.self, forCellWithReuseIdentifier: $0.identifier) }
        }
        
        return base
    }
    
    func dequeueReusableCell<T>(for indexPath: IndexPath) -> T where T: UICollectionViewCell & Identifiable {
        return base.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}


