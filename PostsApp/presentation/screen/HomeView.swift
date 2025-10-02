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
            content
                .navigationTitle("Posts")
        }
        .task {
            await viewModel.loadPosts()
        }
    }

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading && viewModel.posts.isEmpty {
            ProgressView("Loading posts...")
        } else if let error = viewModel.errorMessage, viewModel.posts.isEmpty {
            VStack(spacing: 16) {
                Text("Something went wrong")
                    .font(.headline)
                Text(error)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                Button("Retry") {
                    Task { await viewModel.loadPosts() }
                }
            }
            .padding()
        } else {
            List(viewModel.posts) { post in
                CardView(cornerRadius: 12) {
                  NavigationLink(destination: PostDetailView(item: post.id)) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(post.title)
                            .font(.headline)
                            .foregroundColor(.primary)
                        Text(post.body)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                    }
                    .padding(.vertical, 4)
                  }
                  .buttonStyle(CardNavigationLinkStyle())
                  .listRowSeparator(.hidden)
                  .listRowBackground(Color.clear)
                }
                
            }
            .listStyle(.plain)
            .refreshable {
                await viewModel.loadPosts()
            }
        }
    }
}

private struct CardNavigationLinkStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.85 : 1)
            .animation(.easeInOut(duration: 0.12), value: configuration.isPressed)
    }
}
