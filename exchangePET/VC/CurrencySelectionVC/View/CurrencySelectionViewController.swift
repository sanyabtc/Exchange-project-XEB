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
    var viewModel: CurrencySelectionViewModel = CurrencySelectionViewModel()
    var isTopButton: Bool = false
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
}

