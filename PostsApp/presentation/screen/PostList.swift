//
//  PostList.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

import SwiftUI

struct PostList: View {
    let posts: [Post]
    let isLoading: Bool
    let errorMessage: String?
    let onRefresh: () async -> Void
    let onFavoriteTap: (Int) -> Void
    let postDetailViewBuilder: (Post) -> AnyView

    @State private var selectedPost: Post?

    var body: some View {
        content
    }

    @ViewBuilder
    private var content: some View {
        if posts.isEmpty {
            emptyState
        } else {
            listContent
        }
    }

    @ViewBuilder
    private var emptyState: some View {
        if isLoading {
            ProgressView("Loading posts...")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if let errorMessage {
            ErrorView(message: errorMessage, onRetry: onRefresh)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            Text("No posts available")
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    private var listContent: some View {
        List(posts) { post in
            CardView(cornerRadius: 10) {
                HStack(alignment: .top, spacing: 12) {
                    Button {
                        selectedPost = post
                    } label: {
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

                    Button(action: {
                        onFavoriteTap(post.id)
                    }) {
                        Image(systemName: post.isFavorite ? "heart.fill" : "heart")
                            .font(.title3)
                            .foregroundColor(post.isFavorite ? .red : .gray)
                    }
                    .buttonStyle(.plain)
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
        .refreshable { await onRefresh() }
        .navigationDestination(item: $selectedPost) { post in
            postDetailViewBuilder(post)
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
