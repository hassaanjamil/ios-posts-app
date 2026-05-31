//
//  PostDetailView.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

import SwiftUI

struct PostDetailView: View {
    let post: Post
    let onFavoriteTap: () -> Void

    @StateObject private var viewModel: PostDetailViewModel
    @State private var isFavorite: Bool

    init(post: Post,
         onFavoriteTap: @escaping () -> Void,
         viewModel: PostDetailViewModel) {
        self.post = post
        self.onFavoriteTap = onFavoriteTap
        _viewModel = StateObject(wrappedValue: viewModel)
        _isFavorite = State(initialValue: post.isFavorite)
    }

    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 12) {
                    Text(post.title)
                        .font(.title3.weight(.semibold))
                    Text(post.body)
                        .font(.body)
                        .foregroundColor(.secondary)

                    Button(action: {
                        isFavorite.toggle()
                        onFavoriteTap()
                    }) {
                        Label(isFavorite ? "Remove from Favorites" : "Add to Favorites",
                              systemImage: isFavorite ? "heart.fill" : "heart")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(isFavorite ? .red : .accentColor)
                }
                .padding(.vertical, 4)
            } header: {
                Text("Post")
            }

            Section {
                if let user = viewModel.user {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(user.name)
                            .font(.headline)
                        Text("@\(user.username)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 4)
                } else if viewModel.isLoading {
                    ProgressView()
                } else {
                    Text("User details not available")
                        .foregroundColor(.secondary)
                }
            } header: {
                Text("Author")
            }

            Section {
                if viewModel.comments.isEmpty {
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Text("No comments")
                            .foregroundColor(.secondary)
                    }
                } else {
                    ForEach(viewModel.comments) { comment in
                        Text(comment.body)
                            .font(.body)
                            .padding(.vertical, 4)
                    }
                }
            } header: {
                Text("Comments")
            }

            if let errorMessage = viewModel.errorMessage {
                Section {
                    Text(errorMessage)
                        .font(.footnote)
                        .foregroundColor(.red)
                }
            }
        }
        .navigationTitle("Post Details")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.load(post: post)
        }
    }
}
