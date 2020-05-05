// https://blog.csdn.net/yaojinhai06/article/details/89372062

extension Double: NumberFormatableProtocol {
    
}

public protocol NumberFormatableProtocol {
    func moneyDescription() -> String?
}

extension NumberFormatableProtocol where Self == Double{
    /// 返回这样的金钱格式
    /// - Returns: 123456.0123 -> 123.45K
    public func moneyDescription() -> String? {
        let number = NSNumber(value: self)
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
//        formatter.locale = .init(identifier: "en_US")
//        formatter.numberStyle = .currencyAccounting
        formatter.numberStyle = .decimal
        
        if self > 1_000_000 {
            formatter.multiplier = 0.000001
            formatter.positiveSuffix = "M"
        }
        else if self > 100_000 {
            formatter.multiplier = 0.001
            formatter.positiveSuffix = "K"
        }
        
        return formatter.string(from: number)
    }
}
