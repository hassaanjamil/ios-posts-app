//
//  GetPostsUseCase.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

protocol GetPostsUseCaseProtocol {
    func execute() async throws -> [PostDto]
}

final class GetPostsUseCase: GetPostsUseCaseProtocol {
    private let postRepository: PostRepositoryProtocol

    init(postRepository: PostRepositoryProtocol) {
        self.postRepository = postRepository
    }

    func execute() async throws -> [PostDto] {
        try await postRepository.getPosts()
    }
}
