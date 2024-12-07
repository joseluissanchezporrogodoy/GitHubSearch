//
//  NetworkStatus.swift
//  GitHubSearch
//
//  Created by JLSANCHEZP on 7/12/24.
//

import SwiftUI
import Network

@Observable
final class NetworkStatus {
    enum Status {
        case offline, online, unknown
    }
    var status: Status = .unknown
    let monitor: NWPathMonitor
    var queue = DispatchQueue(label: "MonitorNetwork")
    init() {
        self.monitor = NWPathMonitor()
        self.monitor.start(queue: queue)
        self.monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.status = path.status == .satisfied ? .online : .offline
            }
        }
        self.status = monitor.currentPath.status == .satisfied ? .online : .offline
    }
}
