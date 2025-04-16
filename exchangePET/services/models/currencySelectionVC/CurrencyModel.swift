//
//  CurrencyModel.swift
//  exchangePET
//
//  Created by Александр Басалаев on 15.04.2025.
//

import Foundation
import UIKit

struct Currency: Equatable {
    let image: UIImage?
    let code: String
    let name: String
    
    var display: String {
        return "\(code) - \(name)"
    }
}

let currenciesModel: [Currency] = [
    Currency(image: UIImage(systemName: "dollarsign.circle.fill"), code: "USDT", name: "Tether USD"),
    Currency(image: UIImage(systemName: "dollarsign.circle.fill"), code: "USD", name: "US Dollar"),
    Currency(image: UIImage(systemName: "rublesign.circle.fill"), code: "RUB", name: "Russian Ruble")
]
