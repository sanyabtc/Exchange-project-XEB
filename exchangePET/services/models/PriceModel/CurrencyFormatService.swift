import Foundation

final class CurrencyFormatManager {
    static let shared = CurrencyFormatManager()
    
    let formatter: NumberFormatter
    
    private init() {
        self.formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = ","
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.roundingMode = .down
    }
    
    func string(from double: Double) -> String? {
        return formatter.string(from: NSNumber(value: double))
    }
    func double(from string: String) -> Double? {
        let cleaned = string.replacingOccurrences(of: " ", with: "")
        return formatter.number(from: cleaned)?.doubleValue
    }
}
