//
//  StringEx.swift
//  sgj
//
//  Created by roy on 2017/11/16.
//  Copyright © 2017年 feidee. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Date formate
extension String {
    // MARK: - 3.时间转时间戳 "yyyy.MM.dd HH:mm:ss"
    public var dateStampOfDotInterval_yyMMdd: Int? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
        
        if let date = formatter.date(from: self) {
            return Int(date.timeIntervalSince1970)
        }
        
        return nil
    }
    
    public var urlEncodingHostAllowed: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
}

// MARK: - Convenience
extension String {
    public func contains(_ string: String) -> Bool {
        return self.range(of: string) != nil
    }
    
    public var float: Float {
        return (self as NSString).floatValue
    }
    
    public var cgFloat: CGFloat {
        return CGFloat((self as NSString).floatValue)
    }
    
    public var int: Int64 {
        return Int64((self as NSString).integerValue)
    }
    
    public var doubleValueFromFormatted: Double? {
        return Double(self.replacingOccurrences(of: ",", with: ""))
    }
    
    // 非空（长度大于0）对象
    public var nonempty: String? {
        return isEmpty ? nil : self
    }
    
    // 隐式显示（含蓄的表达） 15612062012 -> 156****2012 :目前只对邮箱跟电话有效
    public var implicitExpression: String {
        // 如果是电话
        if RegularExpressionValidate.phoneNum(self).isMatched {
            return self.prefix(3) + "****" + self.suffix(4)
        } else if RegularExpressionValidate.email(self).isMatched {
            guard let index = self.index(of: "@") else { return self }
            return self.prefix(upTo: index).prefix(3) + "*" + self.suffix(from: index)
        }
        
        return self
    }
}

// MARK: GBK
extension String {
    /// 用GBK编码时的长度
    public var gbkLength: Int {
        let cfEncoding = CFStringEncodings.GB_18030_2000
        let encoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(cfEncoding.rawValue))
        let gbkData = (self as NSString).data(using: encoding)!
        let gbkBytes = [UInt8](gbkData)
        return gbkBytes.count
    }
    
    /** 按GBK编码后，截取maxLen长度的字符，中文字符切不开则退避1个字节 */
    public func trimToGBKLength(_ maxLen: Int) -> String {
        let string = self.replacingOccurrences(of: " ", with: "")
        let cfEncoding = CFStringEncodings.GB_18030_2000
        let encoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(cfEncoding.rawValue))
        let gbkData = (string as NSString).data(using: encoding)!
        let gbkBytes = [UInt8](gbkData)
        if maxLen >= gbkBytes.count {
            return string
        } else if maxLen < 1 {
            return ""
        } else {
            if let str = NSString(data: gbkData[0..<maxLen], encoding: encoding) {
                return str as String
            } else if let str = NSString(data: gbkData[0..<maxLen - 1], encoding: encoding) {
                return str as String
            } else {
                return ""
            }
        }
    }
}

extension String {
    /// 十六进制转十进制
    /// - Returns: 十进制
    public func hexToDecimal() -> Int {
        var sum:Int = 0
        let str = uppercased()
        for i in str.utf8 {
            //0-9：从48开始
            sum = sum * 16 + Int(i) - 48
            //A-Z：从65开始
            if i >= 65 {
                sum -= 7
            }
        }
        return sum
    }
}
