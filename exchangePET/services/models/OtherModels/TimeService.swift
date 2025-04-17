import Foundation

class TimeService {
    static func getCurrentTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentTime = Date()
        return formatter.string(from: currentTime)
    }
    
    private var timer: Timer?
    private weak var viewController: ViewController?
    
    init(viewController: ViewController) {
        self.viewController = viewController
    }
    
    private var seconds = 31
    let networkMonitor = NetWorkMonitor()
    let alerts = Alerts()
    
    func StartTimer() {
        timer?.invalidate()
        seconds = 31
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            guard let self else {
                return
            }
            networkMonitor.startMonitoring()
            seconds -= 1
            if seconds >= 10 {
                self.viewController?.timerLabel.text = "00:\(seconds)"
            } else if seconds > 0 {
                self.viewController?.timerLabel.text = "00:0\(seconds)"
            } else if seconds == 0 {
                self.viewController?.timerLabel.text = "00:0\(seconds)"
                
                self.viewController?.getPrice()
                
                guard networkMonitor.isNetworkAvailable() else {
                    alerts.alertNotConnection(on: viewController!)
                    return
                }
                
                
                seconds = 31
            }

        })
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
