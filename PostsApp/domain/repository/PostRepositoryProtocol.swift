//
//  PostRepositoryProtocol.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

protocol PostRepositoryProtocol {
    func getPosts() async throws -> [PostDto]
}
