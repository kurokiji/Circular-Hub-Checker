//
//  NetworkMonitor.swift
//  Circular Hub Checker
//
//  Created by Daniel Torres on 22/1/23.
//

import Foundation
import Network

final class NetworkMonitor: ObservableObject {
    @Published private(set) var isConnected = true
    
    private let nwMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue.global()
    
    public func start() {
        nwMonitor.start(queue: workerQueue)
        nwMonitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
    }
    
    public func stop() {
        nwMonitor.cancel()
    }
}
