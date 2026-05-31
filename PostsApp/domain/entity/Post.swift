//
//  Post.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

struct Post: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
    var isFavorite: Bool = false
}
