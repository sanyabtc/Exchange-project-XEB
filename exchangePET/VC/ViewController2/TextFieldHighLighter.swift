//
//  textFieldHighLater.swift
//  exchangePET
//
//  Created by Александр Басалаев on 16.04.2025.
//

import UIKit
import Foundation

class TextFieldHighLighter {
    static func highLight(_ textField: UITextField, isEditing: Bool) {
        if isEditing {
            textField.layer.borderColor = UIColor.blue.cgColor
            textField.layer.borderWidth = 1
            textField.layer.cornerRadius = 10
            textField.layer.masksToBounds = true
        } else {
            textField.layer.borderColor = UIColor.clear.cgColor
            textField.layer.borderWidth = 1
        }
    }
}
