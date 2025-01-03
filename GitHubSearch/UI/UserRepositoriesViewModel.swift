//
//  UserRepositoriesViewModel.swift
//  GitHubSearch
//
//  Created by JLSANCHEZP on 7/12/24.
//

import SwiftUI
import GitHubNetworking

final class UserRepositoriesViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var user: UserEntity?
    @Published var repositories: [RepositoryEntity]
    @Published var showAlert = false
    @Published var errorMsg = ""
    @Published var loading = false
    // MARK: - Dependencies
    private let getUserUseCase: GetUserUseCaseProtocol
    private let getRepositoriesUseCase: GetRepositoriesUseCaseProtocol
    // MARK: - Initialization
    init(getUserUseCase: GetUserUseCaseProtocol = GetUserUseCase(api: GitHubAPIClient()),
         getRepositoriesUseCase: GetRepositoriesUseCaseProtocol = GetRepositoriesUseCase(api: GitHubAPIClient()),
         user: UserEntity? = nil,
         repositories: [RepositoryEntity] = []) {
        self.getUserUseCase = getUserUseCase
        self.getRepositoriesUseCase = getRepositoriesUseCase
        self.user = user
        self.repositories = repositories
    }
    // MARK: - Methods
    func fetchUserAndRepositories(for username: String) async {
        // Reset error state before starting a new search
        await MainActor.run {
            errorMsg = ""
            showAlert = false
            self.user = nil
            self.repositories = []
        }
        do {
            await toggleLoading()
            let fetchedUser = try await getUserUseCase.execute(request: username)
            let fetchedRepositories = try await getRepositoriesUseCase.execute(request: username)
            await toggleLoading()
            // Actualizaciones en el hilo principal
            await MainActor.run {
                self.user = fetchedUser
                self.repositories = fetchedRepositories
            }

        } catch let error as GitHubAPIError {
            await toggleLoading()
            await MainActor.run {
                errorMsg = error.errorDescription
                showAlert = true
            }
        } catch {
            await toggleLoading()
            await MainActor.run {
                errorMsg = error.localizedDescription
                showAlert = true
            }
        }
    }
    @MainActor func toggleLoading() {
        loading.toggle()
    }
}
