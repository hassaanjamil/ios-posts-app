//
//  PostRepository.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

protocol PostRepository {
    func getPosts() -> [Post]
    func getPostById(postId: Int) -> Post
    func getFavoritePosts() -> [Post]
    func saveFavorite(post: Post)
    func deleteFavorite(postId: Int)
}
