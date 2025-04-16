//
//  UIsettings.swift
//  exchangePET
//
//  Created by Александр Басалаев on 16.04.2025.
//

import UIKit
import Foundation

class UIsettingsVC2 {
    static func settingForVC2(for ViewControllerSecond: ViewControllerSecond) {

            
        ViewControllerSecond.textFieldEmail.placeholder = "example@mail.com"
        ViewControllerSecond.textFieldTelegram.placeholder = "@example"
        ViewControllerSecond.textFieldPhoneNumber.placeholder = "+7-(XXX)-XX-XX"
        ViewControllerSecond.textFieldQuestion.placeholder = "Опишите Ваш вопрос(Необязательно)"
            
        ViewControllerSecond.textFieldPhoneNumber.keyboardType = .phonePad
            
        }

    
}
