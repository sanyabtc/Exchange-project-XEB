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
        label.textLabel?.text = textTitle
        return label
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currency = currencies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = currency.display
        //        cell.imageView?.image = currency.image
        cell.accessoryType = (indexPath == selectedIndex) ? .checkmark : .none
        cell.selectionStyle = (currency == blockedCurrency) ? .none : .default
        cell.textLabel?.textColor = (currency == blockedCurrency) ? .gray : .label
            
        return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if currencies[indexPath.row] == blockedCurrency {
                return
            }
            
            selectedIndex = indexPath
            delegate?.currencySelected(currencies[indexPath.row], forTopButton: isTopButton)
            tableView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.dismiss(animated: true)
            }
        }
        
}
