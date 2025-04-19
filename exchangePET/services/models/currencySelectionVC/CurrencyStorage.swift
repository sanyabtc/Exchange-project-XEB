//
//  CurrencyStorage.swift
//  exchangePET
//
//  Created by Александр Басалаев on 15.04.2025.
//

import Foundation

struct CurrencyStorage {
    
    static func saveTopCurrency(index: Int) {
        UserDefaults.standard.set(index, forKey: "choosedIndexPathTop")
    }
    
    static func saveBottomCurrency(index: Int) {
        UserDefaults.standard.set(index, forKey: "choosedIndexPathBot")
    }
    
    static func loadTopCurrency() -> Int? {
        UserDefaults.standard.integer(forKey: "choosedIndexPathTop")
    }
    
    static func loadBottomCurrency() -> Int? {
        UserDefaults.standard.integer(forKey: "choosedIndexPathBot")
    }
}
