import Foundation

enum WhichCurrencyChoosed {
    case usdt
    case usd
    case rub
}

struct TradeCalculator {
    
    
    
    func mapTitleToCurrency(_ title: String) -> WhichCurrencyChoosed? {
        switch title {
        case "RUB":
            return .rub
        case "USDT":
            return .usdt
        case "USD":
            return .usd
        default:
            return nil
        }
    }
    
    static func placeHolderCourse(
    topCurrency: WhichCurrencyChoosed,
    bottomCurrency: WhichCurrencyChoosed,
    price: Double?) -> (topPlaceHolder: String, bottomPlaceHolder: String)? {
        guard let price else {
            return nil
        }

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 4
        formatter.minimumFractionDigits = 2
        formatter.decimalSeparator = ","
        formatter.groupingSeparator = " "
        formatter.roundingMode = .down
        
        var topValue: Double = 1.0
        var bottomValue: Double = 1.0
        
        switch (topCurrency, bottomCurrency) {
        case (.rub, .usdt):
            topValue = price * 1.005
        case (.usdt, .rub):
            bottomValue = price * 0.995
        case (.rub, .usd):
            topValue = price * 1.01
        case (.usd, .rub):
            bottomValue = price * 0.99
        case (.usd, .usdt):
            topValue = 1.005
        case (.usdt, .usd):
            topValue = 1.005
        default:
            return nil
        }
        
        guard let topString = formatter.string(from: NSNumber(value: topValue)),
              let bottomString = formatter.string(from: NSNumber(value: bottomValue)) else {
            return nil
        }
        return (topString, bottomString)
    }
    
    
    static func calculateSum(
        sourceCurrency: WhichCurrencyChoosed,
        targetCurrency: WhichCurrencyChoosed,
        amountText: String?,
        price: Double,
        isSourceIsTopField: Bool
    ) -> String? {
        guard let text = amountText?.replacingOccurrences(of: ",", with: "."),
              !text.isEmpty,
              let amount = Double(text),
              price > 0
        else {
            return nil
        }
        
        var result: Double = 0
        
        switch (sourceCurrency, targetCurrency, isSourceIsTopField) {

        case (.rub, .usdt, true):
            result = amount / (price * 1.005)
        case (.rub, .usdt, false):
            result = amount / (price * 0.995)
            
        case (.usdt, .rub, true):
            result = amount * price * 0.995
        case (.usdt, .rub, false):
            result = amount * price * 1.005
        

        case (.rub, .usd, true):
            result = amount / (price * 1.01)
        case (.rub, .usd, false):
            result = amount / (price * 0.99)
            
        case (.usd, .rub, true):
            result = amount * price * 0.99
        case (.usd, .rub, false):
            result = amount * price * 1.01
        

        case (.usd, .usdt, true):
            result = amount * 0.995
        case (.usd, .usdt, false):
            result = amount * 1.005
            
        case (.usdt, .usd, true):
            result = amount * 0.995
        case (.usdt, .usd, false):
            result = amount * 1.005
        

        default:
            return nil
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.decimalSeparator = ","
        formatter.groupingSeparator = " "
        
        return formatter.string(from: NSNumber(value: result))
    }
    
    
    static func calculatePrice(
        topCurrency: WhichCurrencyChoosed,
        bottomCurrency: WhichCurrencyChoosed,
        price: Double?
    ) -> String? {
        guard let price else {
            return nil
        }
        var result = price
        
        switch (topCurrency, bottomCurrency) {
        case (.rub, .usdt):
            result = price * 1.005
        case (.usdt, .rub):
            result = price * 0.995
        case (.rub, .usd):
            result = price * 1.01
        case (.usd, .rub):
            result = price * 0.99
        case (.usd, .usdt):
            result = 1.005
        case (.usdt, .usd):
            result = 1.005
        default:
            return nil
        }
        return String(format: "%.4f", result)
    }
}
