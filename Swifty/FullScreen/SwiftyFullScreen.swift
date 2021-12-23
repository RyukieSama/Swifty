//
//  SwiftyFullScreen.swift
//  Swifty
//
//  Created by 王荣庆 on 2021/12/23.
//

import UIKit

private var isAllowFullScreen = false

public struct SwiftyFullScreen {
    static var canFullScreen: Bool { isAllowFullScreen }
}

extension UIApplication: SwiftyCompatible {}

public extension Swifty where Base: UIApplication {
    var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return SwiftyFullScreen.canFullScreen ? [.portrait, .landscape] : [.portrait]
    }
}

extension UIViewController: SwiftyCompatible {}

public extension Swifty where Base: UIViewController {
    public func needFullScreen() {
        isAllowFullScreen = true
    }
    
    public func enterFullScreen() {
        var deviceOrientation: UIDeviceOrientation = .landscapeLeft
        UIDevice.current.setValue(deviceOrientation.rawValue, forKey: "orientation")
    }
    
    public func exitFullScreen() {
        UIDevice.current.setValue(UIDeviceOrientation.portrait.rawValue, forKey: "orientation")
    }
    
    public func disableFullScreen() {
        isAllowFullScreen = false
    }
}
