//
//  AmountStringFormatter.swift
//  Swifty
//
//  Created by RyukieSama on 2018/1/29.
//  Copyright © 2018年 RyukieSama. All rights reserved.
//

import Foundation

public enum AccountInfoDetailType {
    case text
    case number
    case rate //4位小数 0-9999.9999
    case phone
    case intNumber
    case selectable
    case other
}

public class AmountStringFormatter {
    public var originString: String = ""
    public var decimals: Int = 2
    
    public init() {}
    
    public var inputType: AccountInfoDetailType = .number {
        didSet {
            switch inputType {
            case .rate:
                decimals = 4
            case .number:
                decimals = 2
            case .intNumber:
                decimals = 0
            default:
                return
            }
        }
    }
    
    public func reset() {
        originString = ""
    }
    
    public func formatted(_ input: String) -> String? {
        guard let result = input.amountFormattedSingle(with: originString, decimals: decimals)
            else {
                return nil
        }
        
        originString = result.origin
        return result.formatted
    }
    
    public func willBe(for input: String) -> String? {
        guard let result = input.amountFormattedSingle(with: originString, decimals: decimals)
            else {
                return nil
        }

        return result.origin
    }
}
