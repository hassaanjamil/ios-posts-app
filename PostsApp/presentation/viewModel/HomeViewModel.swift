//
//  HomeViewModel.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {

    @Published private(set) var posts: [Post] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?

    private let getPostsUseCase: GetPostsUseCaseProtocol
    private let getFavoritePostIdsUseCase: GetFavoritePostIdsUseCaseProtocol
    private let toggleFavoritePostUseCase: ToggleFavoritePostUseCaseProtocol
    private let postMapper: PostMapperProtocol

    init(getPostsUseCase: GetPostsUseCaseProtocol,
         getFavoritePostIdsUseCase: GetFavoritePostIdsUseCaseProtocol,
         toggleFavoritePostUseCase: ToggleFavoritePostUseCaseProtocol,
         postMapper: PostMapperProtocol) {
        self.getPostsUseCase = getPostsUseCase
        self.getFavoritePostIdsUseCase = getFavoritePostIdsUseCase
        self.toggleFavoritePostUseCase = toggleFavoritePostUseCase
        self.postMapper = postMapper
    }

    var favoritePosts: [Post] {
        posts.filter(\.isFavorite)
    }

    func loadPosts() async {
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil

        do {
            let postDtos = try await getPostsUseCase.execute()
            let favoriteIds = getFavoritePostIdsUseCase.execute()
            self.posts = postMapper.toPost(posts: postDtos).map { post in
                var mutablePost = post
                mutablePost.isFavorite = favoriteIds.contains(post.id)
                return mutablePost
            }
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func toggleFavorite(postId: Int) {
        guard let index = posts.firstIndex(where: { $0.id == postId }) else {
            return
        }

        let nextFavorite = !posts[index].isFavorite
        posts[index].isFavorite = nextFavorite
        toggleFavoritePostUseCase.execute(postId: postId, isFavorite: nextFavorite)
    }
}
