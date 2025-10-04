//
//  PostViewModel.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

final class PostMapper: PostMapperProtocol {
    func toPost(posts: [PostDto]) -> [Post] {
        posts.map { post in
            Post(id: post.id, title: post.title, body: post.body, userId: post.userId, isFavorite: post.isFavorite)
        }
    }
    
    func toPostDto(posts: [Post]) -> [PostDto] {
        posts.map { post in
            PostDto(id: post.id, title: post.title, body: post.body, userId: post.userId, isFavorite: post.isFavorite)
        }
    }
}
