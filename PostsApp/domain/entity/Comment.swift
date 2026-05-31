//
//  Post.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

struct Comment: Codable, Identifiable {
    let id: Int
    let body: String
    let postId: Int
    let userId: Int
//    var isActive: Bool? = false
}
