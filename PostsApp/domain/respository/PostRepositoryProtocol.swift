//
//  PostRepository.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

protocol PostRepositoryProtocol {
    func getPosts() async -> [SPost]
//    func getPostById(postId: Int) -> SPost
//    func getFavoritePosts() -> [SPost]
//    func saveFavorite(post: SPost)
//    func deleteFavorite(postId: Int)
}
