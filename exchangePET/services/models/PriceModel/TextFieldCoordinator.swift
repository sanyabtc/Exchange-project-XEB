//
//  Untitled.swift
//  exchangePET
//
//  Created by Александр Басалаев on 16.04.2025.
//

import UIKit
import Foundation

class TextFieldCoordinator {
    static func setupFormattes(
        inputField: UITextField,
        outputField: UITextField,
        topFormatter: CurrencyTextFieldFormatter,
        bottomFormatter: CurrencyTextFieldFormatter,
    onUpdate: @escaping (_ changeField: UITextField, _ value: String) -> Void) {
        topFormatter.onValueChanged = { field, value in onUpdate(field, value ) }
        bottomFormatter.onValueChanged = { field, value in onUpdate(field, value ) }
        inputField.delegate = topFormatter
        outputField.delegate = bottomFormatter
    }
}
