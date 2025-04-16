import Foundation

class SendFeedBack {
    
    func sendFeedBack(email: String?, telegram: String?, phonenumber: String?, question: String?, completion: @escaping (Bool) -> Void) {
        
        let apiBot = "7685426984:AAG5fhDORxvclkGp16Sh6Qlw_82uXLi6vK4"
        let chatID = "-4630157697"
        
        var message = "Новый запрос:\n"
        
        if let email, !email.isEmpty {
            message += "Email: \(email)\n"
        }
        if let telegram, !telegram.isEmpty {
            message += "Telegram: \(telegram)\n"
        }
        if let phonenumber, !phonenumber.isEmpty {
            message += "Телефон: \(phonenumber)\n"
        }
        message += "Вопрос: \(question?.isEmpty == false ? question! : "Не указан")"
        
        let items: [String: Any] = [
            "chat_id": chatID,
            "text": message
        ]
        
        guard let url = URL(string: "https://api.telegram.org/bot\(apiBot)/sendMessage") else {
            completion(false)
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
                    if error != nil {
                        completion(false)
                        return
                    }
                completion(true)
            }
            task.resume()
        } catch  {
            completion(false)
        }
    }
}
