import Foundation
import UIKit


class Links {
    
    func telegramLink() {
        let userNameTelegramm = "CassiusMarcellus_trade"
        let appURL = URL(string: "tg://resolve?domain=\(userNameTelegramm)")!
        let webURL = URL(string: "https://t.me/\(userNameTelegramm)")!
        
        DispatchQueue.main.async {
            if UIApplication.shared.canOpenURL(appURL) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
            }
        }
    }
    //MARK: WhatsAppLink
    func whatsAppLink() {
        let phoneNumber = "79609444853"
        let message = "Здравствуйте! Можно сделать обмен?"
        
        let encodedMessage = message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let appURL = URL(string: "whatsapp://send?phone=\(phoneNumber)&text=\(encodedMessage)")!
        let webURL = URL(string: "https://wa.me/\(phoneNumber)?text=\(encodedMessage)")!
        
        DispatchQueue.main.async {
            if UIApplication.shared.canOpenURL(appURL) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
            }
        }
    }
    //MARK: MailLink
    func mailLink() {
        let email = "garbasalaev@mail.ru"
        let subject = "Обмен валют"
        let body = "Здравствуйте! Есть вопрос по теме..."
        
        let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let encodedBody = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        let mailURL = URL(string: "mailto:\(email)?subject=\(encodedSubject)&body=\(encodedBody)")!
        
        DispatchQueue.main.async {
            if UIApplication.shared.canOpenURL(mailURL) {
                UIApplication.shared.open(mailURL, options: [:], completionHandler: nil)
            } else {
                let webMailURL = URL(string: "https://mail.ru/compose/?to=\(email)&subject=\(encodedSubject)&body=\(encodedBody)")!
                UIApplication.shared.open(webMailURL, options: [:], completionHandler: nil)
            }
        }
    }
}
