import Foundation
import UIKit

class ViewControllerSecond: UIViewController, UITextFieldDelegate {
    
    let networkMonitor = NetWorkMonitor()
    

    //MARK: Outlets
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldTelegram: UITextField!
    @IBOutlet weak var textFieldPhoneNumber: UITextField!
    @IBOutlet weak var textFieldQuestion: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkMonitor.startMonitoring()
        textFields()
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(dissMissKeyBoard))
        view.addGestureRecognizer(tapgesture)
    }
    @objc private func dissMissKeyBoard() {
        view.endEditing(true)
    }
    
    private func textFields() {
        textFieldEmail.delegate = self
        textFieldTelegram.delegate = self
        textFieldPhoneNumber.delegate = self
        textFieldQuestion.delegate = self
        
        textFieldEmail.placeholder = "example@mail.com"
        textFieldTelegram.placeholder = "@example"
        textFieldPhoneNumber.placeholder = "+7-(XXX)-XX-XX"
        textFieldQuestion.placeholder = "Опишите Ваш вопрос(Необязательно)"
        
        textFieldPhoneNumber.keyboardType = .numberPad
    }
    
    //MARK: Alerts
    private func alertSuccesfull(){
        let alert = UIAlertController(title: "Вы оставили заявку", message: "С Вами свяжутся в ближайшее время", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    private func alertNotSuccesfull() {
        let alert = UIAlertController(title: "Заявка не отправлена", message: "Вы не указали способ связи", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    private func alertNotConnection() {
        let alert = UIAlertController(title: "Нет подключения к интернету", message: "Проверьте соединение с интернетом", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: sendFeedBack
    private func sendFeedBack() {
        let email = textFieldEmail.text ?? ""
        let telegram = textFieldTelegram.text ?? ""
        let phone = textFieldPhoneNumber.text ?? ""
        let question = textFieldQuestion.text ?? ""
        
        let apiBot = "API-TOKEN"
        let chatID = "-4630157697"
        
        var message = "Новый запрос:\n"
        
        if !email.isEmpty {
            message += "Email: \(email)\n"
        }
        if !telegram.isEmpty {
            message += "Telegram: \(telegram)\n"
        }
        if !phone.isEmpty {
            message += "Телефон: \(phone)\n"
        }
        message += "Вопрос: \(question.isEmpty ? "Не указан" : question)"
        
        let items: [String: Any] = [
            "chat_id": chatID,
            "text": message
        ]
        
        guard let url = URL(string: "https://api.telegram.org/bot\(apiBot)/sendMessage") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(
                withJSONObject: items,
                options: [])
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    if error != nil {
                        print("error 1")
                    }
                }
            }
            task.resume()
        } catch  {
            print("error 2")
        }
    }
    
    private func clearForm() {
        textFieldEmail.text = ""
        textFieldTelegram.text = ""
        textFieldPhoneNumber.text = ""
        textFieldQuestion.text = ""
    }
    
    //MARK: Actions
    @IBAction func buttonSendRequest(_ sender: Any) {
        guard networkMonitor.isNetworkAvailable() else {
            alertNotConnection()
            return
        }
        
        if textFieldEmail.text?.count != 0 || textFieldTelegram.text?.count != 0 || textFieldPhoneNumber.text?.count != 0 {
            sendFeedBack()
            clearForm()
            alertSuccesfull()
        } else {
            alertNotSuccesfull()
        }
    }
}
