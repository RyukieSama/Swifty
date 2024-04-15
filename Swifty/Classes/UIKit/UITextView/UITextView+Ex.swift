//
//  UITextView+Ex.swift
//  RyukieSwifty
//
//  Created by wrq on 2024/4/15.
//

#if !os(macOS)

import UIKit

public extension Swifty where Base: UITextView {
    // MARK: 限制字数的输入(可配置正则)(提示在：- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;方法里面调用)
    /// 限制字数的输入(可配置正则)
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
                // 联想选中键盘
                let markedRange = rangeFromTextRange(textRange: markedTextRange)
                // 联想选中键盘
                let allContent = oldContent.swifty.replacingCharacters(range: markedRange) + text
                if allContent.count > maxCharacters  {
                    let newContent = allContent.swifty.sub(to: maxCharacters)
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
            // print("没有range---------：NO 内容：\(oldContent) 长度：\(oldContent.count) 新的内容：\(text) 长度：\(text.count) range：\(range)")
            // 2、如果数字大于指定位数，不能输入
            guard oldContent.count + text.count <= maxCharacters else {
                // 判断字符串是否要截取
                guard isInterceptString else {
                    // 不截取，也就是不让输入进去
                    return false
                }
                if oldContent.count < maxCharacters {
                    let remainingLength = maxCharacters - oldContent.count
                    let copyString = text.swifty.removeBeginEndAllSapcefeed
                    // print("范围：\(range) copy的字符串：\(copyString) 长度：\(copyString.count)  截取的字符串：\(copyString.swifty.sub(to: remainingLength))")
                    // 可以插入字符串
                    let replaceContent = copyString.swifty.sub(to: remainingLength)
                    // let newString = oldContent.swifty.insertString(content: replaceContent, locat: range.location)
                    let newString = oldContent.swifty.replacingCharacters(range: range, replacingString: replaceContent)
                    // print("老的字符串：\(oldContent) 新的的字符串：\(newString) 长度：\(newString.count)")
                    self.base.text = newString
                    // 异步改变
                    SwiftyAsyncs.asyncDelay(0.05) {} _: {
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

