//
//  ViewController.swift
//  exchangePET
//
//  Created by Александр Басалаев on 02.04.2025.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let apiService = APIservice()
    var isChooseRUB: Bool = true
    
    //MARK: OUTLETS
    
    //Timer
    @IBOutlet weak var labelTimer: UILabel!
    // Image rub/usdt
    @IBOutlet weak var imageRUBtop: UIImageView!
    @IBOutlet weak var imageUSDTtop: UIImageView!
    @IBOutlet weak var imageUSDTbot: UIImageView!
    @IBOutlet weak var imageRUBbot: UIImageView!
    //label rub/usdt
    @IBOutlet weak var labelRUBtop: UILabel!
    @IBOutlet weak var labelUSDTtop: UILabel!
    @IBOutlet weak var labelUSDTbot: UILabel!
    @IBOutlet weak var labelRUBbot: UILabel!
    //label vpn
    @IBOutlet weak var labelAttentionVpn: UILabel!
    //textField input sum
    @IBOutlet weak var textFieldInputSum: UITextField!
    //label output sum
    @IBOutlet weak var labelOutputSum: UILabel!
    //image bot currency
    @IBOutlet weak var imageCurrencyBotTop: UIImageView!
    @IBOutlet weak var imageCurrencyBotBot: UIImageView!
    //timeStamp Last update
    @IBOutlet weak var labelTimestampUpdate: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTimer()
        uploadImage()
        setupLabelTradeCourse()
        getPrice()
        uploadBottomSide()
        calculateSumOfTrade()
        print(Bundle.main.bundleIdentifier ?? "nope.ID")
        
        let timeStamp = self.getCurrentTime()
        self.labelTimestampUpdate.text = "\(timeStamp)"
        
        textFieldInputSum.delegate = self
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(dissMissKeyBoard))
        view.addGestureRecognizer(tapgesture)
    }
    //MARK: DissMissKeyBoard
    @objc private func dissMissKeyBoard() {
        view.endEditing(true)
    }
    
    //MARK: Timer
    private func startTimer() {
        timer.invalidate()
        seconds = 10
        labelTimer.text = "00:00:\(seconds)"
        
        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true) { _ in
                seconds -= 1
                
                if seconds == 10 {
                    self.labelTimer.text = "00:00:\(seconds)"
                } else if seconds < 10 && seconds != 0 {
                    self.labelTimer.text = "00:00:0\(seconds)"
                } else if seconds == 0 {
                    self.labelTimer.text = "00:00:00"
                    seconds = 11
                    self.getPrice()
                    let timeStamp = self.getCurrentTime()
                    self.labelTimestampUpdate.text = "\(timeStamp)"
                }
            }
    }
    
    //MARK: uploadImage
    
    private func uploadImage() {
        
        //TOP
        imageRUBtop.image = UIImage(named: "rub")
        imageUSDTtop.image = UIImage(named: "usdt")
        imageRUBbot.image = UIImage(named: "rub")
        imageUSDTbot.image = UIImage(named: "usdt")
        
        //BOT
        imageCurrencyBotTop.image = UIImage(named: "rub")
        imageCurrencyBotBot.image = UIImage(named: "usdt")
    }
    
    //MARK: CourseOfTrade
    
    private func setupLabelTradeCourse() {
        labelRUBtop.text = "RUB\n1"
        labelRUBbot.text = "RUB\n1"
        labelUSDTtop.text = "USDT\n1"
        labelUSDTbot.text = "USDT\n1"
        labelAttentionVpn.text = "Наше приложение не работает с включенным VPN"
    }
    
    //MARK: json request
    private func getPrice() {
        apiService.fetchMarketPrice() { price in
            if let price = price {
                DispatchQueue.main.async {
                    self.labelRUBtop.text = "RUB\n\(String(price * 1.005).prefix(5))"
                    self.labelRUBbot.text = "RUB\n\(String(price / 1.005).prefix(5))"
                }
            }
        }
    }
    
    //MARK: Bottom side of buttons
    
    private func uploadBottomSide() {
        //TextField
        textFieldInputSum.placeholder = "Введите сумму"
        textFieldInputSum.textAlignment = .right
        textFieldInputSum.delegate = self
        textFieldInputSum.keyboardType = .numberPad
        
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
                let characterSet = CharacterSet(charactersIn: string)
                return allowedCharacters.isSuperset(of: characterSet)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: Calculate trade
    private func calculateSumOfTrade() {
        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true) { _ in
                
                let text = self.textFieldInputSum.text
                if text?.count == 0 {
                    self.labelOutputSum.text = "К получению"
                } else {
                    self.apiService.fetchMarketPrice() { price in
                        if let price = price {
                            DispatchQueue.main.async {
                                if self.isChooseRUB {
                                    self.labelOutputSum.text = "\(Int(Double(text!)! / (price * 1.005)))"
                                } else {
                                    self.labelOutputSum.text = "\(Int(Double(text!)! * (price / 1.005)))"
                                }
                            }
                            
                        }
                    }
                }
            }
    }
    
    //MARK: TimeStamp UPDATE
    func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.string(from: Date())
    }
    
    
    
    //MARK: Button change currency
    
    @IBAction func buttonChangeCurrency(_ sender: Any) {
        if isChooseRUB {
            imageCurrencyBotTop.image = UIImage(named: "usdt")
            imageCurrencyBotBot.image = UIImage(named: "rub")
            isChooseRUB.toggle()
        } else {
            imageCurrencyBotTop.image = UIImage(named: "rub")
            imageCurrencyBotBot.image = UIImage(named: "usdt")
            isChooseRUB.toggle()
        }
    }
    //MARK: Button Share
    @IBAction func buttonShare(_ sender: Any) {
        let image = UIImage(named: "imageToShare")
        let appLink = URL(string: "https://t.me/CassiusMarcellus_trade")!
        let activityViewController = UIActivityViewController(
            activityItems: [image as Any, appLink],
            applicationActivities: nil)
        present(activityViewController, animated: true)
    }
    
    
}

