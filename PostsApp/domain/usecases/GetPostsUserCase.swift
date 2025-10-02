//
//  GetPostsUserCase.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

class GetPostsUseCase {
    private let postRepository: PostRepositoryProtocol

    init(postRepository: PostRepositoryProtocol) {
        self.postRepository = postRepository
    }

    func execute(id: String, completion: @escaping (Result<SPost, Error>) -> Void) async -> [SPost] {
        return await postRepository.getPosts()
    }
}
