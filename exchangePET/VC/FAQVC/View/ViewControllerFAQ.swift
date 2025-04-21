import Foundation
import UIKit

class ViewControllerFAQ: UIViewController {

    var viewModel: ViewModelFAQ = ViewModelFAQ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    //MARK: Actions
    @IBAction func buttonTelegramLink(_ sender: Any) {
        viewModel.openTelegram()
    }
    @IBAction func buttonWhatsAppLink(_ sender: Any) {
        viewModel.openWhatsApp()
    }
    @IBAction func buttonMailLink(_ sender: Any) {
        viewModel.openEmail()
    }
}
