//
//  FullScreenViewController.swift
//  Swifty_Example
//
//  Created by 王荣庆 on 2022/10/12.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import RyukieSwifty

class FullScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Life
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        swifty.exitFullScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        swifty.needFullScreen()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        // 设备方向变化通知在iOS16中无法触发，但下列方法仍然会触发
        if size.width > size.height {
            switchButton.isSelected = true
        } else {
            switchButton.isSelected = false
        }
    }
    // MARK: - Function-Public
    
    // MARK: - Function-Private
    
    // MARK: UI
    private func setupUI() {
        view.backgroundColor = .white
        
        switchButton
            .added(to: view)
            .layout { make in
                make?.center.equalToSuperview()
            }
    }
    
    // MARK: Buiness
    
    // MARK: Action
    @objc
    private func switchAction() {
        switchButton.isSelected ? swifty.exitFullScreen() : swifty.enterFullScreen()
    }
    
    // MARK: Request
    
    // MARK: - VarLet-Public
    
    // MARK: - VarLet-Private
    private lazy var switchButton: UIButton = {
        return UIButton()
            .config {
                $0.setTitleColor(.black, for: .normal)
                $0.setTitle("切换为横屏", for: .normal)
                $0.setTitle("切换为竖屏", for: .selected)
                $0.addTarget(self, action: #selector(switchAction), for: .touchUpInside)
            }
    }()
}

extension AppDelegate {
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return application.swifty.supportedInterfaceOrientations
    }
}

