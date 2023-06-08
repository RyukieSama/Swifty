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
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    public var fromUTF8String: String? {
        let tempStr1 = replacingOccurrences(of: "\\u", with: "\\U")
        let tempStr2 = tempStr1.replacingOccurrences(of: "\"", with: "\\\"")
        let tempStr3 = "\"".appending(tempStr2).appending("\"")
        guard
            let tempData = tempStr3.data(using: String.Encoding.utf8),
                var returnStr = try? PropertyListSerialization.propertyList(from: tempData, options: [.mutableContainers], format: nil) as? String
        else {
            return nil
        }
        return returnStr.replacingOccurrences(of: "\\r\\n", with: "\n")
    }
    
}

#endif
