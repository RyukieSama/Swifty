//
//  SwiftyFullScreen.swift
//  Swifty
//
//  Created by 王荣庆 on 2021/12/23.
//

#if !os(macOS)

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

public extension Swifty where Base: UIViewController {
    func needFullScreen() {
        isAllowFullScreen = true
    }
    
    func enterFullScreen() {
        let deviceOrientation: UIDeviceOrientation = .landscapeLeft
        UIDevice.current.setValue(deviceOrientation.rawValue, forKey: "orientation")
    }
    
    func exitFullScreen() {
        UIDevice.current.setValue(UIDeviceOrientation.portrait.rawValue, forKey: "orientation")
    }
    
    func disableFullScreen() {
        isAllowFullScreen = false
    }
}

#endif
