import Foundation
import UIKit

class CurrencyTextFieldFormatter: NSObject, UITextFieldDelegate {
    var onValueChanged: ((UITextField, String) -> Void)?
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newString = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        let cleanedString = newString
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: ".", with: ",")
            .filter { $0.isNumber || $0 == "," }
        
        guard cleanedString.filter({ $0 == "," }).count <= 1 else { return false }
        
        let parts = cleanedString.components(separatedBy: ",")
        var integerPart = parts[0]
        let decimalPart = parts.count > 1 ? String(parts[1].prefix(2)) : ""
        
        if integerPart.count > 1 {
            integerPart = String(integerPart.drop { $0 == "0" })
        }
        
        let formattedInteger = formatIntegerPart(integerPart)
        let newText = decimalPart.isEmpty ? formattedInteger : "\(formattedInteger),\(decimalPart)"
        
        textField.text = newText
        onValueChanged?(textField, cleanedString)
        
        self.adjustCursorPosition(textField: textField, newText: newText)
        
        return false
    }
    
    private func formatIntegerPart(_ part: String) -> String {
        guard !part.isEmpty else {
            return ""
        }
        let number = NSNumber(value: Int(part) ?? 0)
        return CurrencyFormatManager.shared.formatter.string(from: number)?.replacingOccurrences(of: ",00", with: "") ?? ""
    }
    
    private func adjustCursorPosition(textField: UITextField, newText: String) {
        let commaPosition = newText.firstIndex(of: ",")
        let targetPosition: Int
        
        if let commaIndex = commaPosition {

            targetPosition = newText.distance(from: newText.startIndex, to: commaIndex)
        } else {

            targetPosition = newText.count
        }
        
        if let newPosition = textField.position(from: textField.beginningOfDocument, offset: targetPosition) {
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        }
    }
}
