//
//  SwiftyDefine.swift
//  Swifty
//
//  Created by 王荣庆 on 2019/9/14.
//  Copyright © 2019 RyukieSama. All rights reserved.
//

import UIKit

public struct SwiftyDefine {
    
    public struct Device {
        public static var screenWidth: CGFloat {
            return UIScreen.main.bounds.width
        }
        
        public static var screenHeight: CGFloat {
            return UIScreen.main.bounds.height
        }
        
        public static var screenBounds: CGRect {
            return UIScreen.main.bounds
        }
        
        public static var screenSize: CGSize {
            return UIScreen.main.bounds.size
        }
        
        public static var navigationHeight: CGFloat {
            return isIphoneXSeries == true ? 88 : 64
        }
        
        /// iOS 13 present 风格出来的导航条高度
        public static var navigationSmallHeight: CGFloat {
            return 44
        }
        
        /// is X series
        public static var isIphoneXSeries: Bool {
            return UIScreen.main.bounds.height >= 812
        }
        
        /// is Plus Device
        public static var isPlusStyle: Bool {
            return UIScreen.main.bounds.height == 736
        }
        
        /// is 6s size
        public static var isIphone6sStyle: Bool {
            return UIScreen.main.bounds.height == 667
        }
        
        /// is 5 size
        public static var isIphone5Style: Bool {
            return UIScreen.main.bounds.height == 568
        }
        
        /// is 4 size
        public static var isIphone4Style: Bool {
            return UIScreen.main.bounds.height == 480
        }
        
        /// Device Name
        public static var deviceName: String {
            return UIDevice.current.name
        }
        
        /// isSimulator
        public static var isSimulator: Bool {
            #if arch(i386) || arch(x86_64)
            return true
            #endif
            return false
        }
    }
    
    public struct App {
        public static var keyWindow: UIWindow? {
            return UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        }
        
        public static var version: String? {
            return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        }
        
        public static var build: String? {
            return Bundle.main.infoDictionary?["CFBundleVersion"] as? String
        }
        
        public static var name: String? {
            return Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
        }
    }
    
}
