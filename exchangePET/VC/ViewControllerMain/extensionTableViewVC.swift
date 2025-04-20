import Foundation
import UIKit

struct FixHistory {
    var codeInput: String
    var codeOutput: String
    var time: String
    var inputSum: String
    var outputSum: String
    
    init(codeInput: String, codeOutput: String, time: String, inputSum: String, outputSum: String) {
        self.codeInput = codeInput
        self.codeOutput = codeOutput
        self.time = time
        self.inputSum = inputSum
        self.outputSum = outputSum
    }
    
    func dataInput(codeInput: String, codeOutput: String, time: String, inputSum: String, outputSum: String, price: String) -> String {
        return ("\(codeInput) to \(codeOutput) \(time)\n\(inputSum) to \(outputSum) Цена: \(price)")
    }
}

let fixedHistorySave = FixedHistorySave()
var sectionsTableView: [String] = []

extension ViewControllerMain: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sectionsTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellTableViewFix", for: indexPath)
        
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.text = sectionsTableView[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = .systemGray5
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            sectionsTableView.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            fixedHistorySave.saveHistory()
        }
    }
}
