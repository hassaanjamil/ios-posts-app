//
//  GetPostsUseCase.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

final class GetPostsUseCase {
    private let postRepository: PostRepositoryProtocol

    init(postRepository: PostRepositoryProtocol) {
        self.postRepository = postRepository
    }

    func execute() async throws -> [PostDto] {
        try await postRepository.getPosts()
    }
}
