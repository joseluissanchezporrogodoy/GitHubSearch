//
//  UserEntity.swift
//  GitHubSearch
//
//  Created by JLSANCHEZP on 9/12/24.
//
import Foundation

struct UserEntity: Identifiable, Hashable {
    let id: UUID
    let name: String?
    let login: String
    let avatarUrl: String?
    init(id: UUID = UUID(), name: String? = nil, login: String, avatarUrl: String? = nil) {
        self.id = id
        self.name = name
        self.login = login
        self.avatarUrl = avatarUrl
    }
}
