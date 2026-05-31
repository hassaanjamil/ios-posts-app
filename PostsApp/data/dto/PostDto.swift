//
//  Post.swift
//  PostsApp
//
//  Created by Hassan Jamil on 02/10/2025.
//

struct PostDto: Codable, Identifiable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
    var isFavorite: Bool = false

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case body
        case userId
        case isFavorite
    }

    init(id: Int,
         title: String,
         body: String,
         userId: Int,
         isFavorite: Bool = false) {
        self.id = id
        self.title = title
        self.body = body
        self.userId = userId
        self.isFavorite = isFavorite
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        body = try container.decode(String.self, forKey: .body)
        userId = try container.decode(Int.self, forKey: .userId)
        isFavorite = try container.decodeIfPresent(Bool.self, forKey: .isFavorite) ?? false
    }
}
