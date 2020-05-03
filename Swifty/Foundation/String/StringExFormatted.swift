//
//  StringExFormatted.swift
//  Swifty
//
//  Created by RyukieSama on 2018/1/30.
//  Copyright © 2018年 RyukieSama. All rights reserved.
//

import Foundation

// MARK: - Formatted
extension String {
    public func amountFormatted(_ decimals: Int = 2) -> (origin: String, formatted: String)? {
        guard self.count > 0 else {
            return (self, self)
        }
        
        var string = self
        var prefix = ""
        if self.first == "-" {
            prefix = "-"
            string.remove(at: string.startIndex)
            guard string.count > 0 else {
                return (self, self)
            }
        }

        var tuple: (String, String) = ("", "")
        for char in string {
            guard let result = String(char).amountFormattedSingle(with: tuple.0, decimals: decimals) else {
                return nil
            }
            tuple = result
        }
        
        tuple.0 = prefix + tuple.0
        tuple.1 = prefix + tuple.1
        return tuple
    }
    
    public func amountFormattedSingle(with text: String, decimals: Int = 2) -> (origin: String, formatted: String)? {
        var text = text
        
        guard self.count <= 1 else {
            //only for one charater
            return nil
        }
        guard self._validate() else {
            //只允许输入0-9的数字，和小数点，和空字符串（空字符串代表删除）
            return nil
        }
        if text.contains(".") && self == "." {
            //确保只能输入一个小数点
            return nil
        }
        if text == "0" && self != "." {
            //当前是0的时候，用户输入什么都直接把0替换掉, 除非用户输入小数点，那就是 0.
            return (self, self)
        }
        if text.count == 0  {
            //用户一开始就输入一个小数点，要设置成 0., 否则直接返回输入值
            let result = ((self == "." ? "0" : "") + self)
            return (result, result)
        }
        
        if self == "" {
            //用户要删除
            text.removeLast()
            if text.count == 0 {return (text, text)} //如果全删了，直接返回，不需去格式化了
        } else if text.count >= decimals + 1 && text[text.index(text.endIndex, offsetBy: -(decimals + 1))] == "." {
            //倒数第三位是小数点
            //例如现在 _amountText = 2300.14, 用户再输入5, 则 _amountText 不能再继续增加下去，只能变成 2300.15
            text.removeLast()
            text += self
        } else {
            text += self
        }
        
        let formatter = NumberFormatter()
        if let softFomat = text._softFormat(decimals) {
            formatter.positiveFormat = softFomat
        } else {
            formatter.positiveFormat = text._hardFormat(decimals)
        }
        
        guard let value = Double(text) else {
            return nil
        }
        guard let formatted = formatter.string(from: NSNumber(value: value)) else {
            return nil
        }
        return (text, formatted)
    }
    
    private func _validate() -> Bool {
        return ["0","1","2","3","4","5","6","7","8","9",".",""].contains(self)
    }
    
    private func _softFormat(_ decimals: Int = 2) -> String? {
        if decimals == 0 {
            return "###,##0"
        }
        
        for i in 1...decimals {
            if self.count >= i && self[self.index(self.endIndex, offsetBy: -i)] == "." {
                //最后一位是[.] 例如[2,300.], format 就是 ###,##0.
                //倒数第二位是[.], 例如[2,300.1], format 就是 ###,##0.0
                //... 以此类推
                var format = "###,##0."
                for _ in 1..<i {
                    format += "0"
                }
                return format
            }
        }
        return nil
    }
    
    private func _hardFormat(_ decimals: Int = 2) -> String {
        if self.contains(".") {
            //包含[.], 但. 不在倒数第一位或者倒数第二位，一律格式化为 [2,300.14]
            var format = "###,##0."
            for _ in 1...decimals {
                format += "0"
            }
            return format
        }
        return "###,##0"
    }
}
