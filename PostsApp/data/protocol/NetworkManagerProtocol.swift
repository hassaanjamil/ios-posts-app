//
//  NetworkManagerProtocol.swift
//  PostsApp
//
//  Created by Hassan Jamil on 05/10/2025.
//

protocol NetworkManagerProtocol {
    func getPosts() async throws -> [PostDto]
    func getUserById(_ userId: Int) async throws -> UserDto
    func getComments(postId: Int) async throws -> [CommentDto]
}
