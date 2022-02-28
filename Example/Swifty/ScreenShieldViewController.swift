//
//  ScreenShieldViewController.swift
//  Swifty_Example
//
//  Created by 王荣庆 on 2022/2/24.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import RyukieSwifty

class ScreenShieldViewController: UIViewController {
    
    override func loadView() {
        if #available(iOS 13.0, *) {
            view = ScreenShieldView.create()
        }
        else {
            super.loadView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let cube = UIView()
        cube.backgroundColor = .red
        cube.frame = CGRect(x: 200, y: 200, width: 100, height: 100)
        
        view.addSubview(cube)
        
        view.backgroundColor = .gray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
