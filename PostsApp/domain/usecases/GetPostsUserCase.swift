//
//  GetPostsUserCase.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

class GetPostsUseCase {
    private let postRepository: PostRepository

    init(postRepository: PostRepository) {
        self.postRepository = postRepository
    }

    func execute(id: String, completion: @escaping (Result<SPost, Error>) -> Void) -> [SPost] {
        return postRepository.getPosts()
    }
}
