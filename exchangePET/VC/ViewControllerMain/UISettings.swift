//
//  Untitled.swift
//  exchangePET
//
//  Created by Александр Басалаев on 15.04.2025.
//

import UIKit
import Foundation

class SettingsForView {
    
    static func settingsForViewController(for viewController: ViewController) {
        viewController.labelBackGround.layer.cornerRadius = 10
        viewController.labelBackGround.layer.masksToBounds = true
        
        viewController.topTextfield.borderStyle = .none
        viewController.bottomTextfield.borderStyle = .none
        viewController.topTextfield.backgroundColor = .clear
        viewController.bottomTextfield.backgroundColor = .clear

        viewController.fixButton.layer.cornerRadius = 7
        viewController.fixButton.layer.masksToBounds = true
    }
    
    static func setBoldTitle(text: String) -> NSAttributedString {
        return NSAttributedString(
            string: text,
            attributes: [.font: UIFont.boldSystemFont(ofSize: 17)]
        )
            
    }
}
