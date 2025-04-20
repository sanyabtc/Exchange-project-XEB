//
//  CurrencySelectionViewModel.swift
//  exchangePET
//
//  Created by Александр Басалаев on 19.04.2025.
//

import Foundation

final class CurrencySelectionViewModel {
    private(set) var currencies: [Currency]
    var selectedIndex: IndexPath?
    var blockedCurrency: IndexPath?
    
    init(currencies: [Currency] = CurrencyRepository.shared.currencies) {
        self.currencies = currencies
    }
    
    func currency(at indexPath: IndexPath) -> Currency {
        return currencies[indexPath.row]
    }
    
    func numberOfCurrencies() -> Int {
        return currencies.count
    }
    
    func isCurrencyBlocked(at indexPath: IndexPath?) -> Bool {
        return indexPath == blockedCurrency
    }
    
    func titleHeader() -> String {
        return CurrencyRepository.shared.textTitle
    }
    
    func isSelected(at indexPath: IndexPath) -> Bool {
        return indexPath == selectedIndex
    }
    
}
