//
//  CurrencySelectionDelegate.swift
//  exchangePET
//
//  Created by Александр Басалаев on 15.04.2025.
//

import UIKit
import Foundation

protocol CurrencySelectionDelegate: AnyObject {
    func currencySelected(_ currency: Currency, forTopButton: Bool)
}
