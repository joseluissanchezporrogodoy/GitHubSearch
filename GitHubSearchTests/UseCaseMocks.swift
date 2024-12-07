//
//  UseCaseMocks.swift
//  GitHubSearch
//
//  Created by JLSANCHEZP on 7/12/24.
//

import Foundation
import GitHubNetworking
@testable import GitHubSearch

struct MockGetUserUseCase: GetUserUseCaseProtocol {
    var result: Result<User, Error>
    func execute(request: String) async throws -> User {
        switch result {
        case .success(let user):
            return user
        case .failure(let error):
            throw error
        }
    }
}

struct MockGetRepositoriesUseCase: GetRepositoriesUseCaseProtocol {
    var result: Result<[Repository], Error>
    func execute(request: String) async throws -> [Repository] {
        switch result {
        case .success(let repositories):
            return repositories
        case .failure(let error):
            throw error
        }
    }
}
