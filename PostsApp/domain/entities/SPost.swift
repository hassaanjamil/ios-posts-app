//
//  Post.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

struct SPost: Codable, Identifiable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
}
