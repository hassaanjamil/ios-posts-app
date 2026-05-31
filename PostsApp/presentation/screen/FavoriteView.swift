//
//  ProfileView.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

import SwiftUI

struct FavoriteView: View {
    @ObservedObject var viewModel: HomeViewModel
    let container: AppContainer

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.favoritePosts.isEmpty {
                    Text("No favorites")
                        .foregroundColor(.secondary)
                } else {
                    PostList(posts: viewModel.favoritePosts,
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
                                                        viewModel: container.resolve(PostDetailViewModel.self)))
                             })
                }
            }
            .navigationTitle("Favorites")
        }
    }
}
