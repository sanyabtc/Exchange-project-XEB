import Foundation
import UIKit

class ViewControllerSecond: UIViewController {

    //MARK: Outlets
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldTelegram: UITextField!
    @IBOutlet weak var textFieldPhoneNumber: UITextField!
    @IBOutlet weak var textFieldQuestion: UITextField!
    @IBOutlet weak var buttonSendRequest: UIButton!
    //MARK: Data
    
    let networkMonitor = NetWorkMonitor()
    let formValidator = FormValidator()
    let alerts = Alerts()
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextFields()
        UIsettingsVC2.settingForVC2(for: self)
        networkMonitor.startMonitoring()

        textFieldIsEditing()
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(dissMissKeyBoard))
        view.addGestureRecognizer(tapgesture)
    }
    
    //MARK: DissMissKeyBoard
    
    @objc private func dissMissKeyBoard() {
        view.endEditing(true)
    }
    
    
    //MARK: sendFeedBack
    
    private func sendFeedBack() {
        let feedBackModel = SendFeedBack()
        
        feedBackModel.sendFeedBack(email: textFieldEmail.text, telegram: textFieldTelegram.text, phonenumber: textFieldPhoneNumber.text, question: textFieldQuestion.text) { success in
            DispatchQueue.main.async {
                if success {
                    self.clearForm()
                    self.alerts.alertSuccesfull(on: self)
                    self.buttonSendRequest.isEnabled = true
                }
            }
        }
    }
    
    
    //MARK: Actions
    
    @IBAction func buttonSendRequest(_ sender: Any) {
        buttonSendRequest.isEnabled = false
        
        
        guard networkMonitor.isNetworkAvailable() else {
            alerts.alertNotConnection(on: self)
            buttonSendRequest.isEnabled = true
            return
        }
        
        if formValidator.isFormValid(email: textFieldEmail.text, telegram: textFieldTelegram.text, phonenumber: textFieldPhoneNumber.text) {
            sendFeedBack()
        } else {
            alerts.alertNotSuccesfull(on: self)
            buttonSendRequest.isEnabled = true
        }
    }
}
