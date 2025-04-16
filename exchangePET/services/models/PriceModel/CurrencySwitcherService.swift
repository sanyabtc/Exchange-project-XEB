import Foundation
import UIKit

class CurrencySwitcher {
    static func swtichCurrencies(topIndex: inout IndexPath?, bottomIndex: inout IndexPath?) {
        swap(&topIndex, &bottomIndex)
        
        if let top = topIndex?.row {
            CurrencyStorage.saveTopCurrency(index: top)
        }
        if let bottom = bottomIndex?.row {
            CurrencyStorage.saveBottomCurrency(index: bottom)
        }
    }
}
