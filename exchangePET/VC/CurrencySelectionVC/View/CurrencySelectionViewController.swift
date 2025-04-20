//
//  CurrencySelectionViewController.swift
//  exchangePET
//
//  Created by Александр Басалаев on 15.04.2025.
//
//image: UIImage(systemName: "dollarsign.circle.fill")
//image: UIImage(systemName: "dollarsign.circle.fill")
//image: UIImage(systemName: "rublesign.circle.fill")
//
import UIKit
import Foundation

class CurrencySelectionViewController: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Data
    weak var delegate: CurrencySelectionDelegate?
    var selectedIndex: IndexPath?
    var textTitle = "Выберите нужную валюту"
    var isTopButton: Bool = false
    var blockedCurrency: Currency?
    var currencies: [Currency] = []
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencies = CurrencyRepository.shared.currencies
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

