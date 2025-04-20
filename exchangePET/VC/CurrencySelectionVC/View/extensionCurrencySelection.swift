//
//  extensionCurrencySelection.swift
//  exchangePET
//
//  Created by Александр Басалаев on 15.04.2025.
//
//MARK: Tableview for currency selector in main view
import UIKit
import Foundation


//MARK: TableView delegate//datasource
let identifier = "CellCurrencySelector"

extension CurrencySelectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UITableViewHeaderFooterView()
        label.textLabel?.text = viewModel.titleHeader()
        return label
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCurrencies()
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currency = viewModel.currency(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = currency.display
        //        cell.imageView?.image = currency.image
        cell.accessoryType = viewModel.isSelected(at: indexPath) ? .checkmark : .none
        cell.selectionStyle = viewModel.isCurrencyBlocked(at: indexPath) ? .none : .default
        cell.textLabel?.textColor = viewModel.isCurrencyBlocked(at: indexPath) ? .gray : .label
            
        return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let currency = viewModel.currency(at: indexPath)
            
            if viewModel.isCurrencyBlocked(at: indexPath) {
                return
            }
            
            viewModel.selectedIndex = indexPath
            delegate?.currencySelected(currency, forTopButton: isTopButton)
            tableView.reloadData()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.dismiss(animated: true)
            }
        }
        
}
