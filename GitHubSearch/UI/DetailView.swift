//
//  DetailView.swift
//  GitHubSearch
//
//  Created by JLSANCHEZP on 7/12/24.
//

import SwiftUI

struct DetailView: View {
    @State var viewModel: UserRepositoriesViewModel
    @FocusState private var focusedItem: String? // Estado de foco para identificar el primer ítem
    var body: some View {
        ZStack {
#if os(iOS)
            Color(UIColor.systemGray6)
                .ignoresSafeArea()
#endif
            VStack {
                if let user = viewModel.user {
                    // User Profile Section
                    VStack {
                        AsyncImage(url: URL(string: user.avatarUrl ?? "")) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .padding(.bottom, 8)
                        Text(user.name ?? "Unknown User")
                            .font(.title3)
                            .bold()
                    }
                    .padding()
                }
                // Repositories List
                List(viewModel.repositories, id: \.name) { repo in
                    VStack(alignment: .leading) {
                        Text(repo.name)
                            .font(.headline)
                            .foregroundColor(.black)
                        Text(repo.language ?? "Unknown Language")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
#if os(iOS)
                    .listRowBackground(
                               Color(UIColor.secondarySystemGroupedBackground)
                                   .overlay(alignment: .bottom) {
                                       Divider()
                                           .frame(maxWidth: .infinity)
                                   }
                           )
#endif
                    .focusable(true)
                    .focused($focusedItem, equals: repo.name)
                }
                .listStyle(PlainListStyle())
                .frame(maxWidth: .infinity)
                .background(Color.white)
            }
            .frame(maxWidth: .infinity)
#if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.clear, for: .navigationBar) // Barra transparente
#elseif os(tvOS)
            .navigationBarBackButtonHidden()
#endif
            .onAppear {
#if os(tvOS)
                focusedItem = viewModel.repositories.first?.name
#endif
            }
        }
    }
}

#Preview {
    let mockUser = UserEntity(
        id: UUID(),
        name: "Test User",
        login: "testuser",
        avatarUrl: "ttps://avatars.githubusercontent.com/u/14358318?v=4"
    )
    let mockRepositories = [
        RepositoryEntity(name: "Repo1", language: "Swift"),
        RepositoryEntity(name: "Repo1", language: "Swift"),
        RepositoryEntity(name: "Repo1", language: "Swift"),
        RepositoryEntity(name: "Repo1", language: "Swift")
    ]
    let viewModel = UserRepositoriesViewModel(
            user: mockUser,
            repositories: mockRepositories
    )
    DetailView(viewModel: viewModel)
}
