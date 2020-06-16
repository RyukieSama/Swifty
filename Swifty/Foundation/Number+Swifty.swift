// https://blog.csdn.net/yaojinhai06/article/details/89372062

extension Double: NumberFormatableProtocol {
    
}

public protocol NumberFormatableProtocol {
    func moneyDescription(autoPositiveSuffix: Bool) -> String?
}

extension NumberFormatableProtocol where Self == Double{
    /// 返回这样的金钱格式
    /// - Returns: 123456.0123 -> 123.45K
    /// - Parameter autoPositiveSuffix: 是否进行金额单位缩写
    public func moneyDescription(autoPositiveSuffix: Bool) -> String? {
        let calValue = abs(self)
        let number = NSNumber(value: calValue)
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
//        formatter.locale = .init(identifier: "en_US")
//        formatter.numberStyle = .currencyAccounting
        formatter.numberStyle = .decimal
        
        if autoPositiveSuffix == true {
            if calValue > 1_000_000 {
                formatter.multiplier = 0.000001
                formatter.positiveSuffix = "M"
            }
            else if calValue > 100_000 {
                formatter.multiplier = 0.001
                formatter.positiveSuffix = "K"
            }
        }
        
        var result = formatter.string(from: number)
        if self < 0 {
            result = "-" + (result ?? "")
        }
        return result
    }
}
