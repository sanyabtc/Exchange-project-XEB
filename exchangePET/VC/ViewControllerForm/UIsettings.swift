//
//  UIsettings.swift
//  exchangePET
//
//  Created by Александр Басалаев on 16.04.2025.
//

import UIKit
import Foundation

class UIsettingsVCForm {
    static func settingForVCForm(for ViewControllerForm: ViewControllerForm) {

            
        ViewControllerForm.textFieldEmail.placeholder = "example@mail.com"
        ViewControllerForm.textFieldTelegram.placeholder = "@example"
        ViewControllerForm.textFieldPhoneNumber.placeholder = "+7-(XXX)-XX-XX"
        ViewControllerForm.textFieldQuestion.placeholder = "Опишите Ваш вопрос(Необязательно)"
            
        ViewControllerForm.textFieldPhoneNumber.keyboardType = .phonePad
            
        }

    
}
