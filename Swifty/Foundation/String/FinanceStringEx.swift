//
//  SwiftyStringEx.swift
//  Swifty
//
//  Created by Roible on 2018/1/20.
//  Copyright © 2018年 RyukieSama. All rights reserved.
//

#if !os(macOS)

import UIKit

extension String {
    /// 金额 带单位
    ///
    /// - Returns: attributedText 单位字体变小
    public func amountAttributed() -> NSAttributedString {
        let a = NSMutableAttributedString(string: self)
        let range1 = NSRange.init(location: 0, length: self.count-1)
        a.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 18), range: range1)
        let range2 = NSRange.init(location: self.count-1, length: 1)
        a.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 18), range: range2)
        return a
    }
    
    public var decodeUrl: String? {
        return removingPercentEncoding
    }
    
    public var encodeUrl : String? {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
    
}

#endif
