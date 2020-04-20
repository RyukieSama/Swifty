//
//  UICollectionViewCell+Swifty.swift
//  Swifty
//
//  Created by 王荣庆 on 2019/9/8.
//  Copyright © 2019 RyukieSama. All rights reserved.
//

import UIKit

public protocol CollectionCellRegisterable: NibLoadable where Self: UICollectionViewCell {}

public protocol CollectionReuseViewRegisterable: Identifiable where Self: UIView {}

public extension Swifty where Base: UICollectionView {
    @discardableResult
    func register<T>(isNib: Bool = true, cellTypes: T.Type...) -> Base where T: CollectionCellRegisterable {
        if isNib {
            cellTypes.forEach { base.register($0.nib, forCellWithReuseIdentifier: $0.identifier) }
        } else {
            cellTypes.forEach { base.register($0.self, forCellWithReuseIdentifier: $0.identifier) }
        }
        
        return base
    }
    
    @discardableResult
    func register<T>(headerTypes: T.Type...) -> Base where T: CollectionReuseViewRegisterable {
        headerTypes.forEach {
            base.register($0.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: $0.identifier)
        }
        return base
    }
    
    func dequeueReusableCell<T>(for indexPath: IndexPath) -> T where T: UICollectionViewCell & Identifiable {
        return base.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
    
    func dequeueReusableView<T>(for kind: String, indexPath: IndexPath) -> T where T: CollectionReuseViewRegisterable {
        return base.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
}


