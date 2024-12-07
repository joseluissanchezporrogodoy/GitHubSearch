//
//  UserRepositoriesViewModel.swift
//  GitHubSearch
//
//  Created by JLSANCHEZP on 7/12/24.
//

import SwiftUI
import GitHubNetworking

@Observable
final class UserRepositoriesViewModel {
    // MARK: - Published Properties
    var user: User?
    var repositories: [Repository] = []
    var showAlert = false
    var errorMsg = ""
    var loading = false
    // MARK: - Dependencies
    private let getUserUseCase: GetUserUseCaseProtocol
    private let getRepositoriesUseCase: GetRepositoriesUseCaseProtocol
    // MARK: - Initialization
    init(getUserUseCase: GetUserUseCaseProtocol = GetUserUseCase(api: GitHubAPIClient()),
         getRepositoriesUseCase: GetRepositoriesUseCaseProtocol = GetRepositoriesUseCase(api: GitHubAPIClient())) {
        self.getUserUseCase = getUserUseCase
        self.getRepositoriesUseCase = getRepositoriesUseCase
    }
    // MARK: - Methods
    func fetchUserAndRepositories(for username: String) async {
        // Reset error state before starting a new search
        errorMsg = ""
        showAlert = false
        self.user = nil
        self.repositories = []
        do {
            await toggleLoading()
            let fetchedUser = try await getUserUseCase.execute(request: username)
            self.user = fetchedUser
            let fetchedRepositories = try await getRepositoriesUseCase.execute(request: username)
            await toggleLoading()
            self.repositories = fetchedRepositories
        } catch let error as GitHubAPIError {
            await toggleLoading()
            errorMsg = error.errorDescription
            showAlert = true
        } catch {
            await toggleLoading()
            errorMsg = error.localizedDescription
            showAlert = true
        }
    }
    @MainActor func toggleLoading() {
        loading.toggle()
    }
}
