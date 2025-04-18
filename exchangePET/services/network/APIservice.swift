import Foundation
import UIKit

//You can own your api key at abcex.io

class ApiService {
    var marketPrice: Double?
    //MARK: fetchMarketPrice
    func fetchMarketPrice(completion: @escaping (Double?) -> Void) {
        let urlString = "https://gateway.abcex.io/api/v1/markets/price?marketId=USDTRUB"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("API KEY", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Ошибка запроса: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Нет данных")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                print(String(data: data, encoding: .utf8) ?? "Не удалось преобразовать Data в String")
                let marketData = try decoder.decode(MarketPrice.self, from: data)
                
                if let price = marketData.price {
                    completion(price)
                } else {
                    print("Цена не найдена")
                    completion(nil)
                }
            } catch {
                print("Ошибка декодирования: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}
