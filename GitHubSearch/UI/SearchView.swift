//
//  SearchView.swift
//  GitHubSearch
//
//  Created by JLSANCHEZP on 7/12/24.
//

import SwiftUI

struct SearchView: View {
    @State var viewModel = UserRepositoriesViewModel()
    @State private var username: String = ""
    @State private var showDetails: Bool = false
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Logo Placeholder
                Image(systemName: "magnifyingglass.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
#if os(iOS)
                // TextField for Username Input
                TextField("Enter GitHub username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .textInputAutocapitalization(.never)
                    .autocapitalization(.none)
                    .padding(.horizontal)
#elseif os(tvOS)
                TextField("Enter GitHub username", text: $username)
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
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(username.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .disabled(username.isEmpty)
                Spacer()
            }
            .waiting(loading: $viewModel.loading)
            .navigationTitle("GitHub Viewer")
            .navigationDestination(isPresented: $showDetails) {
                DetailView(viewModel: viewModel)
            }
            .alert("Error", isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.errorMsg)
            }
        }
    }
}

#Preview {
    SearchView()
}
