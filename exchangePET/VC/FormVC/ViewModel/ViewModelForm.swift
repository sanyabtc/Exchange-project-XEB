//
//  ViewModelForm.swift
//  exchangePET
//
//  Created by Александр Басалаев on 20.04.2025.
//

import Foundation

class ViewModelForm {
    var netWork: NetWorkMonitor!
    var feedBackService: SendFeedBack!

    func startMonitoringInternet() {
        netWork.startMonitoring()
    }
    
    func networkHasConnetion() -> Bool {
        return netWork.isNetworkAvailable()
    }
    
    func sendFeedBack(
        email: String?,
        telegram: String?,
        phonenumber: String?,
        question: String?,
        completion: @escaping (Bool) -> Void) {
            guard networkHasConnetion() else {
                completion(false)
                return
            }
            guard isFormValid(
                email: email,
                telegram: telegram,
                phonenumber: phonenumber) else {
                completion(false)
                return
            }
            feedBackService.sendFeedBack(
                email: email,
                telegram: telegram,
                phonenumber: phonenumber,
                question: question) { success in
                    DispatchQueue.main.async {
                        completion(success)
                    }
            }
    }

    func isFormValid(email: String?, telegram: String?, phonenumber: String?) -> Bool {
        return email?.count != 0 || telegram?.count != 0 || phonenumber?.count != 0
    }

}
