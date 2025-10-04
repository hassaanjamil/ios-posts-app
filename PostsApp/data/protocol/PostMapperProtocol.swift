//
//  PostMapperProtocol.swift
//  PostsApp
//
//  Created by Hassan Jamil on 05/10/2025.
//

protocol PostMapperProtocol {
    func toPost(posts: [PostDto]) -> [Post]
    func toPostDto(posts: [Post]) -> [PostDto]
}
