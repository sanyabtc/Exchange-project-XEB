import Network

class NetWorkMonitor {
    private var monitor: NWPathMonitor?
    private var isConnected: Bool = true
    
    func startMonitoring() {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkMonitorQueue")
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.isConnected = true
            } else {
                self.isConnected = false
            }
        }
        monitor.start(queue: queue)
        self.monitor = monitor
    }
    
    func stopMonitoring() {
        monitor?.cancel()
    }
    
    func isNetworkAvailable() -> Bool {
        return isConnected
    }
}
