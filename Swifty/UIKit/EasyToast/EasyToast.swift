//
//  EasyToast.swift
//  RYLei
//
//  Created by 王荣庆 on 2019/11/26.
//  Copyright © 2019 RyukieSama. All rights reserved.
//

import UIKit

public class EasyToast {
    private static var alertVc: EasyToastViewController?
    
    public static func dismiss() {
        if alertVc != nil {
            alertVc?.dismiss(animated: true, completion: nil)
            alertVc = nil
        }
    }
    
    public static func show(title: String? = nil, message: String? = nil, dismissTitle: String? = nil, dismissAfter: TimeInterval = 0) {
        if alertVc != nil {
            dismiss()
        }
        let vc = EasyToastViewController(title: title, message: message, preferredStyle: .alert)
        
        if dismissTitle?.count ?? 0 > 0 {
            vc.addAction(UIAlertAction(title: dismissTitle, style: .cancel, handler: nil))
        }
        
        alertVc = vc
        
        DispatchQueue.main.async {
            EasyToastTopViewController()?.present(vc, animated: true, completion: {
            })
        }
        if dismissAfter > 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + dismissAfter) {
                dismiss()
            }
        }
    }
}

private class EasyToastViewController: UIAlertController {
    // MARK: - Life
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Function-Public
    var blankDismiss: Bool = true
    
    // MARK: - Function-Private
    
    // MARK: UI
    private func setupUI() {
        
    }
}

private func EasyToastTopViewController(base: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
    if let nav = base as? UINavigationController {
        return EasyToastTopViewController(base: nav.visibleViewController)
    }
    if let tab = base as? UITabBarController {
        return EasyToastTopViewController(base: tab.selectedViewController)
    }
    if let presented = base?.presentedViewController {
        return EasyToastTopViewController(base: presented)
    }
    return base
}
