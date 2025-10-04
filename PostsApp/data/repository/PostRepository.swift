//
//  PostRepository.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

final class PostRepository: PostRepositoryProtocol {

    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    func getPosts() async throws -> [PostDto] {
        try await networkManager.getPosts()
    }
}
