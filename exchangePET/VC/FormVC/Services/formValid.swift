import Foundation

class FormValidator {
    func isFormValid(email: String?, telegram: String?, phonenumber: String?) -> Bool {
        return email?.count != 0 || telegram?.count != 0 || phonenumber?.count != 0
    }
}
