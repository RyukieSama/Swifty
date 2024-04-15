//
//  UITextField+Swifty.swift
//  Swifty
//
//  Created by 王荣庆 on 2019/11/14.
//  Copyright © 2019 RyukieSama. All rights reserved.
//

#if !os(macOS)

import UIKit

public extension Swifty where Base: UITextField {
    // MARK: 3.1、限制字数的输入(提示在：- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string; 里面调用)
    /// 限制字数的输入
    /// - Parameters:
    ///   - range: 范围
    ///   - text: 输入的文字
    ///   - maxCharacters: 限制字数
    ///   - regex: 可输入内容(正则)
    ///   - isInterceptString: 复制文字进来，在字数限制的情况下，多余的字体是否截取掉，默认true
    /// - Returns: 返回是否可输入
    func inputRestrictions(shouldChangeTextIn range: NSRange, replacementText text: String, maxCharacters: Int, regex: String?, isInterceptString: Bool = true) -> Bool {
        guard !text.isEmpty else {
            return true
        }
        guard let oldContent = self.base.text else {
            return false
        }
        if let markedTextRange = self.base.markedTextRange {
             // 有高亮
            if range.length == 0 {
                // 联想中
                return oldContent.count + 1 <= maxCharacters
            } else {
                // 正则的判断
                if let weakRegex = regex, !RegexHelper.match(text, pattern: weakRegex) {
                    return false
                }
                let markedRange = rangeFromTextRange(textRange: markedTextRange)
                // 联想选中键盘
                let allContent = oldContent.swifty.replacingCharacters(range: markedRange) + text
                if allContent.count > maxCharacters  {
                    let newContent = allContent.swifty.sub(to: maxCharacters)
                    // print("content1：\(allContent) content2：\(newContent)")
                    self.base.text = newContent
                    return false
                }
            }
        } else {
            guard !text.swifty.isNineKeyBoard() else {
                return true
            }
            // 正则的判断
            if let weakRegex = regex, !RegexHelper.match(text, pattern: weakRegex) {
                return false
            }
            // 2、如果数字大于指定位数，不能输入
            guard oldContent.count + text.count <= maxCharacters else {
                if oldContent.count < maxCharacters {
                    let remainingLength = maxCharacters - oldContent.count
                    let copyString = text.swifty.removeBeginEndAllSapcefeed
                    // print("范围：\(range) copy的字符串：\(copyString) 长度：\(copyString.count)  截取的字符串：\(copyString.jk.sub(to: remainingLength))")
                    // 可以插入字符串
                    let replaceContent = copyString.swifty.sub(to: remainingLength)
                    // let newString = oldContent.jk.insertString(content: replaceContent), locat: range.location)
                    let newString = oldContent.swifty.replacingCharacters(range: range, replacingString: replaceContent)
                    // print("老的字符串：\(oldContent) 新的的字符串：\(newString) 长度：\(newString.count)")
                    self.base.text = newString
                    // 异步改变
                    SwiftyAsyncs.asyncDelay(0.5) {} _: {
                        if let selectedRange = self.base.selectedTextRange {
                            if let newPosition = self.base.position(from: selectedRange.start, offset: remainingLength) {
                                self.base.selectedTextRange = self.base.textRange(from: newPosition, to: newPosition)
                            }
                        }
                    }
                }
                return false
            }
        }
        return true
    }
    
    /// UITextRange 转 NSRange
    /// - Parameter textRange: UITextRange对象
    /// - Returns: NSRange
    private func rangeFromTextRange(textRange: UITextRange) -> NSRange {
        let location: Int = self.base.offset(from: self.base.beginningOfDocument, to: textRange.start)
        let length: Int = self.base.offset(from: textRange.start, to: textRange.end)
        return NSMakeRange(location, length)
    }
}

#endif
