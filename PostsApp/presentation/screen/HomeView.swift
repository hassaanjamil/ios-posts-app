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
    private let appContainer: AppContainer

    init(viewModel: HomeViewModel,
         container: AppContainer) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.appContainer = container
    }

    var body: some View {
        NavigationStack {
            PostList(posts: viewModel.posts,
                     isLoading: viewModel.isLoading,
                     errorMessage: viewModel.errorMessage,
                     onRefresh: { await viewModel.loadPosts() },
                     onFavoriteTap: { postId in
                         viewModel.toggleFavorite(postId: postId)
                     },
                     postDetailViewBuilder: { post in
                         AnyView(PostDetailView(post: post,
                                                onFavoriteTap: {
                                                    viewModel.toggleFavorite(postId: post.id)
                                                },
                                                viewModel: appContainer.resolve(PostDetailViewModel.self)))
                     })
                .navigationTitle("Posts")
        }
        .task {
            await viewModel.loadPosts()
        }
    }
}
