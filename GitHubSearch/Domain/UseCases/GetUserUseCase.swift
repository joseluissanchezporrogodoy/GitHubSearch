//
//  GetUserUseCase.swift
//  GitHubSearch
//
//  Created by JLSANCHEZP on 7/12/24.
//

import Foundation
import GitHubNetworking

/// A protocol defining the contract for fetching a GitHub user.
protocol GetUserUseCaseProtocol {
/// Fetches the details of a GitHub user.
///
/// - Parameter username: The username of the GitHub user to fetch.
/// - Returns: A `User` object containing the user's information.
/// - Throws: An error if the request fails.
func execute(request: String) async throws -> UserEntity
}

/// A concrete implementation of `GetUserUseCaseProtocol`.
struct GetUserUseCase: GetUserUseCaseProtocol {
    private let api: GitHubAPI

    init(api: GitHubAPI) {
        self.api = api
    }

    func execute(request: String) async throws -> UserEntity {
        return try await api.fetchUser(username: request).mapToUserEntity()
    }
}
