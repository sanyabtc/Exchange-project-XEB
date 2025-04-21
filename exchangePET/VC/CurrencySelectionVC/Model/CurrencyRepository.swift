//
//  CurrencyRepository.swift
//  exchangePET
//
//  Created by Александр Басалаев on 19.04.2025.
//

class CurrencyRepository {
    static let shared = CurrencyRepository()
    
    let currencies: [Currency] = [
        Currency(fullName: "Tether USD", code: "USDT"),
        Currency(fullName: "US Dollar", code: "USD"),
        Currency(fullName: "Russian Ruble", code: "RUB"),
        Currency(fullName: "Euro", code: "EUR")
    ]
    
    let textTitle = "Выберите нужную валюту"
    
    private init() {}
}
