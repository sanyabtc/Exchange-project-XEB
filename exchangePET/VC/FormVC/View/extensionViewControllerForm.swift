//
//  extensionTextField.swift
//  exchangePET
//
//  Created by Александр Басалаев on 16.04.2025.
//

import UIKit
import Foundation

extension ViewControllerForm: UITextFieldDelegate {
    func configureTextFields() {
        textFieldEmail.delegate = self
        textFieldTelegram.delegate = self
        textFieldPhoneNumber.delegate = self
        textFieldQuestion.delegate = self
    }
    
    func textFieldIsEditing() {
        let textFields = [textFieldEmail, textFieldPhoneNumber, textFieldTelegram, textFieldQuestion]
        
        textFields.forEach { textField in
            textField?.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
            textField?.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
        }
    }
    
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        TextFieldHighLighter.highLight(textField, isEditing: true)
    }
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        TextFieldHighLighter.highLight(textField, isEditing: false)
    }
    
    func clearForm() {
        textFieldEmail.text = ""
        textFieldTelegram.text = ""
        textFieldPhoneNumber.text = ""
        textFieldQuestion.text = ""
    }
}
