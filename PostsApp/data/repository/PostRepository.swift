//
//  PostRepository.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

final class PostRepository: PostRepositoryProtocol {    

    private let apiManager: NetworkManager

    init(apiManager: NetworkManager = .shared) {
        self.apiManager = apiManager
    }

    func getPosts() async throws -> [PostDto] {
        try await apiManager.getPosts()
    }
}
