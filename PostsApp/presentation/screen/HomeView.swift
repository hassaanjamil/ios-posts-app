//
//  HomeView.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

import SwiftUI

@MainActor
struct HomeView: View {

    @StateObject private var viewModel: HomeViewModel

    init(viewModel: HomeViewModel? = nil,
         container: AppContainer) {
        if let viewModel {
            _viewModel = StateObject(wrappedValue: viewModel)
        } else {
            _viewModel = StateObject(wrappedValue: container.resolve(HomeViewModel.self))
        }
    }

    var body: some View {
        NavigationStack {
            PostList(posts: viewModel.posts,
                     isLoading: viewModel.isLoading,
                     errorMessage: viewModel.errorMessage,
                     onRefresh: { await viewModel.loadPosts() })
                .navigationTitle("Posts")
        }
        .task {
            await viewModel.loadPosts()
        }
    }
}
