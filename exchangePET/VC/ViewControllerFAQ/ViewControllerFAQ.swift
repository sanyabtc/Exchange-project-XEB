import Foundation
import UIKit

class ViewControllerFAQ: UIViewController {

    let links = Links()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    //MARK: Actions
    @IBAction func buttonTelegramLink(_ sender: Any) {
        links.telegramLink()
    }
    @IBAction func buttonWhatsAppLink(_ sender: Any) {
        links.whatsAppLink()
    }
    @IBAction func buttonMailLink(_ sender: Any) {
        links.mailLink()
    }
}
