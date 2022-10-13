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
        return SwiftyFullScreen.canFullScreen ? [.all] : [.portrait]
    }
}

@available(iOSApplicationExtension, unavailable)
public extension Swifty where Base: UIViewController {
    /// 开启横竖屏 Enable fullscreen
    func needFullScreen() {
        isAllowFullScreen = true
    }
    
    func enterFullScreen() {
        guard #available(iOS 16.0, *) else {
            UIDevice.current.setValue(UIDeviceOrientation.landscapeLeft.rawValue, forKey: "orientation")
            return
        }
        switchMode(full: true)
    }
    
    func exitFullScreen() {
        guard #available(iOS 16.0, *) else {
            UIDevice.current.setValue(UIDeviceOrientation.portrait.rawValue, forKey: "orientation")
            return
        }
        switchMode(full: false)
    }
    
    @available(iOS 16.0, *)
    private func switchMode(full: Bool) {
        guard
            let scence = UIApplication.shared.connectedScenes.first as? UIWindowScene
        else {
            return
        }
        let orientation: UIInterfaceOrientationMask = full ? .landscape : .portrait
        let geometryPreferencesIOS = UIWindowScene.GeometryPreferences.iOS(interfaceOrientations: orientation)
        scence.requestGeometryUpdate(geometryPreferencesIOS) { error in
        }
    }
    
    func disableFullScreen() {
        isAllowFullScreen = false
    }
}


#endif
