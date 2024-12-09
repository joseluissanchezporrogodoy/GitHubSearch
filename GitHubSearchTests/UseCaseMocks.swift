//
//  UseCaseMocks.swift
//  GitHubSearch
//
//  Created by JLSANCHEZP on 7/12/24.
//

import Foundation
@testable import GitHubSearch

struct MockGetUserUseCase: GetUserUseCaseProtocol {
    var result: Result<UserEntity, Error>
    func execute(request: String) async throws -> UserEntity {
        switch result {
        case .success(let user):
            return user
        case .failure(let error):
            throw error
        }
    }
}

struct MockGetRepositoriesUseCase: GetRepositoriesUseCaseProtocol {
    var result: Result<[RepositoryEntity], Error>
    func execute(request: String) async throws -> [RepositoryEntity] {
        switch result {
        case .success(let repositories):
            return repositories
        case .failure(let error):
            throw error
        }
    }
}
