//
//  CurrencySelectionViewController.swift
//  exchangePET
//
//  Created by Александр Басалаев on 15.04.2025.
//

import UIKit
import Foundation

class CurrencySelectionViewController: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Data
    weak var delegate: CurrencySeletcionDelegate?
    var currencies: [Currency] = currenciesModel
    var selectedIndex: IndexPath?
    var textTitle = "Выберите нужную валюту"
    var isTopButton: Bool = false
    var blockedCurrency: Currency?
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

