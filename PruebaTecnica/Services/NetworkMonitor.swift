//
//  NetworkMonitor.swift
//  PruebaTecnica
//
//  Created by Ivan Perez on 13/01/26.
//


import Network
import Combine

final class NetworkMonitor: ObservableObject {
    static let shared = NetworkMonitor()

    @Published private(set) var isConnected = true
    private let monitor = NWPathMonitor()

    private init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: DispatchQueue(label: "NetworkMonitor"))
    }
}
