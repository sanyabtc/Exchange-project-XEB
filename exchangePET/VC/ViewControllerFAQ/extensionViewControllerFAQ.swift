//
//  extensionTableView.swift
//  exchangePET
//
//  Created by Александр Басалаев on 16.04.2025.
//

import UIKit
import Foundation

let identifierForTableInVCFAQ = "Cell"

let sections = [
    "Выбирайте лучших",
    "Офисы",
    "Персональный менеджер",
    "Круглосуточная поддержка"
]

extension ViewControllerFAQ: UITableViewDelegate, UITableViewDataSource {
    //MARK: TableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    //MARK: TableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierForTableInVCFAQ, for: indexPath)
        
        cell.textLabel?.text = sections[indexPath.section]
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            performSegue(withIdentifier: "showFaqVC1", sender: self)
        case 1:
            performSegue(withIdentifier: "showFaqVC2", sender: self)
        case 2:
            performSegue(withIdentifier: "showFaqVC3", sender: self)
        case 3:
            performSegue(withIdentifier: "showFaqVC4", sender: self)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
