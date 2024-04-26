//
//  Codable+Swifty.swift
//  RyukieSwifty
//
//  Created by wrq on 2024/4/26.
//

import Foundation

public protocol SwiftyCodableProtocol where Self: Codable {
    func swifty_toJsonString() -> String?
    func swifty_toJsonDic() -> [String: Any]?
}

public extension SwiftyCodableProtocol {
    func swifty_toJsonDic() -> [String: Any]? {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            return nil
        }
    }
    
    func swifty_toJsonString() -> String? {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted // Optional for pretty printed JSON
            let jsonData = try encoder.encode(self)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            return nil
        }
    }

}
