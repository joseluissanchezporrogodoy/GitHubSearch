//
//  WaitingView.swift
//  GitHubSearch
//
//  Created by JLSANCHEZP on 7/12/24.
//

import SwiftUI

struct WaitingView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThinMaterial)
#if os(iOS)
            ProgressView()
                .controlSize(.extraLarge)
#elseif os(tvOS)
            ProgressView()
#endif
        }
        .ignoresSafeArea()
    }
}

struct Waiting: ViewModifier {
    @Binding var loading: Bool
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay {
                if loading {
                    WaitingView()
                }
            }
            .animation(.default, value: loading)
    }
}

extension View {
    func waiting(loading: Binding<Bool>) -> some View {
        modifier(Waiting(loading: loading))
    }
}

#Preview {
    WaitingView()
}
