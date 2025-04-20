import UIKit

class faqVC1: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let identifier = "CellFaqVC1"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    //MARK: TableViewDataSource
    let sectionsFaqVC1 = [
        "Почему мы?",
        "Скорость оплаты инвойса?",
        "Насколько чистая криптовалюта?",
        "Какой максимальный объем сделки?",
        "Оперативное решение"
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        cell.textLabel?.text = sectionsFaqVC1[indexPath.section]
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //MARK: TableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionsFaqVC1.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            performSegue(withIdentifier: "showInFaqVC11", sender: self)
        case 1:
            performSegue(withIdentifier: "showInFaqVC12", sender: self)
        case 2:
            performSegue(withIdentifier: "showInFaqVC13", sender: self)
        case 3:
            performSegue(withIdentifier: "showInFaqVC14", sender: self)
        case 4:
            performSegue(withIdentifier: "showInFaqVC15", sender: self)
        default:
            break
        }
    }
}
