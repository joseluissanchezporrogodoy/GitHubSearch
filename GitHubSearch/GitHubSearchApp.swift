//
//  GitHubSearchApp.swift
//  GitHubSearch
//
//  Created by JLSANCHEZP on 7/12/24.
//

import SwiftUI

@main
struct GitHubSearchApp: App {
    @State var monitor = NetworkStatus()
    @State var showOffline = false
    var body: some Scene {
        WindowGroup {
            SearchView()
                .onChange(of: monitor.status) {
                    if monitor.status == .online {
                        showOffline = false
                    } else {
                        showOffline = true
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .overlay {
                    if showOffline {
                        ZStack {
                            Rectangle()
                                .fill(.ultraThinMaterial)
                            ContentUnavailableView("No hay internet",
                                                   systemImage: "wifi.exclamationmark",
                                                   description: Text("No se ha detectado conexión a internet"))
                        }
                    }
                }
        }
    }
}
