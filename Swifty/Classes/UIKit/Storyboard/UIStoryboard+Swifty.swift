//
//  UIStoryboard+Swifty.swift
//  Swifty
//
//  Created by 王荣庆 on 2019/9/8.
//  Copyright © 2019 RyukieSama. All rights reserved.
//

#if !os(macOS)

import UIKit

extension UIStoryboard: SwiftyCompatible {}

public protocol StoryboardInitializable: Identifiable {}

public extension Swifty where Base: UIStoryboard {
     func controller<T>(_ controllerType: T.Type) -> T where T: StoryboardInitializable {
        guard let controller = base.instantiateViewController(withIdentifier: T.identifier) as? T else {
            fatalError("Couldn't instantiate view controlelr with identifier \(T.identifier)")
        }
        return controller
    }
}

#endif
