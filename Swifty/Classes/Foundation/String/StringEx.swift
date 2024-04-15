//
//  StringEx.swift
//  Swifty
//
//  Created by wrq on 2017/11/16.
//  Copyright © 2017年 swifty. All rights reserved.
//

import Foundation

extension String: SwiftyCompatible {}

// MARK: - 1. Date
public extension Swifty where Base == String {
    // MARK: 1.1 时间转时间戳 "yyyy.MM.dd HH:mm:ss"
    var dateStampOfDotInterval_yyMMdd: Int? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
        
        if let date = formatter.date(from: base) {
            return Int(date.timeIntervalSince1970)
        }
        
        return nil
    }
}

//MARK: - 2. Encode
public extension Swifty where Base == String {
    //MARK: 2.1
    var urlEncodingHostAllowed: String? {
        return base.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    }
    
    //MARK: 2.2 用GBK编码时的长度
    var gbkLength: Int {
        let cfEncoding = CFStringEncodings.GB_18030_2000
        let encoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(cfEncoding.rawValue))
        let gbkData = (base as NSString).data(using: encoding)!
        let gbkBytes = [UInt8](gbkData)
        return gbkBytes.count
    }
    
    //MARK: 2.3 按GBK编码后，截取maxLen长度的字符，中文字符切不开则退避1个字节
    func trimToGBKLength(_ maxLen: Int) -> String {
        let string = base.replacingOccurrences(of: " ", with: "")
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

// MARK: - 3. Number
public extension Swifty where Base == String {
    //MARK: 3.1 contains
    func contains(_ string: String) -> Bool {
        return base.range(of: string) != nil
    }
    
    //MARK: 3.2 float
    var float: Float {
        return (base as NSString).floatValue
    }
    
    //MARK: 3.3 CGFloat
    var cgFloat: CGFloat {
        return CGFloat((base as NSString).floatValue)
    }
    
    //MARK: 3.4 Int64
    var int: Int {
        return (base as NSString).integerValue
    }
    
    //MARK: 3.5 Int64
    var int64: Int64 {
        return (base as NSString).longLongValue
    }
    
    //MARK: 3.6
    var doubleValueFromFormatted: Double? {
        return Double(base.replacingOccurrences(of: ",", with: ""))
    }
    
    //MARK: 3.7 隐式显示（含蓄的表达） 15612062012 -> 156****2012 :目前只对邮箱跟电话有效
    var implicitExpression: String {
        // 如果是电话
        if RegularExpressionValidate.phoneNum(base).isMatched {
            return base.prefix(3) + "****" + base.suffix(4)
        } else if RegularExpressionValidate.email(base).isMatched {
            guard let index = base.firstIndex(of: "@") else { return base }
            return base.prefix(upTo: index).prefix(3) + "*" + base.suffix(from: index)
        }
        return base
    }
    
    //MARK: 3.7 十六进制转十进制
    func hexToDecimal() -> Int {
        var sum:Int = 0
        let str = base.uppercased()
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
    
    //MARK: 3.8 判断是不是九宫格键盘
    func isNineKeyBoard() -> Bool {
        let other: NSString = "➋➌➍➎➏➐➑➒"
        let len = (base).count
        for _ in 0..<len {
            if !(other.range(of: base).location != NSNotFound) {
                return false
            }
        }
        return true
    }
}

//MARK: - 4. Range
public extension Swifty where Base == String {
    //MARK: 4.1 字符串指定range替换
    /// 字符串指定range替换
    /// - Parameters:
    ///   - range: range
    ///   - replacingString: 指定范围内新的字符串
    /// - Returns: 返回新的字符串
    func replacingCharacters(range: NSRange, replacingString: String = "") -> String {
        return ((base) as NSString).replacingCharacters(in: range, with: replacingString)
    }

    // MARK: 4.2 截取字符串从开始到 index
    /// 截取字符串从开始到 index
    /// - Parameter index: 截取到的位置
    /// - Returns: 截取后的字符串
    func sub(to index: Int) -> String {
        let end_Index = validIndex(original: index)
        return String((base)[(base).startIndex ..< end_Index])
    }
    
    // MARK: 4.3 校验字符串位置是否合理，并返回String.Index
    /// 校验字符串位置是否合理，并返回String.Index
    /// - Parameter original: 位置
    /// - Returns: String.Index
    func validIndex(original: Int) -> String.Index {
        switch original {
        case ...(base).startIndex.utf16Offset(in: base):
            return (base).startIndex
        case (base).endIndex.utf16Offset(in: base)...:
            return (base).endIndex
        default:
            return (base).index((base).startIndex, offsetBy: original > (base).count ? (base).count : original)
        }
    }
}

//MARK: - 5. Space Enter
public extension Swifty where Base == String {
    // MARK: 5.1、去除字符串前后的 空格
    /// 去除字符串前后的 空格
    var removeBeginEndAllSapcefeed: String {
        let resultString = (base as! String).trimmingCharacters(in: CharacterSet.whitespaces)
        return resultString
    }

}
