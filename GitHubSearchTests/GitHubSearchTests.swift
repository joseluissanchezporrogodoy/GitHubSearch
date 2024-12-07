//
//  GitHubSearchTests.swift
//  GitHubSearchTests
//
//  Created by JLSANCHEZP on 7/12/24.
//

import Testing
import GitHubNetworking
@testable import GitHubSearch
struct GitHubSearchTests {

    // Test: Successful case when fetching a user and their repositories
    @Test func testFetchUserAndRepositoriesSuccess() async throws {
        // Arrange
        let mockUser = User(login: "octocat", avatarUrl: "https://example.com/avatar.png", name: "The Octocat")
        let mockRepositories = [
            Repository(name: "Repo1", language: "Swift"),
            Repository(name: "Repo2", language: "Python")
        ]
        let getUserUseCase = MockGetUserUseCase(result: .success(mockUser))
        let getRepositoriesUseCase = MockGetRepositoriesUseCase(result: .success(mockRepositories))
        let viewModel = UserRepositoriesViewModel(
            getUserUseCase: getUserUseCase,
            getRepositoriesUseCase: getRepositoriesUseCase
        )
        // Act
        await viewModel.fetchUserAndRepositories(for: "octocat")
        // Assert
        #expect(viewModel.user?.login == "octocat")
        #expect(viewModel.repositories.count == 2)
        #expect(viewModel.repositories.first?.name == "Repo1")
        #expect(viewModel.showAlert == false)
        #expect(viewModel.errorMsg.isEmpty)
    }

    // Test: Error case when the user is not found
    @Test func testFetchUserAndRepositoriesUserNotFound() async throws {
        // Arrange
        let getUserUseCase = MockGetUserUseCase(result: .failure(GitHubAPIError.userNotFound))
        let getRepositoriesUseCase = MockGetRepositoriesUseCase(result: .success([]))
        let viewModel = UserRepositoriesViewModel(
            getUserUseCase: getUserUseCase,
            getRepositoriesUseCase: getRepositoriesUseCase
        )
        // Act
        await viewModel.fetchUserAndRepositories(for: "nonexistent")
        // Assert
        #expect(viewModel.user == nil)
        #expect(viewModel.repositories.isEmpty)
        #expect(viewModel.showAlert == true)
        #expect(viewModel.errorMsg == GitHubAPIError.userNotFound.errorDescription)
    }

    // Test: Error case when a network issue occurs
    @Test func testFetchUserAndRepositoriesNetworkError() async throws {
        // Arrange
        let getUserUseCase = MockGetUserUseCase(result: .failure(GitHubAPIError.networkError))
        let getRepositoriesUseCase = MockGetRepositoriesUseCase(result: .failure(GitHubAPIError.networkError))
        let viewModel = UserRepositoriesViewModel(
            getUserUseCase: getUserUseCase,
            getRepositoriesUseCase: getRepositoriesUseCase
        )
        // Act
        await viewModel.fetchUserAndRepositories(for: "network_error_user")
        // Assert
        #expect(viewModel.user == nil)
        #expect(viewModel.repositories.isEmpty)
        #expect(viewModel.showAlert == true)
        #expect(viewModel.errorMsg == GitHubAPIError.networkError.errorDescription)
    }

    // Test: Validate the loading state during execution
    @Test func testLoadingState() async throws {
        // Arrange
        let mockUser = User(login: "octocat", avatarUrl: "https://example.com/avatar.png", name: "The Octocat")
        let mockRepositories = [
            Repository(name: "Repo1", language: "Swift"),
            Repository(name: "Repo2", language: "Python")
        ]
        let getUserUseCase = MockGetUserUseCase(result: .success(mockUser))
        let getRepositoriesUseCase = MockGetRepositoriesUseCase(result: .success(mockRepositories))
        let viewModel = UserRepositoriesViewModel(
            getUserUseCase: getUserUseCase,
            getRepositoriesUseCase: getRepositoriesUseCase
        )
        // Act
        #expect(!viewModel.loading) // Initial loading state should be false
        await viewModel.fetchUserAndRepositories(for: "octocat")
        // Assert
        #expect(!viewModel.loading) // Loading state should return to false after fetch
    }
}
