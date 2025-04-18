import Foundation
import UIKit

class FixedHistorySave {
    func saveHistory() {
        UserDefaults.standard.set(sectionsTableView, forKey: "FixHistory")
    }
    func uploadHistory() {
        if let savedArray =  UserDefaults.standard.array(forKey: "FixHistory") as? [String] {
            sectionsTableView = savedArray
        }
    }
}
