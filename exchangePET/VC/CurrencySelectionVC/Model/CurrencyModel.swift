//
//  CurrencyModel.swift
//  exchangePET
//
//  Created by Александр Басалаев on 15.04.2025.
//

import Foundation

struct Currency: CurrencyModelProtocol, Equatable {

    var fullName: String
    let code: String
    var display: String {
        return "\(code) - \(fullName)"
    }
}
