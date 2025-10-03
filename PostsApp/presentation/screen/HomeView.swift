//
//  HomeView.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

import SwiftUI

struct HomeView: View {

    @StateObject private var viewModel: HomeViewModel

    init(viewModel: HomeViewModel? = nil) {
        if let viewModel {
            _viewModel = StateObject(wrappedValue: viewModel)
        } else {
            let repository = PostRepository()
            let useCase = GetPostsUseCase(postRepository: repository)
            _viewModel = StateObject(wrappedValue: HomeViewModel(getPostsUseCase: useCase))
        }
    }

    var body: some View {
        NavigationStack {
            PostList(posts: viewModel.posts,
                     isLoading: viewModel.isLoading,
                     errorMessage: viewModel.errorMessage,
                     onRefresh: { await viewModel.loadPosts() })
        }
        .task {
            await viewModel.loadPosts()
        }
    }
}
