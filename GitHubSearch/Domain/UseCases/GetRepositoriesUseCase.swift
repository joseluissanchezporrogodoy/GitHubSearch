//
//  GetRepositoriesUseCase.swift
//  GitHubSearch
//
//  Created by JLSANCHEZP on 7/12/24.
//
import Foundation
import GitHubNetworking

/// A protocol defining the contract for fetching repositories of a GitHub user.
protocol GetRepositoriesUseCaseProtocol {
/// Fetches the repositories of a GitHub user.
///
/// - Parameter username: The username of the GitHub user.
/// - Returns: An array of `Repository` objects.
/// - Throws: An error if the request fails.
    func execute(request: String) async throws -> [RepositoryEntity]
}

/// A concrete implementation of `GetRepositoriesUseCaseProtocol`.
struct GetRepositoriesUseCase: GetRepositoriesUseCaseProtocol {
    private let api: GitHubAPI

    init(api: GitHubAPI) {
        self.api = api
    }

    func execute(request: String) async throws -> [RepositoryEntity] {
        return try await api.fetchRepositories(username: request).map { $0.mapToRepositoryEntity() }
    }
}
