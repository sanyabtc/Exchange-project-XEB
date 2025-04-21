import Foundation
import UIKit

class AlertsModel {
    func alertSuccesfull(on ViewController: UIViewController){
        let alert = UIAlertController(
            title: "Вы оставили заявку",
            message: "С Вами свяжутся в ближайшее время",
            preferredStyle: .alert)
        let action = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil)
        alert.addAction(action)
        ViewController.present(alert, animated: true)
    }
    func alertNotSuccesfull(on ViewController: UIViewController) {
        let alert = UIAlertController(
            title: "Заявка не отправлена",
            message: "Вы не указали способ связи",
            preferredStyle: .alert)
        let action = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil)
        alert.addAction(action)
        ViewController.present(alert, animated: true)
    }
    func alertNotConnection(on ViewController: UIViewController) {
        let alert = UIAlertController(
            title: "Нет подключения к интернету",
            message: "Проверьте соединение с интернетом",
            preferredStyle: .alert)
        let action = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil)
        alert.addAction(action)
        ViewController.present(alert, animated: true)
    }
    
    func alertNotInputText(on ViewController: UIViewController) {
        let alert = UIAlertController(
            title: "Вы не указали сумму",
            message: "",
            preferredStyle: .alert)
        let action = UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil)
        alert.addAction(action)
        ViewController.present(alert, animated: true)
    }
}
