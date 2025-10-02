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

    private let getPostsUseCase: GetPostsUseCase
    private let postMapper: PostMapper

    init(getPostsUseCase: GetPostsUseCase,
         postMapper: PostMapper = PostMapper()) {
        self.getPostsUseCase = getPostsUseCase
        self.postMapper = postMapper
    }

    func loadPosts() async {
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil

        do {
            let posts = try await getPostsUseCase.execute()
            self.posts = postMapper.toPost(posts: posts)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
