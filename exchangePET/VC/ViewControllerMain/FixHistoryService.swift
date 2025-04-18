import UIKit
import Foundation

class FixHistoryService {
    func createFixHistory(
        inputSum: String,
        outputSum: String,
        topCurrency: String,
        bottomCurrecy: String,
        price: Double) -> FixHistory {
            let time = TimeService.getCurrentTime()
            return FixHistory(
                codeInput: topCurrency,
                codeOutput: bottomCurrecy,
                time: time,
                inputSum: inputSum,
                outputSum: outputSum)
        }
    
    func formattedHistoryString(_ fix: FixHistory, price: String) -> String {
        return fix.dataInput(
            codeInput: fix.codeInput,
            codeOutput: fix.codeOutput,
            time: fix.time,
            inputSum: fix.inputSum,
            outputSum: fix.outputSum,
            price: price)
    }
}
