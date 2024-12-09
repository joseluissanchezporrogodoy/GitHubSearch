//
//  Mappers.swift
//  GitHubSearch
//
//  Created by JLSANCHEZP on 9/12/24.
//

import GitHubNetworking

extension User {
    func mapToUserEntity() -> UserEntity {
        UserEntity(name: self.name, login: self.login, avatarUrl: self.avatarUrl)
    }
}

extension Repository {
    func mapToRepositoryEntity() -> RepositoryEntity {
        RepositoryEntity(name: self.name, language: self.language)
    }
}
