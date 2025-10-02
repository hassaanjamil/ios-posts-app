//
//  PostRepository.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//
class PostRepository: PostRepositoryProtocol {
    
    private let apiManager = APIManager.shared
    
    func getPosts() async -> [SPost] {
        do {
            let posts = try await apiManager.getPosts()
            return posts
        } catch {
            print("API: PostRepository:getPosts error \(error)")
            return []
        }
    }
}
