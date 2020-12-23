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
    
    public static func show(title: String? = nil, message: String? = nil, image: String? = nil, dismissTitle: String? = nil, dismissAfter: TimeInterval = 0, from: UIViewController? = nil) {
        
        func doSomething() {
            var titleString = title
            if let _ = image {
                titleString = ("\n\n\n\n\n" + (title ?? ""))
            }
            let vc = EasyToastViewController(title: titleString, message: message, preferredStyle: .alert)
            
            if #available(iOS 13.0, *) {
                if
                    let imageName = image,
                    let centerImage = UIImage.systemImage(name: imageName, font: .systemFont(ofSize: 100, weight: .regular)) {
                    vc.imageView.image = centerImage
                }
            } else {
                // Fallback on earlier versions
            }
            
            if dismissTitle?.count ?? 0 > 0 {
                vc.addAction(UIAlertAction(title: dismissTitle, style: .cancel, handler: nil))
            }
            
            alertVc = vc
            
            let controller = from != nil ? from : EasyToastTopViewController()
            
            DispatchQueue.main.async {
                controller?.present(vc, animated: true, completion: {
                })
            }
            if dismissAfter > 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + dismissAfter) {
                    dismiss()
                }
            }
        }
        
        if alertVc != nil {
            alertVc?.dismiss(animated: false, completion: {
                doSomething()
            })
        }
        else {
            doSomething()
        }
    }
}

private class EasyToastViewController: UIAlertController {
    // MARK: - Life
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Function-Public
    var blankDismiss: Bool = true
    
    // MARK: - Function-Private
    
    // MARK: UI
    private func setupUI() {
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if #available(iOS 13.0, *) {
            imageView.tintColor = .label
        } else {
            imageView.tintColor = .black
        }
        let fm = CGRect(x: (view.frame.width - 100) / 2.0, y: 20, width: 100, height: 100)
        imageView.frame = fm
        imageView.isHidden = imageView.image == nil
    }
    
    var imageView: UIImageView = UIImageView()
    
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
