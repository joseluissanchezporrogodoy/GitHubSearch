//
//  RepositoryEntity.swift
//  GitHubSearch
//
//  Created by JLSANCHEZP on 9/12/24.
//
import Foundation

struct RepositoryEntity: Identifiable, Hashable {
    let id: UUID
    let name: String
    let language: String?
    init(id: UUID = UUID(), name: String, language: String? = nil) {
        self.id = id
        self.name = name
        self.language = language
    }
}
