//
//  UINib+Swifty.swift
//  Swifty
//
//  Created by 王荣庆 on 2019/9/8.
//  Copyright © 2019 RyukieSama. All rights reserved.
//

import UIKit

// MARK: - NibLoadable
public protocol NibLoadable: class, Identifiable {
    static var nibName: String { get }
    static var nib: UINib { get }
}

public extension NibLoadable {
    static var nibName: String {
        return identifier
    }
    
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
}

public extension NibLoadable where Self: UIView {
    static var loadFromNib: Self {
        guard let view = Self.nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("Could not load view from nib: \(Self.nibName)")
        }
        return view
    }
}

//public extension Swifty where Base: NibLoadable {
//    static var loadFromNib: Base {
//        guard let view = Base.nib.instantiate(withOwner: self, options: nil).first as? Base else {
//            fatalError("Could not load view from nib: \(Base.nibName)")
//        }
//        return view
//    }
//}
