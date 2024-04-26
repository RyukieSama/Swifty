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
    static func swifty_fromJson(dic: [String: Any]) -> Self?
    static func swifty_fromJson(string: String) -> Self?
    static func swifty_from(data: Data) -> Self?
}

public extension SwiftyCodableProtocol {
    static func swifty_fromJson(dic: [String: Any]) -> Self? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dic, options: [])
            let decoder = JSONDecoder()
            return try decoder.decode(Self.self, from: jsonData)
        } catch {
            SwiftyLog("Failed to convert JSON string to data.")
            return nil
        }
    }
    
    static func swifty_fromJson(string: String) -> Self? {
        do {
            if let jsonData = string.data(using: .utf8) {
                let decoder = JSONDecoder()
                return try decoder.decode(Self.self, from: jsonData)
            } else {
                SwiftyLog("Failed to convert JSON string to data.")
                return nil
            }
        } catch {
            SwiftyLog(error.localizedDescription)
            return nil
        }
    }
    
    static func swifty_from(data: Data) -> Self? {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Self.self, from: data)
        } catch {
            SwiftyLog(error.localizedDescription)
            return nil
        }
    }
    
    func swifty_toJsonDic() -> [String: Any]? {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            SwiftyLog(error.localizedDescription)
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
            SwiftyLog(error.localizedDescription)
            return nil
        }
    }

}
