//
//  ScreenShieldView.swift
//  Swifty
//
//  Created by 王荣庆 on 2019/9/14.
//  Copyright © 2019 RyukieSama. All rights reserved.
//

#if !os(macOS)

import UIKit

@available(iOS 10.0, *)
public class ScreenShieldView: UIView {
    @objc
    public static func create(frame: CGRect = .zero) -> ScreenShieldView {
        return ScreenShieldView(frame: frame)
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        safeZone = makeSecureView() ?? UIView()
        
        if let sf = safeZone {
            addSubview(sf)
            
            let layoutDefaultLowPriority = UILayoutPriority(rawValue: UILayoutPriority.defaultLow.rawValue-1)
            let layoutDefaultHighPriority = UILayoutPriority(rawValue: UILayoutPriority.defaultHigh.rawValue-1)
            
            sf.translatesAutoresizingMaskIntoConstraints = false
            sf.setContentHuggingPriority(layoutDefaultLowPriority, for: .vertical)
            sf.setContentHuggingPriority(layoutDefaultLowPriority, for: .horizontal)
            sf.setContentCompressionResistancePriority(layoutDefaultHighPriority, for: .vertical)
            sf.setContentCompressionResistancePriority(layoutDefaultHighPriority, for: .horizontal)
            
            let top = NSLayoutConstraint.init(item: sf, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
            let bottom = NSLayoutConstraint.init(item: sf, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
            let leading = NSLayoutConstraint.init(item: sf, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
            let trailing = NSLayoutConstraint.init(item: sf, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
            
            self.addConstraints([top, bottom, leading, trailing])
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func addSubview(_ view: UIView) {
        guard
            let safe = safeZone,
            view != safeZone
        else {
            super.addSubview(view)
            return
        }
        safe.addSubview(view)
    }
    
    private func makeSecureView() -> UIView? {
        let field = UITextField()
        field.isSecureTextEntry = true
        let fv = field.subviews.first
        fv?.subviews.forEach { $0.removeFromSuperview() }
        fv?.isUserInteractionEnabled = true
        
        let errorMsg = "[ScreenShieldView log] Create safeZone failed!"
#if DEBUG
        precondition(fv != nil, errorMsg)
#else
        print(errorMsg)
#endif
        
        return fv
    }
    
    private var safeZone: UIView?
}

#endif
