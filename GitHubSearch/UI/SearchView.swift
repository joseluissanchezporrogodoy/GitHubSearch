//
//  SearchView.swift
//  GitHubSearch
//
//  Created by JLSANCHEZP on 7/12/24.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = UserRepositoriesViewModel()
    @State private var username: String = ""
    @State private var showDetails: Bool = false
#if os(iOS)
    init() {
        // Personalizar la apariencia de la barra de navegación
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor.systemGray6
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black,
                                                .font: UIFont.systemFont(ofSize: 17, weight: .light)]
        navBarAppearance.shadowColor = UIColor.black.withAlphaComponent(0.50)
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
#endif
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
#if os(iOS)
                // TextField for Username Input
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textInputAutocapitalization(.never)
                    .autocapitalization(.none)
                    .padding(.horizontal, 20)
                    .accessibilityIdentifier("Enter GitHub username")
#elseif os(tvOS)
                TextField("Username", text: $username)
                    .textFieldStyle(DefaultTextFieldStyle())
                    .textInputAutocapitalization(.never)
                    .autocapitalization(.none)
                    .padding(.horizontal)
#endif
                // Search Button
                Button {
                    Task {
                        await viewModel.fetchUserAndRepositories(for: username)
                        if viewModel.errorMsg.isEmpty {
                            showDetails = true
                        }
                    }
                } label: {
                    Text("Search")
                        .foregroundColor(.blue)
                        .font(.system(size: 17))
                        .fontWeight(.regular)
                }
                .padding(.top, 10)
                .disabled(username.isEmpty)
                Spacer()
            }
            .waiting(loading: $viewModel.loading)
            .navigationTitle("GitHub Viewer")
#if os(iOS)

            .navigationBarTitleDisplayMode(.inline)
#endif
            .navigationDestination(isPresented: $showDetails) {
                DetailView(viewModel: viewModel)
            }
            .alert("Error", isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.errorMsg)
            }
        }
        .toolbarBackground(.orange, for: .navigationBar, .tabBar)
    }
}

#Preview {
    SearchView()
}
