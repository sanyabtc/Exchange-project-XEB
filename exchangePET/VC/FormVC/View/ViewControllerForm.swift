import Foundation
import UIKit

class ViewControllerForm: UIViewController {

    //MARK: Outlets
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldTelegram: UITextField!
    @IBOutlet weak var textFieldPhoneNumber: UITextField!
    @IBOutlet weak var textFieldQuestion: UITextField!
    @IBOutlet weak var buttonSendRequest: UIButton!
    //MARK: Data
        
    var viewModel: ViewModelForm {
        let viewModel = ViewModelForm()
        viewModel.netWork = NetWorkMonitor()
        viewModel.feedBackService = SendFeedBack()
        return viewModel
    }
    var alerts: AlertsModel = AlertsModel()
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextFields()
        UIsettingsVCForm.settingForVCForm(for: self)
        textFieldIsEditing()
        
        viewModel.startMonitoringInternet()
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(dissMissKeyBoard))
        view.addGestureRecognizer(tapgesture)
    }
    
    //MARK: DissMissKeyBoard
    
    @objc private func dissMissKeyBoard() {
        view.endEditing(true)
    }

    //MARK: sendFeedBack
    
    private func sendFeedBack() {
        
        viewModel.sendFeedBack(email: textFieldEmail.text, telegram: textFieldTelegram.text, phonenumber: textFieldPhoneNumber.text, question: textFieldQuestion.text) { [weak self] success in
            guard let self else {
                return
            }
            if success {
                clearForm()
                self.alerts.alertSuccesfull(on: self)
            } else {
                self.alerts.alertNotConnection(on: self)
            }
            self.buttonSendRequest.isEnabled = true
        }
    }
    
    
    //MARK: Actions
    
    @IBAction func buttonSendRequest(_ sender: Any) {
        buttonSendRequest.isEnabled = false
        
        guard viewModel.networkHasConnetion() else {
            alerts.alertNotConnection(on: self)
            buttonSendRequest.isEnabled = true
            return
        }
        
        if viewModel.isFormValid(email: textFieldEmail.text, telegram: textFieldTelegram.text, phonenumber: textFieldPhoneNumber.text) {
            sendFeedBack()
        } else {
            alerts.alertNotSuccesfull(on: self)
            buttonSendRequest.isEnabled = true
        }
    }
}
